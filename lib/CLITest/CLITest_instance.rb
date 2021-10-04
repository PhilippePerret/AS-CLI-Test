# encoding: UTF-8
# frozen_string_literal: true

=begin

  Instance CLITest, donc les Cases des tests

=end

class CLITest

attr_reader :name
attr_reader :location # fichier et ligne
attr_reader :full_stack # le backtrace complet

def initialize(path, run_it = true, &block)
  
  if CLITest.fully_documented?
    # Affichage du nom du test
    if run_it
      CLITest::UI.write_test_title(name)
    else
      # TODO : il faut plutôt mémoriser les tests écartés
      # puts "\n*** Test : #{name} — écarté. ***".jaune
    end
  end
  return unless run_it


  @location = path

  # Pour que le parent connaisse le test courant
  # (mais ce n'est pas propre… Et je crois que ça ne sert à rien
  #  pour le moment)
  # self.class.current = self

  # Pour s'interrompre en cas de failure
  @interruption_on_failure = true

  begin
    instance_eval do
      require path
    end
  rescue InterruptionOnFailure => e
    # Ne rien faire, passer au test suivant
  rescue Exception => e
    # On doit nettoyer la console
    UI.clear_screen_down
    puts "\n\n\nERREUR SYSTÉMIQUE : #{e.message}".rouge
    puts e.backtrace.join("\n").rouge
    raise ForceCLITestInterruption.new('Interruption des tests')
  end

end

##
# = main =
#
# La méthode principale qui joue un test donné.
# 
# +returned_lines_count+ {Integer} Nombre de lignes affichées qui 
#       doivent être retournées en partant de la fin. Si nil, on
#       retourne toute la fenêtre.
#       C'est utile lorsque la fenêtre peut contenir des informa-
#       tion contradictoires.
# 
def run(cmd, keys = nil, returned_lines_count = nil)

  # 
  # Transformer les touches pour AppleScript
  # 
  # puts "\n\nkeys avant keys_to_applescript_args : #{keys.inspect} "
  args = CodeKey.keys_to_applescript_args(keys)
  args = args.join(",")

  # puts "ARGS intermédiaire : #{args.inspect}"
  # exit

  # 
  # Finaliser les arguments en ajoutant la commande et le
  # nom de la fenêtre
  #
  # Noter qu'on strip la commande complète (full_command) car 
  # app_main_command peut être vide (ou cmd ?)
  # 
  full_command = "#{CLITest.app_main_command} #{cmd}".strip
  args = "{'#{full_command}',#{Config[:keys_speed]},#{args}}"
  
  # puts "\nARGS FINAUX :\n#{args.inspect}\n\n"
  # exit
  
  res = `cd "#{__dir__}"; osascript run.scpt #{args}`

  # puts "RETOUR BRUT DE run.scpt : #{res.inspect}"

  if res == ""
    erreur "Bizarrement, le retour de run.scpt est vide, ce qui ne devrait jamais arriver…"
    return ""
  end

  lines = res.strip.split("\n").collect do |line|
    line
  end

  # # débug
  # puts '«'*30
  # puts lines.join("\n")
  # puts '»'*30

  unless returned_lines_count.nil?
    # puts "Je dois prendre les lines de -#{returned_lines_count} à la fin dans #{lines.inspect}"
    if lines.count > returned_lines_count
      lines = lines[-returned_lines_count..-1]
    end
    # puts "lines à remonter = #{lines.inspect}"
  end

  @resultat = lines.join("\n")

  return @resultat
end #/run

def expect(sujet, designation = nil)
  Expectation.new(self, sujet, designation)
end

##
# Pour mettre l'état des données voulues
# 
def degel(name)
  class_gels?
  CLITest::Gels.degel(name)
end

def gel(name, description = nil)
  class_gels?
  CLITest::Gels.gel(name, description)
end

def class_gels?
  if not defined?(CLITest::Gels)
    raise "La classe 'CLITest::Gels' n'est pas définie."
  end
  if not CLITest::Gels.respond_to?(:degel)
    raise "La class CLITest::Gels ne répond pas à la méthode 'degel(<name>)'."
  end
rescue Exception => e
  msg = []
  msg << e.backtrace.join("\n") if verbose?
  msg << "#{e.message} Je ne peux pas dégeler l'état '#{name}'. Consulter le manuel."
  raise ForceCLITestInterruption, msg
end

##
# Le temps de pause entre la question posée et la réponse donnée
# (augmenter ce temps pour avoir un effet plus "direct")
# 
def step_pause(delai = nil)
  if delai.nil?
    @step_pause || 0
  else
    @step_pause = delai
  end
end

##
# Pour encadrer une opération d'un message d'attente et d'un
# message de conclusion
#
def with_waiting_message(waiting_msg = nil, &block)
  MessageSubstitution.new(self, waiting_msg, &block)
end

def resultat
  @resultat
end
def resultat=(value)
  @resultat = value
end

##
# Pour pouvoir modifier la vitesse des touches en cours de test
# 
# Noter que ça ne peut se faire qu'entre deux runs. Un run s'effectue
# forcément à la même vitesse
#
# Ne rien mettre en argument pour revenir à la vitesse initiale
def keys_speed(speed = nil)
  if speed.nil?
    if @speed_initiale.nil?
      erreur(ERRORS[:no_speed_initiale])
    else
      speed = @speed_initiale
    end
  else
    @speed_initiale ||= CLITest::Config[:keys_speed]
  end
  CLITest::Config[:keys_speed] = speed
end

##
# Pour ne pas interrompre le cas même en cas de failure
#
def interruption_on_failure(valeur = nil)
  if valeur === false
    @interruption_on_failure = false
  end
  @interruption_on_failure
end

##
# Méthode qui affine et retourne le chemin au test pris du backtrace
# pour l'obtenir
# 
def affine_location
  idx = location.rindex(':in')
  @location = location[0...idx]
  @location = @location.sub(/^#{File.expand_path('.')}\/commands/,'.')
end

end #/class CLITest
