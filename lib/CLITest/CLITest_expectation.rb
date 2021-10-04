# encoding: UTF-8
# frozen_string_literal: true
=begin
  
  Class CLITest::Expectation
  --------------------------
  Pour gérer les attentes de résultat

=end
require_relative 'CLITest'

class CLITest::Expectation
  
  attr_reader :clitest # l'instance CLITest du test
  attr_reader :sujet # le sujet étudié
  attr_reader :expected # le résultat attendu
  attr_reader :positif # pour les négations
  attr_reader :ok # le résultat définitif
  attr_reader :options

def initialize(clitest, sujet, designation = nil)
  @clitest  = clitest
  @sujet    = sujet
  @h_sujet  = designation
  @positif  = true
end

def defaultize_options(opts)
  opts ||= {}
  opts.merge!(strict: true) unless opts.key?(:strict)
  @options = opts
end

##
# Pour inverser la condition avec .not
# 
# @example
# 
#   expect(sujet).not.contains(valeur)
#
# @return self (pour le chainage)
def not
  @positif = false
  return self
end


##
# Test de l'appartenance
# 
# @syntaxe
# 
#   expect(sujet).contains(expected[, {options}])
# 
def contains(expected, options = nil)
  defaultize_options(options)
  @expected = expected

  @affirmation = "#{h_sujet} contient #{h_expected}" # pourra être modifié
  @ok = is_contained_by(expected, sujet, h_expected, h_sujet)
  evaluate

end  #/ contains

##
# Test inverse d'appartenance
#
def in(expected, options = nil)
  defaultize_options(options)

  @expected = expected

  @affirmation = "#{h_sujet} est contenu dans #{h_expected}"
  @ok = is_contained_by(sujet, expected, h_sujet, h_expected)
  evaluate

end

##
# Méthode utilisé par :contains et :in pour tester l'appartenance
# 
def is_contained_by(contenu, contenant, h_contenu, h_contenant)
  case contenant
  
  when String

    # 
    # :contains, cas d'un contenant String
    # 

    ok, verbe = case contenu
    when String then [positif == contenant.include?(contenu), 'contient']
    when Regexp then [positif == contenant.match?(contenu), 'matche']
    end
    affirmation("#{h_contenant} #{verbe} #{h_contenu} ?")
  
  when Array

    #
    # :contains, cas d'un contenant Array
    #

    if verbose?
      puts "\n\nQUESTION ARRAY : est-ce que\n\n#{contenant.inspect}\n\n…contient :\n\n#{contenu.inspect}\n\n ?/QUESTION ARRAY"
    end

    ok = 
      case contenu
      when Hash
        puts "La question est complexe avec un Hash en contenu…" if verbose?
        found = false
        contenant.each do |item|
          if is_matching(item, contenu)
            found = true
            break
          end
        end
        positif == found
      else
        positif == contenant.include?(contenu)
      end

  when Hash

    #
    # :contains, cas d'un contenant Hash
    #

    if verbose?
      puts "\n\nQUESTION HASH : est-ce que :\n\n#{contenant.inspect}\n\n… contient :\n\n#{contenu.inspect}\n\n/QUESTION HASH"
    end
    ok = positif == is_matching(contenant, contenu)

  when Range

    contenu.is_a?(Integer) || contenu.is_a?(Float) || raise("Il faut fournir un nombre pour l'expectation : Range.contains.")

    ok = positif == contenant.include?(contenu)

  when File

    # 
    # Cas d'un contenant File (fichier/dossier)
    # 

    if File.directory?(contenant.path)
      contenu  = contenu.path if contenu.is_a?(File)
      extension = File.extname(contenu).downcase
      deepness  = options[:deep] ? '/**' : ''
      names = 
        if extension.nil?
          Dir["#{contenant.path}#{deepness}/*"]
        else
          Dir["#{contenant.path}#{deepness}/*#{extension}"]
        end.collect{|p|File.basename(p)}
      ok = positif == names.include?(contenu)
      affirmation("#{h_contenant} contient le fichier #{h_contenu}")
    else
      extension = File.extname(contenant).downcase
      contenant =
        case extension
        when '.yaml', '.yml'
          YAML.load_file(contenant.path)
        when '.json'
          JSON.parse(contenant.read)
        else
          contenant.read.force_encoding('utf-8')
        end
      unless h_contenant.nil?
        # h_contenant est nil, par exemple, lorsqu'une expectation 
        # utilise cette méthode à l'intérieur d'elle-même comme c'est
        # le cas par exemple avec :contains pour un fichier YAML qui
        # ensuite utilise cette méthode :is_contained_by avec ses
        # données (cf. ci-dessous)
        affirmation("#{h_contenant} contient #{h_contenu}")
      end
      if verbose?
        puts "\nQUESTION FICHIER : est-ce que :\n\n#{contenant.inspect}\n\n… contient :\n\n#{contenu.inspect}\n\n ?\n/QUESTION\n\n"
      end
      ok = 
        case extension
        when '.yaml', '.yml', '.json', '.js'
          positif == is_contained_by(contenu, contenant, nil, nil)
        else
          positif == contenant.include?(contenu)
        end
    end

  else

    # 
    # Cas d'un type inconnu de contenant
    # 

    erreur "Je ne sais pas traiter la méthode 'contains' pour un type de contenant #{contenant.class}."

  end

  return ok
