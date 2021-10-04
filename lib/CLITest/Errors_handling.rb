# encoding: UTF-8
# frozen_string_literal: true
=begin

  Module pour gérer les erreurs

  La méthode a priviligier est la méthode :

    throw(:<key-error-message>)

  … qui raise avec le message correspondant à :<key-error-message>

=end

def throw(err_id, remp = nil)
  msg = ERRORS[err_id]
  msg = msg % remp if remp
  raise msg
end

ERRORS.merge!(
  app_folder_required:    "Il faut absolument définir le chemin d'accès à l'application.",
  app_folder_unfound:     "Le dossier de l'application est introuvable (à l'adresse '%s').",
  tests_folder_required:  "Le dossier des tests est absolument requis",
  tests_folder_unfound:   "Aucun dossier de tests trouvé à l'adresse '%s'…",
  test_file_unfound:      "Le fichier '%s' est introuvable dans le dossier '%{folder}' de l'application (cherché avec les noms '%{name}' et '%{name}.clitest.rb').",
  app_main_command_required: "La commande principale lançant l'application testée est absolument requise (même vide).",
  data_menus_file_unfound:  "Le fichier des données de menus (:data_menus_file) est défini mais il est introuvable à l'adresse : %s…",

  no_speed_initiale: "Vous devez indiquer la nouvelle vitesse (la méthode :keys_speed sans argument ne s'utilise que pour revenir à la vitesse initiale après modification).",
  not_a_sujet_for_test_exist: "Le test 'exist' n'accepte que des fichiers ou des dossiers. Or vous envoyez un objet de type %s…"
)
