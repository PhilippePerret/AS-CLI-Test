# encoding: UTF-8
# frozen_string_literal: true
=begin

  Classe CodeKey
  --------------
  Gère tout ce qui concerne les touches à produire pour AppleScript

=end


class CodeKey

# --- CLASSE ---

class << self

##
# Tranforme et retourne la liste de clés +keys+ en argument
# pour appeler l'osascript run.scpt qui exécute la séquence
# 
def keys_to_applescript_args(keys)
  # puts "-> keys_to_applescript_args(#{keys.inspect})"
  args = []
  unless keys.nil?
    keys.each do |key|
      if key.is_a?(Array)
        args += keys_to_applescript_args(key)
        next # pour ne pas ajouter le retour chariot
      elsif key.is_a?(CodeKey)
        puts "#{key.inspect} est un CodeKey"
        args += keys_to_applescript_args(key.value)
        next
      elsif key.nil?
        # rien à faire, on ajoute le retour chariot
      elsif key.is_a?(String)
        # Un string peut se terminer par "\n" pour simplifier 
        # l'écriture
        end_with_return = key.end_with?("\n")
        if end_with_return
          key = key[0..-2]
          erreur "Rappel : il ne faut pas ajouter de retour chariot à la fin des séquences. Ils sont automatiques."
        end
        args << "'#{key}:s'" unless key.empty? # le "\n" seul
      elsif key.is_a?(Integer)
        args << "'#{key}:i'"
      elsif key.is_a?(Float)
        args << "'#{key}:f'"
      else
        erreur "Je ne sais pas quoi faire de key = #{key.inspect}::#{key.class}"
      end
    end
  end
  return args
end

end # << self

# --- INSTANCE ---

attr_reader :value # valeur finale, toujours un Array
def initialize(val, nombre)
  @value = Array.new(nombre, val)
end

end

def key(sim, nombre = 1, params = nil)
  if sim.is_a?(Array)
    sim.collect { |s| one_key(s) }
  else
    Array.new( nombre, one_key(sim) )
  end
end
def one_key(sim)
  case sim
  when :left_arrow,   :left_arrow,  :left  then 123
  when :right_arrow,  :right_arrow, :right then 124
  when :down_arrow,   :down_arrow,  :down  then 125
  when :up_arrow,     :up_arrow,    :up    then 126
  when :return, :ret, :n  then 36
  when :backspace   then 177
  when :control_c   then 'CONTROL_c'
  when :control_d   then 'CONTROL_d'
  when :control_z   then 'CONTROL_z'
  else sim # quand un texte est envoyé avec des touches spéciales
  end  
end