end

##
# Test de l'égalité
# -----------------
# alias :eq, :equal
#
def equals(expected, options = nil)
  
  defaultize_options(options)
  @expected = expected

  case sujet

  when String

    #
    # :equals, cas d'un string
    #

    exp = options[:strict] ? expected.dup : expected.to_s
    if options[:strict]
      ok = positif == (sujet == exp)
    else
      ok = positif == (sujet.downcase == exp.downcase)
    end

  when Integer, Float

    # 
    # :equals, cas d'un nombre
    # 

    ok = positif == ( sujet == expected )

  when Array

    # 
    # :equals, cas d'une liste
    # 

    if options[:strict]
      ok = positif == ( sujet == expected )
    else
      ok = sujet.count == expected.count
      ok = ok && begin
        r = true
        sujet.each do |i|
          if not expected.include?(i)
            r = false
            break
          end
        end
        r
      end

      ok = ok == positif
    end

  when Hash

    #
    # :equals, cas d'une table
    # 

    ok = sujet.count == expected.count
    ok = ok && begin
        r = true
        sujet.each do |k, v|
          if expected[k] != v
            r = false
            break
          end
        end
        r
      end
    ok = ( positif == ok )

  when TrueClass, FalseClass, NilClass

    #
    # :equals, cas d'un booléen
    #

    ok = 
      if options[:strict]
        positif == ( sujet === expected )
      else
        positif == ( sujet == expected )
      end

  else

    CLITest.add_failure("Je ne sais pas traiter le cas d'un #{sujet.class} (#{h_sujet}) pour l'égalité.")
    return

  end

  @affirmation ||= begin
    msg = "#{h_sujet} est égal à #{h_expected}"
    msg = "#{msg} (en fait il vaut #{sujet})" if !ok && positif 
    msg
  end
  @ok = ok
  evaluate

end
alias :equal :equals
alias :eq :equals

## 
# Test de match
# -------------
#
# @syntax
#
#   expect(<string>).match(<regexp>)
#
def match(expected, options = nil)

  defaultize_options(options)
  @expected = expected

  sujet.is_a?(String)     || raise("L'expectation :match ne s'utilise qu'avec les String")  
  expected.is_a?(Regexp)  || raise("L'expectation :match attend une expression régulière")

  ok = positif == sujet.match?(expected)

  @affirmation ||= "#{h_sujet} matche #{h_expected}"
  @ok = ok
  evaluate

end

##
# @return true si +echantillon+ correspond à +comparaison+
#
# Exemples : 
#   - retourne true si comparaison = "Ceci est mon texte"
#     et que echantillon = "mon texte"
#   - retourne true si comparaison = {n:"Nom", i:"Integer", f:"float"}
#     et que ehantillon = {i:"Integer"}
#
def is_matching(comparaison, echantillon)
  if verbose?
    puts "\n\nQUESTION is_matching : est-ce que :\n\n#{comparaison.inspect}\n\n… « matche » :\n\n#{echantillon.inspect}\n\n?\n/QUESTION is_matching"
  end
  case echantillon
  when Hash
    ok = true
    echantillon.each do |k, v|
      if comparaison[k] != v
        ok = false
        if verbose?
          puts "NON : la propriété #{k.inspect} qui vaut #{v.inspect} dans le contenu vaut #{comparaison[k].inspect} dans le contenant."
        end
        break # on pourrait aussi tout passer en revue pour avoir toutes les erreurs
      end
    end
    ok
  else
    comparaison.include?(echantillon)
  end
end

##
# Test de l'existence (pour fichier et dossier)
#
def exists(opts = nil)
  rigth_class_for_exist? || throw(:not_a_sujet_for_test_exist, "#{sujet.class}")
  defaultize_options(opts)
  if options && options[:as_file]
    is_file
  elsif options && options[:as_folder]
    is_folder
  else
    sujet = sujet.path unless sujet.is_a?(String)
    @affirmation = "Le fichier '#{sujet}' existe"
    @ok = positif == File.exist?(sujet)
    evaluate
  end
end

##
# Test de l'existence en tant que fichier
# Entrée : un String
#
def is_file(opts = nil)
  defaultize_options(opts)
  @sujet = sujet.path if sujet.is_a?(File)
  ok = File.exist?(sujet)
  if options && options[:strict]
    ok = ok && not(File.directory?(sujet))
  end
  @ok = positif == ok
  @affirmation = "Le chemin '#{sujet}' est celui d’un fichier"
  evaluate
