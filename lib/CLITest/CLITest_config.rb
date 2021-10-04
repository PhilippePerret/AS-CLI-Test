# encoding: UTF-8
# frozen_string_literal: true
=begin

  Module qui gère tout ce qui concerne la configuration des tests

=end
class CLITest
class Config

CONFIG_DEFAULT = {
  keys_speed:     0.1,
  messages_delay: 0,
  output_format:  :dots
}

class << self

  attr_reader :config

  ##
  # Retourne la configuration de clé +key+
  #
  # @syntaxe
  # 
  #   CLITest::Config[key]
  #
  def [](key)
    config[key]
  end

  ##
  # Permet de redéfinir à la volée une vitesse
  #
  def []=(key, value)
    @config.merge!(key => value)
  end
  
  ##
  # = main =
  # 
  # Méthode principale qui charge et dispatche les données de confi-
  # guration (cf. le manuel utilisateur)
  # 
  def load_with_params(params)
    conf = {}
    # Dossier de l'application
    @app_folder = params[:app_folder] || throw(:app_folder_required)
    conf.merge!(app_folder: @app_folder)
    # Dossier des tests
    @app_tests_folder  = search_in_configs(:tests_folder, params) || File.join(@app_folder,'clitests')
    @app_tests_folder = File.join(@app_folder, @app_tests_folder) if not File.exist?(@app_tests_folder)
    conf.merge!(app_tests_folder: @app_tests_folder)
    # Fichier de test (if any)
    app_test_file = real_test_file(params[:test_file], @app_tests_folder)
    conf.merge!(app_test_file: app_test_file)
    # Commande principale
    conf.merge!(app_main_command: params[:main_command] || app_config[:main_command])
    # Sous-commande
    conf.merge!(app_sub_command: search_in_configs(:sub_command, params))
    # Fichier des données de menus
    data_menus_file  = params[:data_menus_file]
    conf.merge!(data_menus_file: data_menus_file)
    # --- Préférences de tests ---
    conf.merge!(keys_speed: search_in_configs(:keys_speed, params))
    conf.merge!(messages_delay: search_in_configs(:messages_delay, params))

    @config = conf
  end

  def search_in_configs(key, params)
    cli_options(key)||params[key]||app_config[key]||self_config[key]
  end

  ##
  # Retourne l'argument key possiblement passé en paramètre dans la
  # ligne de commande (souvent nil)
  def cli_options(key)
    CLI.option(key)
  end

  ##
  # Configuration de l'application (fichier clitest.config.yaml)
  #
  def app_config
    @app_config ||= begin
      if File.exist?(app_config_file_path)
        YAML.load_file(app_config_file_path)
      else
        {}
      end
    end
  end

  ##
  # Configuration de CLITest
  # 
  def self_config
    @self_config ||= begin
      if File.exist?(config_file_path)
        YAML.load_file(config_file_path)
      else
        # On reconstruit toujours le fichier
        File.open(config_file_path,'wb'){|f|f.write(YAML.dump(CONFIG_DEFAULT))}
        CONFIG_DEFAULT
      end
    end
  end

  ##
  # Le vrai fichier de test, car il peut être donné sous une forme
  # réduite.
  #
  def real_test_file(nom, dossier)
    return nil if nom.nil? # pas de fichier en particulier
    return nom if File.exist?(nom)
    p = File.join(dossier, nom)
    return p if File.exist?(p) && not(File.directory?(p))
    p = "#{p}.clitest.rb"
    return p if File.exist?(p)
  end

  ##
  # Chemin d'accès au fichier configuration de l'application testée,
  # if any
  def app_config_file_path
    @app_config_file_path ||= File.join(@app_folder, 'clitest.config.yaml')
  end

  ##
  # Chemin d'accès au fichier configuration de CLITest
  # 
  def config_file_path
    @config_file_path ||= File.join(__dir__,'config.yaml')
  end
end #/<< self
end #/Config
end #/CLITest
