# encoding: UTF-8
# frozen_string_literal: true
=begin

  Méthodes pratiques

  Note : pour certaines, DATA_MENUS doit être défini

=end

class CLITest

##
# Cette méthode permet de trouver les touches a jouer pour activer
# le menu +menu+ en parcourant l'arbre des menus défini dans le
# module data_menus.rb
#
# Note : DATA_MENUS doit être défini (cf. manuel)
# 
# Cette méhtode permet de garder les tests valides même si la suite
# des menus est modifiée.
# 
# Pour le trouver, on fait la table de tous les menus, avec leur
# clés. On l'enregistre pour ne pas avoir à la faire à chaque fois.
# 
# @return {String} de la séquence des touches à jouer pour atteindre
#         le menu, ou nil si non trouvé.
# 
def self.keys_to_menu(menu)
  @all_keys_up_to_menu ||= begin
    require_relative CLITest.data_menus_file
    table = {}
    keys = []
    check_menus_in(DATA_MENUS, keys, table)
  end
  @all_keys_up_to_menu[menu]# + key(:n) # key(:n) pour choisir ce menu
end
def self.check_menus_in(menus, keys, table)
  # puts "menus: #{menus.inspect}"
  menus.each do |dmenu|

    menu_name   = dmenu[:name]
    menu_value  = dmenu[:value]
    
    dmenu_is_well_formated  = menu_value.is_a?(Array)
    dmenu_has_sub_menus     = dmenu_is_well_formated && menu_value[0].is_a?(Hash)

    if dmenu_is_well_formated

      if dmenu_has_sub_menus

        #
        # On peut enregistrer la séquence de touches pour ce menu
        # courant
        # 
        table.merge!(menu_name => keys + key(:n))

        #
        # Et on passe à ses sous-menus
        #
        check_menus_in(dmenu[:value], keys + key(:n), table)

      else

        #
        # Quand le menu n'a pas de sous-menus (bout de séquence)
        #

        # puts "Enregistrement du menu “#{dmenu[:name]}” avec les clés : '#{(keys.join('')+KEY_RETURN).inspect}'"
        table.merge!(dmenu[:name] => keys + key(:n))

      end

    else

      # Donnée mal formatée, la valeur de dmenu (:value) devrait dans
      # tous les cas être une liste
      # TODO : ne serait-il pas plus simple d'avoir un hash dans tous
      # les cas et de simplement préciser une propriété :menus qui 
      # serait définie en cas de sous-menu. Alors un Array quand il y
      # a sous-menus et un Hash dans le cas contraire.
      raise "Je ne sais pas quoi faire de #{dmenu[:value].inspect}"

    end
    keys += key(:down) # += car ce sont 2 arrays
  end

  # puts "\nTable des touches par menu : #{table.inspect}"

  return table
end

end #/Class CLITest
