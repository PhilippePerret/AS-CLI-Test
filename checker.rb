#!/usr/bin/env ruby
# encoding: UTF-8
# frozen_string_literal: true
=begin

  Le script appelé pour vérifier le résultat

  Il reçoit en premier argument le chemin d'accès absolu au
  fichier de commande et séquence qui a été transmis à l'application

=end
THIS_FOLDER = __dir__.freeze

command_file = ARGV[0]
# scory AppleScript ?
command_file = command_file[1..-1] if command_file.start_with?(':')

puts "Command file: #{command_file.inspect}"

# Le fichier dans lequel a été placé le contenu de la fenêtre
# resultat_file = "#{command_file}.result"
resultat_file = File.join(THIS_FOLDER,'resultat.txt')

if File.exist?(resultat_file)
  # Le code résultat
  code_resultat = File.read(resultat_file).force_encoding('utf-8')
  puts "\n\nCODE RETOUR #{'«'*60}\n#{code_resultat}\n/CODE RETOUR #{'»'*60}"

  # Le script qui doit gérer ce résultat
  checker_file = "#{commande_file}.checker.rb"

  if File.exist?(checker_file)
    puts "Je vais checker le résultat"
    load checker_file
  else
    puts "Le fichier de vérification #{checker_file.inspect} n'existe malheureusement pas. Je ne peux pas checker le résultat."
  end

else
  puts "Malheureusement, impossible de trouver le fichier #{resultat_file.inspect}…"
end

File.delete(resultat_file) if File.exist?(resultat_file)
