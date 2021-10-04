# encoding: UTF-8
# frozen_string_literal: true

class MessageSubstitution

attr_reader :clitest

def initialize(clitest, wait_with = nil, &block)
  @clitest = clitest
  @first_call = true
  waiting_message(wait_with) unless wait_with.nil?
  if block_given?
    instance_eval(&block)
  end
  return @resultat
end

def method_missing(methode, *args, &block)
  if clitest.respond_to?(methode)
    clitest.send(methode, *args, &block)
  else
    raise "Je ne sais pas quoi faire de la méthode #{methode.inspect}…"
  end
end

##
# Pour consigner le retour de la commande 'run' dans la propriété
# @resultat de CLITest (et donc pouvoir y accès après le bloc
# with_waiting_message)
#
def run(*args)
  self.resultat = clitest.run(*args)  
end

def resultat=(value)
  clitest.resultat = value
end

##
# Le premier appel à :write écrit le message provisoire +message+
# Le second appel remplace avec le message +message+
#
def write(message, couleur = :vert)
  if @first_call
    waiting_message(message, couleur)
  else
    end_message(message, couleur)
  end 
end
alias :w :write

def waiting_message(message, couleur = :bleu)
  message = "#{message}…" unless message.end_with?('…')
  # print "    #{message.bleu}"
  CLITest::UI.write_current_action(message.bleu)
  @first_call = false
  @longueur = message.length + 6  
end

def end_message(message, couleur = :vert)
  if CLITest.fully_documented?
    # puts "    #{bol}#{message.ljust(@longueur)}".send(couleur)
    CLITest::UI.write_current_action(message.send(couleur))
  else
    print "#{bol}#{' '.ljust(@longueur)}"
    print "#{bol}"
  end
end
end
