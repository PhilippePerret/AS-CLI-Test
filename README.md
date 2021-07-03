# Test a CLI app

## Required

* MacOs
* AppleScript
* Ruby

## Synopsis

* define the CLI app (command line application),

* define a *command file* with command and keystroke sequence :

  ~~~
  iced compta
  ARROW_DOWN
  ARROW_DOWN
  ARROW_DOWN
  RETURN
  ~~~

* define a check file (for result) with same name and  `rb` extension :

  ~~~ruby
  expect(resultat).contains("Hello world!")
  ~~~

* drop and drag *command file* on ASCLITestIt.app

## Implementation synopsis

ASCLITestIt.app receive the *command file*, parse it, execute the command on a Terminal window and stoke the sequence of keys.
Then it calls `asclitestit-checker` script with the content of the widows, whose check the resultat.
