# encoding: UTF-8
# frozen_string_literal: true
=begin

  Class CLITest::UI
  -----------------
  Pour gérer l'affichage à l'écran au cours de tests

=end
require 'tty-cursor'
require 'tty-screen'

require_relative 'CLITest'

class CLITest::UI

# La portion d'écran dont on a besoin
# 
# Pour le moment, elle se répartit comme suit :
# 
#   1.  Ligne affichant le titre du test en court
#   2.  L'opération en cours (waiting_message)
#   3.  Expectation
#   4.  Expectation suite
#   5.
#   6.  
#   7.  -------------------------------------------------
#   8.    1 success, 4 failures, 5 pendings
#
SCREEN_HEIGHT = 8

class << self

##
# Le cursor, pour convenience
def cursor
  @cursor ||= TTY::Cursor
end
def clear_line ; print cursor.clear_line end
def move_to(x = nil, y = nil); print cursor.move_to(x, y) end
def clear_screen_down ; print cursor.clear_screen_down end

##
# Pour écrire le titre du test
def write_test_title(name)
  title = "*** Test : #{name} ***".bleu 
  move_to
  clear_line
  print title
end

##
# Pour écrire l'action courante (3e ligne)
#
def write_current_action(message)
  move_to(1,2)
  clear_line
  print "  #{message}"
end

def write_current_expectation(message)
  move_to(1,3)
  clear_line
  print "  #{message.bleu}"  
end

##
# Appelé pour actualiser le score en bas d'écran
def update_result(success, failures, pendings = 0)
  move_to(1, SCREEN_HEIGHT - 3)
  clear_screen_down
  color = failures > 0 ? :rouge : :vert
  move_to(1, SCREEN_HEIGHT - 3)
  print ('-' * 60).send(color)
  move_to(1, SCREEN_HEIGHT - 2)
  print "  #{success} success, #{failures} failures, #{pendings||0} pendings".send(color)
end


# --- Pour les dimensions de l'écran ---
def screen_width
  @screen_width ||= screen_size[:width]
end
def screen_height
  @screen_height ||= screen_size[:height]
end
def screen_size
  @screen_size ||= begin
    s = TTY::Screen.size
    {height: s[0], width: s[1]}
  end
end

end #<< self
end #/ CLITest::UI
