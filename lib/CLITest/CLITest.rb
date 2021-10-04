# encoding: UTF-8
# frozen_string_literal: true

=begin

  Ensuite, il faut transformer les clés ci-dessous en valeurs pour
  l'application System Events. S'aider de la page très bien faite :
    https://eastmanreference.com/complete-list-of-applescript-key-codes

  Cette page aussi peut aider :
    https://hea-www.harvard.edu/~fine/OSX/terminal-tabs.html

  Bien documenter en disant que pour que ça fonctionne, il faut 
  ajouter le script iced.rb à l'accessibilité (on ne peut pas le
  choisir en tant qu'application — ben si… — mais il suffit de glisser
  le fichier sur la fenêtre Préférences).

=end

# Pour interrompre le cas en cas d'échec
class InterruptionOnFailure < StandardError; end
class ForceCLITestInterruption < StandardError; end

# Pour indiquer dans une mini sequence qu'il ne faut pas jouer de
# retour chariot à la fin
NO_RETURN = :K0001

class CLITest

#
# Temps d'attente pour laisser l'utilisateur activer la fenêtre au
# début de la suite de tests
#
BEGINNING_WAITING_TIME = 4

class << self


  # ---------------------------------------------------------------
  #   MÉTHODES CONFIGURATION

  def verbose?
    CLI.verbose?  
  end

  ##
  # Mode de retour affichant tous les messages (nom des tests, éva-
  # luation, etc.).
  #
  def fully_documented?
    :TRUE == @is_fully_documented ||= (option?(:full)||Config[:output_format].to_s == 'documented') ? :TRUE : :FALSE
  end
  
  # 
  #   MÉTHODES DE TRAVAIL

  ##
  # Lance la suite de tests à jouer
  #
  # Dans la version AS, il n'y a plus de lancement de tests puisqu'on
  # glisse les fichiers à tester sur l'application
  def run(check_file)

    # #
    # # Définit les différents paramètres pour lancer le ou les
    # # tests. Teste la pertinence des paramètres.
    # #
    # define_parameters_and_check_values(params)

    # #
    # # On initialise pour la commande voulu (deuxième mot)
    # init_for_command(app_sub_command)

    clear unless verbose?

    ##
    # Si le dossier des tests définit un fichier required, on le
    # charge. Il permet de charger par exemple tous les helpers 
    # utiles aux tests de l'application testée
    # require_required_file_if_exist_in(app_tests_folder)

    UI.update_result(0,0,0)

    # TODO Ici, on doit étudier le retout final par rapport
    # aux attentes.
    instance = new(check_file, true)

    # #
    # # On charge le fichier défini ou les fichiers du dossier, ce
    # # qui les lancera automatiquement.
    # # 
    # # TODO : on pourrait aussi imaginer de fonctionner plus normale-
    # # ment, on chargeant tous les fichiers puis en les évaluant
    # # 
    # if app_test_file.nil?
    #   require_folder(app_tests_folder)
    # else
    #   load app_test_file
    # end

    # 
    # Affichage du rapport final
    # 
    CLITest.final_report

  rescue ForceCLITestInterruption => e
    puts "\n"
    puts e.message.rouge
  rescue Exception => e
    puts "\n#{e.message}".rouge
    puts e.backtrace.join("\n").rouge if verbose?
  ensure
    puts "\n"
  end

  # -- Les propriétés de configuration utiles ---
  def app_folder;       Config[:app_folder]       end
  def app_tests_folder; Config[:app_tests_folder] end
  def app_test_file;    Config[:app_test_file]    end
  def app_main_command; Config[:app_main_command] end
  def app_sub_command;  Config[:app_sub_command]  end
  def data_menus_file;  Config[:data_menus_file]  end

  ##
  # Au début de la méthode ::run, on doit définir toutes les valeurs
  # utiles aux tests.
  # On prend ces valeurs des +params+ transmis par l'application 
  # ainsi que des fichiers de configuration.
  # 
  def define_parameters_and_check_values(params)
    CLITest::Config.load_with_params(params)
    
    File.exist?(app_folder)        || throw(:app_folder_unfound, [app_folder])
    
    File.exist?(app_tests_folder) || throw(:tests_folder_unfound, [app_tests_folder])

    app_test_file.nil? || File.exist?(app_test_file) || throw(:test_file_unfound, [app_test_file])

    app_main_command || throw(:app_main_command_required)

    data_menus_file.nil? || File.exist?(data_menus_file) || throw(:data_menus_file_unfound, [data_menus_file])    
  end

  ##
  # SI un fichier 'required.rb' existe à la racine du dossier
  # des tests de l'application, on le charge. C'est lui, par exemple,
  # qui charge une librairie 'Gels.rb' permettant de dégeler les
  # données à utiliser.
  # 
  def require_required_file_if_exist_in(folder)
    required_path = File.join(folder,'required.rb')
    require required_path if File.exist?(required_path)    
  end

  # ---------------------------------------------------------------
  #   LES MÉTHODES DE CONSIGNATION DES RÉSULTATS

  def add_success(msg, clitest)
    @success_count += 1
    if fully_documented?
      msg = correct_message(msg)
      puts msg
      CLITest::UI.update_result(@success_count, @failure_count, @pending_count)
    else
      print '.'.vert
    end
  end

  def add_failure(msg, clitest, failure)
    @failure_count += 1

    failure = correct_message(failure)
    full_msg =  "Err. #{@failure_count.to_s.rjust(3,'0')} (#{clitest.location})\n--------\n#{failure}" + (option?(:full) ? "\n#{clitest.full_stack}" : '')
    @failures << full_msg
    if fully_documented?
      CLITest::UI.update_result(@success_count, @failure_count, @pending_count)
    else
      print '.'.rouge
    end
  end

  ##
  # Quelques corrections de français sur le message
  def correct_message(msg)
    return msg if not(msg.is_a?(String))
    msg = msg.gsub(/à le/, 'au')

    return msg
  end

  def final_report
    clear unless verbose?
    @end_time = Time.now.to_f
    method_color = @failure_count > 0 ? :rouge : :vert
    duree = (@end_time - @start_time).round(3)
    puts "\n\n#{'-'*80}\n  #{@success_count} success,  #{@failure_count} failures (durée : #{duree} seconds)".send(method_color)
    puts "\n"
    if not fully_documented?
      puts "  Ajouter '-f' pour avoir les descriptions complètes au fil des tests.".gris
    end
    if @failure_count > 0
      puts "\n= ERREURS =\n"
      puts @failures.join("\n").rouge
      if not verbose?
        puts "  Ajouter '-v' pour avoir les backtraces complets des erreurs.".gris
      end
    end
    puts "\n\n"
  end

  # ---------------------------------------------------------------
  #   MÉTHODES FONCTIONNELLES

  # 
  # Initialisation de CLITest pour la commande +command+
  # Cette +command+ permet notamment de savoir où se trouvent
  # les dossiers des gels et le dossier data à remplacer
  # 
  def init_for_command(command)
    @app_sub_command  = command
    @failure_count    = 0
    @failures         = []
    @success_count    = 0
    @start_time       = Time.now.to_f
  end

  # def osascript(cmd)
  #   # puts "Command osascript :\n#{cmd.inspect}\n"
  #   `osascript << TEXT
  # #{cmd}
  # TEXT`
  # end

  # ---------------------------------------------------------------
  #   CHEMINS D'ACCÈS
  # 

  def folder
    @folder ||= __dir__
  end

end #/<< self

EXPLICATION_FONCTIONNEMENT_CLITEST = <<-TEXT
Ce système de test permet de voir les tests se dérouler en direct.
Mais pour ce faire, il faut activer une autre fenêtre où se déroule-
ront les tests.

Donc la première chose à faire est d'avoir une fenêtre qui recevra
ces tests.

CRÉEZ-LA immédiatement en la disposant à l'endroit voulu.
TEXT

end #/class CLITest