end

def is_folder(opts = nil)
  defaultize_options(opts)
  @sujet = sujet.path if sujet.is_a?(File)
  @ok = positif == (File.exist?(sujet) && File.directory?(sujet))
  @affirmation = "Le chemin '#{sujet}' est celui d’un dossier"
  evaluate
end

def rigth_class_for_exist?
  sujet.is_a?(File) || sujet.is_a?(String)
end

##
# Test de l'infériorité
# ---------------------
#
def less_than(expected, options = nil)

  defaultize_options(options)
  @expected = expected

  sujet.is_a?(Integer) || sujet.is_a?(Float) || raise(":greater_than attend un sujet nombre")
  expected.is_a?(Integer) || expected.is_a?(Float) || raise(":greater_than attend un nombre en comparaison")

  ok = 
    if options[:strict]
      sujet < expected
    else
      sujet <= expected
    end

  ok = positif == ok
  
  @affirmation ||= "#{h_sujet} est #{options[:strict] ? 'strictement ' : ''}inférieur #{options[:strict] ? '' : 'ou égal '}à #{h_expected}"
  @ok = ok
  evaluate

end

##
# Test de la supériorité
# ----------------------
#
def greater_than(expected, opts = nil)

  defaultize_options(opts)
  @expected = expected

  sujet.is_a?(Integer) || sujet.is_a?(Float) || raise(":greater_than attend un sujet nombre")
  expected.is_a?(Integer) || expected.is_a?(Float) || raise(":greater_than attend un nombre en comparaison")

  ok = 
    if options[:strict]
      sujet > expected
    else
      sujet >= expected
    end

  ok = positif == ok
  
  @affirmation ||= "#{h_sujet} est #{options[:strict] ? 'strictement ' : ''}supérieur #{options[:strict] ? '' : 'ou égal '}à #{h_expected}"
  @ok = ok
  evaluate

end

##
# Méthode qui affiche le résultat en fonction de la réussite ou non
# et incrémente les succès et les échecs
# 
def evaluate
  question = ''
  if CLITest.fully_documented?
    question = "- Tester <<< #{affirmation} >>> est-elle bien #{positif ? 'vraie' : 'fausse'} ?".strip
    CLITest::UI.write_current_expectation(question)
  end
  reponse =
    if ok
      if options[:success]
        options[:success].gsub(/#sujet/, h_sujet).gsub(/#expected/,h_expected)
      else 
        :default 
      end
    else
      failure = "<<< #{affirmation} >>> est faux"
      if options[:failure]
        options[:failure].gsub(/#sujet/, h_sujet).gsub(/#expected/,h_expected)
      else
        :default
      end
    end
      
  sleep CLITest::Config[:messages_delay] unless CLITest::Config[:messages_delay] == 0
  if ok
    CLITest.add_success(reponse, clitest)
  else
    CLITest.add_failure(reponse, clitest, failure)
    if clitest.interruption_on_failure
      raise InterruptionOnFailure
    end
  end
end


##
# Définit l'affirmation ou la retourne
def affirmation(msg = nil)
  if msg.nil?
    return @affirmation
  else
    @affirmation = msg 
  end
end

##
# Pour transformer sujet ou expected en une valeur plus "humaine"
#
def membre_as_human(membre)
  return membre.inspect unless CLITest.fully_documented?
  case membre
  when String
    suj = membre.dup
    if membre.length > 100
      suj = membre.tomax(100)
    end
    "le texte #{suj.inspect}"
  when Hash
    "la table #{membre.inspect}"
  when Array
    "la liste #{membre.inspect}"
  when File
    is_dir = File.directory?(membre.path)
    typ =
    if is_dir
      'dossier'
    else
      case File.extname(membre.path)[1..-1]
      when 'yaml', 'yml'  then typ = "fichier YAML"
      when 'json'         then typ = "fichier JSON"
      when 'md', 'markdown', 'mmd' then typ = "fichier MARKDOWN"
      else "fichier texte"
      end
    end
    "le #{typ} '#{File.basename(membre.path)}'"
  when Integer, Float
    "le nombre #{membre}"
  when Range
    "le rang de #{membre.first} à #{membre.last}"
  else
    # Une instance par exemple
    if membre.respond_to?(:class)
      "l'objet #{membre.inspect}"
    else
      membre.inspect
    end
  end
end
##
# @return le sujet au format humain affichable
# 
# Noter qu'il a pu être défini dès l'instanciation
#     expect(sujet[, "<h_sujet>"])
def h_sujet
  @h_sujet ||= membre_as_human(sujet)
end #/h_sujet

##
# Retourne l'expectation au format humain
# 
def h_expected
  @h_expected ||= membre_as_human(expected)
end


end #/CLITest::Expectation
