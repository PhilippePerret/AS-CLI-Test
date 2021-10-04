# Tests avec CLITest



**CLITest** permet de faire des tests d’applications CLI (i.e. en ligne de commande), sur macOs (*), comme si un utilisateur l’utilisait et de suivre les démarches en direct.

> L’application utilisant pour le moment AppleScript (osascript) et le Terminal, elle n’est utilisable que sur macOS, mais il serait possible d’en imaginer une version pour Unix et Windows.

Le principe est le suivant :

1. On joue une commande (par exemple `iced compta`) en lui envoyant une liste de touches et de textes qui représentent les actions de l’utilisateur
2. On reçoit le résultat. Qui sont les derniers lignes (ou toutes) renvoyées par le programme.
3. On teste ces lignes pour voir si elles correspondent au résultat attendu.
4. On teste tout autre effet (production de fichier, de données, etc.)

#### Exemple de test simple

~~~ryby
CLITest.new("Mon premier test", true) do

	degel('courant')
	
	result = run('iced compta', [nil,DOWN_ARROW*2,DOW_ARROW*4], 10)
	
	expect(result).contains("Export du livre des recettes exportés avec succès")
	# => Produit un succès si la fenêtre contient actuellement le texte donné
	#    en argument. Produit un échec otherwise.
	
end

~~~


---

<a id="les-fenetres"></a>


## Les fenêtres

Les tests CLITest utilisent donc deux fenêtres de Terminal :

* la fenêtre *de test*,
* la fenêtre *de simulation*.

<a id="fenetre-de-test"></a>

### Fenêtre de test

C’est la fenêtre où l’on va lancer le test et où vont apparaitre les résultats.

<a id="fenetre-de-simulation"></a>

### Fenêtre de simulation

La **fenêtre de simulation** est la fenêtre, ouverte automatiquement au début des tests, qui va simuler l’utilisation de la commande et les interactions de l’utilisateur avec l'application.

Le grand atout des CLITest est qu’on peut suivre en direct ce qui se passe lorsque l’utilisateur utilise l’application, contrairement à des programmes de tests qui utilisent `pty` par exemple.

---

<a id="les-tests"></a>

## Les tests

### Emplacement des tests

Rien n’est obligatoire concernant l’emplacement des tests de l’application, l’utilisateur-programmeur peut les mettre où bon lui semble, en renseignant simplement ce dossier [au lancement des tests](#run-tests). Mais si le dossier s’appelle `clitests` et se trouve à la racine du dossier de l’application, il ne sera pas nécessaire de le définir dans les configurations ou à l’appel de la méthode `CLITest.run` (cf. ci-dessous).

Noter simplement que, au moment du lancement des tests, *tous* les fichiers ruby de ce dossier seront chargés. Une bonne habitude est de ne placer dans ce fichier que des fichiers tests. Ou d’autres fichiers sans l’extension ruby.

<a id="nom-fichier-test"></a>

### Nom des fichiers tests

On peut donner le nom que l’on veut à ses fichiers contenant les tests, mais si on veut utiliser un format simple pour définir le test précis à jouer — ou reconnaitre simplement ses fichiers —, le mieux est d’utlilser la double extension **`.clitest.rb`**.

~~~
mon_test.clitest.rb
~~~

### Fichier requis

Si le dossier des tests de l’application contient un fichier `required.rb`, il est automatiquement chargé avant le lancement des tests.

TODO : Plus tard, on pourra imaginer des fichier ‘after_each.rb’, `after_suite.rb`, `before_each.rb` etc. qui permettront de lancer des actions avant chaque test, avant les suites de tests, etc.

---

<a id="run-tests"></a>

### Lancement de la suite de tests

Pour lancer les tests, il suffit d’invoquer une méthode de l’application qui appellera :

~~~ruby
CLITest.run(
  app_folder:   '/path/to/app/folder',  # Chemin d'accès à l'application à tester
  																			# C'est la seule donnée obligatoire, les
  																			# autres sont optionnelles ou peuvent se régler
  																			# dans le fichier de configuration.
  tests_folder: 'tests/folder/',				# Chemin absolu ou relatif du dossier contenant
  																			# les tests à jouer
  main_command: 'commande_principale', 	# La commande qui lance vraiment l'application
  																			# p.e. le 'ls' ou le 'cd' du bash
  sub_command:  'sous-commande',       	# si elle existe. Peut-être aussi des options
  test_file:    'mon-fichier-test'			# si on veut jouer un seul test
  																			# ce nom peut aussi être un chemin absolu.
  data_menus_file: '/path/to/dmenus.rb' # Chemin d'accès au fichier de définition des
  																			# menus, s'il existe.
  keys_speed:       0.1									# Vitesse entre les touches
)
~~~

> On peut faire par exemple un exécutable qui appellera cette méthode, en gérant les arguments pour définir le fichier à jouer ou le dossier du test.

> Pour le nom du fichier, cf. les [règles concernant les noms des fichiers tests](#nom-fichier-test). Ici, on ne peut metre ‘mon-fichier-test’ uniquement parce que le fichier porte le nom `mon-fichier-test.clitest.rb`.

On peut aussi définir toutes ces données dans le [fichier de configuration](#config-file) des tests dans l’application : 

~~~yaml
# in <app folder>/clitest.config.yaml
---
# ...
tests_folder: /path/to/folder
main_command: ...
etc.
~~~

---

<id a="setup"></a>

## Réglages des paramètres des tests

Il a quatre  moyens de définir les valeurs de configuration qu’on va aborder ci-dessous, dans l’ordre croissant de priorité :

### Précédence

* \> Le fichier configuration de l’application CLITest,
* \>> Le fichier configuration de l’application testée (si [ce fichier existe](#fichier-config)),
* \>>> Les données passées à la commande `CLITest.run`,
* \>>>> Les paramètres passés en ligne de commande.

### Paramètres

| Paramètres       | Description                    | Valeurs       | Valeur défaut |
| ---------------- | ------------------------------ | ------------- | :-------------: |
| **`app_folder`** | Dossier de l’application testée | Chemin absolu | -             |
| **`main_command`** | La commande qui launch l’application testée | N’importe quoi | - |
| **`sub_command`** | La sous-commande, donc le “mot” juste après la main-command | N’importe quoi | - |
| **`tests_folder`** | Dossier contenant les tests dans l’application testée | Chemin relatif dans le dossier de l’application (ou absolu) | - |
| **`data_menu_file`** | Fichier définissant les menus de l’application testée | Chemin relatif dans le dossier de l'application |  |
| **`test_file`** | Le fichier de test à lancer | Chemin relatif (dans le dossier de tests) ou absolu | - |
| **`keys_speed`** | Vitesse du pressage des touches. Donc le délai entre deux touches pressées. | Secondes | 0.1 |
| **`messages_delay`** | Temps d’affichage des messages dans la [fenêtre de test](#fenetre-de-test) | Secondes | 0 |
| **`output_format`** | Format de sortie dans la [fenêtre de test](#fenetre-de-test) | :documented, :dots, :html (TODO) | :dots |




#### Délai d’attente entre l’affirmation et la réponse

Pour donner un aspect plus “réel” (mais beaucoup plus long) aux tests, on peut définir `CLITest#step_pause` qui sera le temps de pause, en seconde, entre l’affirmation posée et la réponse évaluée.

~~~ruby
CLITest.new("Avec un temps de pause") do 
  
  message_delay(3) # 3 secondes pour lire l'affirmation
  
  expect(4+3).equals(7)
  expect("Un string").contains("Un")
  
end
~~~



#### Vitesse de frappe des touches

Par défaut, les touches simulées sont frappée assez vite (un dixième de seconde). On peut néanmoins modifier ce réglage en définissant l’option `--keys_speed=xxx` ou `xxx` est le temps en secondes. Par exemple `--keys_speed=0.5`.

Par exemple, si j’ai fait un exécutable ``clitests.rb` qui parse la ligne de commande et place les données dans `CLI`, je peux jouer :

~~~
> ruby clitests.rb --keys_speed=0.5
~~~

On peut également régler la vitesse en la définissant dans la table envoyée en argument à la commande `CLITest.run` :

~~~ruby
CLITest.run(
  test_folder: "/path/to/app/tests/folder",
  ...
  keys_speed: 0.5
)
~~~



On peut enfin la définir dans le [fichier de configuration](#config-file) : 

~~~yaml
# in <app folder>/clitest.config.yaml
---
# ...
keys_speed: 0.5
~~~



Voir aussi [modifier la vitesse des touches et textes en cours de test](#change-keys-speed-in-tests).


---

<a id="commande-run"></a>

## La commande `run("<commande>"[,<keys>][, <nombre>])`

Cette commande permet de simuler une utilisation d’une commande.

### 1er argument : la commande

Le premier argument contient le nom de la commande (sans `iced` — ou autre si ce programme de tests est utilisé pour d’autres applications en ligne de commande.). Elle contient aussi ses options et ses arguments.

Par exemple :

~~~ruby
run('compta -v periode=2021')
~~~

### 2e argument : les touches et les textes

Le second argument, s’il est fourni, contient la liste des touches et des textes que va rentrer l’utilisateur. 

Par défaut de second argument, on présuppose que l’utilisateur tape la commande et ne fait rien.

Une liste de valeurs peut ressembler à :

~~~ruby
[
	key(:n), 				# un simple retour de chariot
  key(:down, 4),  # puis presser 4 fois la flèche bas
  								# (suivi d'un retour de chariot)
  'bonjour',			# puis taper le texte "bonjour"
  								# (suivi d'un retour de chariot)
  key(:n, 3),			# puis confirmer 4 fois (4 car il 
  								# y a le dernier à ne pas oublier)
  key(:control_c),# Touche "c" avec Ctrl appuyé
]
~~~

### 3er argument : nombre de ligne

Optionnel : nombre de lignes à renvoyer.

Par défaut, tout le texte à l’écran (donc hors texte effacer par l’application) est retourné par la commande `run`. Mais parfois, pour éviter les ambigüités, on peut restreindre le retour à quelques lignes seulement.

Ce nombre permet de retourner seulement **les `<nombre>`-ième dernières lignes**.

---

## Composition d'un test

Un test se compose basiquement de :

~~~
- Une partie préparant l'état du test (souvent un *degel*)
- Lancement de la commande à jouer, avec la séquence de touches
- Vérification de l'état de fin de la séquence de touche avec :
	- état de la fenêtre (contenu, alertes, etc.)
	- état des données modifiés
~~~

### La séquence de touches et textes

Des méthodes d’helper aident à composer la séquence de touches qui composent le second argument de la méthoe `run` :

* la méthode `key`, qui attend l’identifiant symbolique de la touche et le nombre éventuel de fois où elle doit être activée

  ~~~
  key(<clé symbolique|liste de clés>[, <nombre de fois>])
  ~~~

  La **liste complète des touches** se trouve [en annexe](#all-touches).

  Par exemple :

  ~~~ruby
  key(:down)
  # => Active trois fois la flèche bas dans la fenêtre de simulation
  ~~~

  Ou pour activer plusieurs fois la touche :

  ~~~ruby
  key(:down, 3) # répète trois fois la touche flèche bas
  ~~~

  Ou plusieurs touches différentes :

  ~~~ruby
  key([:down, :down, :n]) # 2 fois la flèche bas et retour chariot
  ~~~

  > La suite présente des exemples plus complets intégrés dans un code complet de test.

* si l’application fonctionne à base de “menus” présentés par exemple par l’excellent `tty-prompt`, on peut définir l’enchaînement de ces menus dans une donnée `DATA_MENUS` et utiliser ensuite la méthode `keys_to_menu(<menu>)` qui retourne automatiquent la **séquence de touches** pour atteindre le-dit menu.

  >  Cette utilisation a l’immense avantage de laisser la possibilité de modifier les menus au cours de l’implémentation sans avoir rien à changer aux tests. Dans le cas contraire, tout changement de menus entrainerait parfois des modifications laborieuses des séquences dans les tests.

  Pour de plus amples renseignement sur cette données `DATA_MENUS` voir la partie [Définition intelligente des menus](#data-emenus) dans l’annexe.
  
* la liste de touches peut comprendre aussi les textes à entrer au clavier. On n’oubliera pas le retour terminal pour valider la séquence. Par exemple :

  ~~~ruby
  CLITest.new("Une séquence avec touches et textes") do
    sequence = [
     	key(:n), 						# un retour chariot
    	"Bonjour\n",				# un texte à taper
      "Tout le monde\n"		# un autre texte à taper
      "Une longue note sur\nPlusieurs lignes", 	
      										# Noter l'absence de retour de chariot, car…
      key(:control_d)			# Pour terminer l'entrée d'un texte multilignes
      										# de tty-prompt
    ]
    
    run('maCommande', sequence)
    # => Retourne le contenu de la fenêtre de résultat
    
  end
  ~~~

  

---

<a id="run-test"></a>

## Lancement et interruption des tests

~~~bash
iced tests <command>
~~~

… lancera les tests de la commande `<command>` de l’application `iced`.

### Sauter des tests

Pour ne pas jouer un test, on met le second argument de son instanciation à false :

~~~ruby
CLITest.new("Un test à ne pas jouer car run est à :", false) do
  # ...
end
~~~

### Interruption en cas d'échec

Par défaut, un test (un cas) s’interrompt dès qu’une failure est rencontrée.

On peut cependant demander à jouer le test jusqu’au bout en ajoutant `interruption_on_failure(false)` :

~~~ruby
CLITest.new("Test sans interruption") do
  
  resultat = run("compta", [KEY_RETURN])
  
  expect(resultat).contains("ça")
  # S'interrompt ici si c'est faux
  
  interruption_on_failure(false)
  
  expect(resultat).contains("ceci")
  # Ne s'interrompt pas même si c'est faux
  
end
~~~

### Interruption au premier échec

TODO : --fail-fast à implémenter

<a id="change-keys-speed-in-tests"></a>

### Modification de la vitesse des touches en cours de test

On peut modifier la vitesse des touches en cours de test avec la méthode `keys_speed`, en lui donnant en argument la nouvelle vitesse. Noter cependant que cela ne peut se faire qu’entre deux `run`, pas à l’intérieur d’un run lui-même.

Exemple :

~~~ruby
CLITest.new("Mon test avec changement de vitesse") do
  
  # Info : la vitesse, dans le fichier config, a été réglée
  # à 0.1 pour aller très vite.
  
  run('command', sequence)
  # Ce test se fait très vite
  
  # On change la vitesse pour voir mieux ce qui se passe ici
  keys_speed(1)
  
  run('command', sequence)
  # Ce test se fait lentement
  
  # On revient à la vitesse initiale
  keys_speed()
  
  
  
end
~~~



---

<a id="expectations"></a>

## EXPECTATIONS

Se rendre rapidement à :

* [`expect`](#expect)
* [`not`](#expectation-not)
* [`equals` / `eq`](#equals)
* [`match`](#expectation-match)
* [`contains`](#expectation-contains), et son inverse :
* [`in`](#expectation-in)
* [`greater_than` et `less_than`](#expectation-greater_than-less_than)

<a id="expect"></a>

### expect

Les expectations, comme dans `rspec`, sont introduites par le mot-clé `expect`.

Mais la comparaison s’arrête là car :

* la définition est plus souple, surtout pour les messages
* tout est enchainé par des points (voir l’exemple du `not` ci-dessous).

~~~ruby
CLITest.new("Mon expectation") do
  
  expect(2+2).eq(4)
  # => Produit le succès "L'affirmation <<< 4 est égal à 4 >>> est vraie"
  expect(2+2).not.eq(5)
  # => Produit le succès "L'affirmation <<< 4 est égal à 5 >>> est fausse" 
  
end
~~~

On peut « qualifier » le sujet (argument de `expect` avec un second argument). Par exemple :

~~~ruby
CLITest.new("Mon expectation") do
  
  expect(2+2, "La somme de 2 et 2").eq(4)
  # => Produit le succès "L'affirmation <<< La somme de 2 et 2 est égal à 4 >>> est vraie"
  expect(2+2, "2 + 2").not.eq(5)
  # => Produit le succès "L'affirmation <<< 2 + 2 est égal à 5 >>> est fausse" 
  
end
~~~

Peut suivre ensuite la négation, comme nous venons de le voir :

<a id="expectation-not"></a>

### not

Permet d’inverser l’expectation.

~~~ruby
expect("Le texte").not.contains("texte")
# => FAILURE (car la recherche est stricte)
~~~

Suivent ensuite les méthodes d’expection elles-mêmes :

* [`equals` / `eq`](#equals)
* [`match`](#expectation-match)
* [`contains`](#expectation-contains), et son inverse :
* [`in`](#expectation-in)
* [`greater_than` et `less_than`](#expectation-greater_than-less_than)

<a id="equals"></a>

### equals/eq

Vérifie l’égalité entre deux valeurs qui peuvent être :

* des strings
* des nombres
* des listes (comparaison stricte ou non)
* des tables
* des booléens.

~~~ruby
CLITest.new("Tests d'égalité") do
  
  # Tous les tests ci-dessous produisent des succès
  
  expect(2 + 4).equals(6)
  expect("Un " + "temps").eq("Un temps")
  expect([1,2,3]).eq([2,1,3], {strict: false})
  expect([1,2,3]).not.eq([2,1,3]) # strict par défaut
  expect({un:"tableau", deux:"toiles"}).eq({deux:"toiles", un:"tableau"})
  
end
~~~

> Noter qu’on peut, pour toutes ces méthodes, définir des [messages de succès et de failure propres](#custom-messages).

<a id="expectation-match"></a>

### match

Seulement pour les strings, vérifie qu’une chaine de caractères réponde à l’expression régulière fournie.

~~~ruby
CLITest.new("Test expression régulière") do
  expect("Un longtemps est un jamais").match(/long ?temps/)
  # => Produit un succès
end
~~~

> Noter qu’on peut, pour toutes ces méthodes, définir des [messages de succès et de failure propres](#custom-messages).

<a id="expectation-contains"></a>

### contains

Elle fonctionne pour tous ces cas en fonction du sujet :

* vérifie qu’un String contient un autre String,
* vérife qu’un String matche une expression régulière,
* vérifie qu’une liste contient un item,
* vérifie qu’une table (`Hash`)  contient des clé-valeurs,
* vérifie qu'un rang contient une valeur,
* vérifie qu’un dossier contient un fichier (par son nom),
* vérifie qu’un fichier texte contient un texte donné,
* vérifie qu’un fichier YAML contient une donnée
* vérifie qu’un fichier JSON contient une donnée

> Noter qu’on peut, pour toutes ces méthodes, définir des [messages de succès et de failure propres](#custom-messages).

#### Exemple d’un fichier YAML

~~~ruby
CLITest.new("Test d'une valeur dans un fichier YAML") do
  
  file = File.new('/path/to/file_array.yml')
  expect(file).contains([{une:"donnée"}])
  # => Produit un succès si le fichier file_array.yml
  #			condition 1 : définit une liste
  #     condition 2 : que cette liste contient un élément avec une
  #			clé :une qui vaut "donnée"

  file_config = File.new('/path/to/config.yaml')
  expect(file_config).contains({title: "Mon titre"})
  # => Produit un succès si :
  #				condition 1 : file_config définir une table
  #       condition 2 : file_config définit la clé :title
  #
end
~~~

<a id="expectation-in"></a>

### `in`

Produit un succès si le sujet se trouve dans la valeur fournie.

Par exemple :

~~~ruby
expect('mon_fichier.txt').in(File.new('/path/to/mon_dossier'))
# => Produit un succès si le dossier /path/to/mon_dossier contient un
#		 fichier de 'mon_fichier.txt'

expect(nom: "Philippe").in(File.new('/path/to/config.yaml'))
# => Produit un succès si le fichier YAML contient la définition de la
#		 clé :nom avec "Philippe" en valeur

expect("texte").in("C'est mon texte")
# => succès
~~~



> Noter qu’on peut, pour toutes ces méthodes, définir des [messages de succès et de failure propres](#custom-messages).


<a id="expectation-exists"></a>

### exists, is_folder, is_file

Plusieurs expectation qui permettent de vérifier si le sujet (un `String` ou à la rigueur un `File`)  correspond au path d’un fichier ou d’un dossier.

~~~ruby
expect("/path/to/my/file").exists
# => Produit un succès si le fichier ou le dossier existe

expect("/path/to/folder").is_folder
# => Produit un succès si le dossier existe en tant que dossier

expect("/path/to/any/file").is_file
# => produit un succès si le fichier existe et que c'est vraiment
#    un fichier.

expect("/path/to/real/fichier").is_file(strict: false)
# => Produit un succès si le fichier OU le dossier existe


~~~

On peut aussi utiliser seulement `exists` avec des options :

~~~ruby
expect("/path/to/file").exists(as_folder: true)

expect("/path/to_file").exists(as_file: true)
~~~




<a id="expectation-greater_than-less_than"></a>

### greater_than/less_than

Pour les nombres, vérifie que le nombre sujet soit plus grand que le nombre donné.

~~~ruby
CLITest.new("Test de hauteur") do
  expect(12).greater_than(8)
  # => Produit un succès
  expect(12).greater_than(12)
  # => Produit un échec (strict >)
  expect(12).greater_than(12, strict: false)
  # => Produit un succès
  
  expect(12).less_than(13) # => succès
end
~~~

> Noter qu’on peut, pour toutes ces méthodes, définir des [messages de succès et de failure propres](#custom-messages).



---

<a id="messages"></a>

## Messages

Pour laisser des messages dans la [fenêtre de test](#fenetre-de-test), on peut utiliser les méthodes classique `puts` ou `print` (etc.) avec les couleurs `rouge`, `jaune`, etc.

### Retour documenté

Par défaut, seuls des points (rouges et verts) s’affichent quand les tests sont joués. On peut cependant obtenir une version « documentée » affichant le nom des tests, les retours de résultats, etc. en ajoutant l’option `-fd` à la commande de test.

~~~
clitest -fd
~~~

TODO : plus tard, on pourra envoyer les résultats dans un fichier, en HTML.

<a id="with-waiting-message"></a>

### Messages encadrant les opérations longues

Mais on peut également encadrer les opérations par des messages d’attente et de fin. Le premier s’affiche, l’opération est jouée et lorsque l’opération est achevée, on affiche le message de fin, qui écrase le message d'attente.

Voici la tournure :

~~~ruby
CLITest.new("Un test avec message d'attente et de fin") do

 	with_waiting_message("<le message d'attente à afficher>") do
  	waiting_message("<le message d'attente à afficher>"[, :couleur])
    # Ce message s'affiche, bleu par défaut
	  run(...)
    # L'opération se joue
  	end_message("<le message de substitution>"[, :couleur])
    # Ce message écrase le message d'attente, en vert par défaut
	end
  
  # Utiliser 'resultat' pour récupérer le retour de run :
  expect(resultat).contains("Bonjour tout le monde !")

end
~~~

Par exemple :

~~~ruby
CLITest.new("Un message d'attente") do

  with_waiting_message do
  	waiting_message("Je vais attendre 5 secondes", :jaune)
    # Le message "Je vais attendre 5 secondes…" s'affiche en jaune
    sleep 5
    # Je remplace l'opération par une attente de 5 secondes
	  end_message("J'ai attendu 5 secondes.")
    # Après 5 secondes, le message d'attente disparait et est
    # remplacé par le message "J'ai attendu 5 secondes." en vert
  end
 
  # Utiliser 'resultat' pour récupérer le retour de run :
  expect(resultat).contains("Bonjour tout le monde !")
 
end
~~~

Comme on peut le voir dans l’exemple ci-dessus, c’est la propriété **`resultat`** qui contient le retour de la commande `run` (en d’autres termes qui contient le texte de la [fenêtre de simulation](#fenetre-de-simulation)).

#### Message d’attente dans une autre couleur

Si on veut le message d’attente dans une autre couleur que le bleu, on ne donne pas d’argument à `with_waiting_message` et on renseigne `waiting_message` dans le bloc :

~~~ruby
CLITest.new("Un test avec message d'attente en jaune caustique") do

 	with_waiting_message() do
  	waiting_message("<le message d'attente à afficher>", :jaune)
    # Ce message s'affiche en jaune
	  run(...)
    # L'opération se joue
  	end_message("<le message de substitution>"[, :couleur])
    # Ce message écrase le message d'attente, en vert par défaut
	end
  
  # Utiliser 'resultat' pour récupérer le retour de run :
  expect(resultat).contains("Bonjour tout le monde !")

end
~~~



### Messages de résultat personnalisés

Toutes les méthodes d'expectation peuvent définir des **messages de succès et d'échec propres** grâce au second argument :

~~~ruby

expect(sujet).contains(ca, succes:"Chouette !", failure:"Mince…")
# => Afficher "Chouette" en cas de succès (en mode verbeux)
# => Affichera "Mince…" en cas d'erreur

~~~

> Rappel : c'est bien un second argument comme le suppose par défaut `ruby`, l'écriture complète serait :
> ~~~ruby
> expect(sujet).contains(ca, {succes:"Chouette !", failure:"Mince…"})
> ~~~



#### `sujet` et `valeur attendue` dans les messages personnalisés

On peut faire référence aux sujets et valeur attendue (`expected`) dans les messages personnalisés à l’aide des marques **`#sujet`** et **`#expected`** (remarquez : pas de parenthèses).

Par exemple : 

~~~ruby
CLITest.new("Mes messages personnalisés avec sujet et valeur attendue") do
  
  expect(12).greater_than(11, failure: "Comment #sujet pourrait-il être supérieur à #expected ???")
  # => Produira la failure "Comment le nombre 12 pourrait-il être supérieur au nombre 11 ???"
end
~~~

<a id="messages-debug"></a>

### Messages de débuggage

On peut afficher des messages de débuggage qui ne s’afficheront qu’avec l’option `-v`/`--verbose` en utilisant la tournure :

~~~ruby
# Message court
puts "Mon message de débug" if verbose?

# Message long
  puts <<~TEXT if verbose?
	Mon
	message
	de
	débug.
TEXT
~~~




---

<a id="annexe"></a>

## Annexe

<a id="config-file"></a>

### Fichier de configuration

On peut créer un **fichier de configuration à la racine de l’application** à tester en lui donnant le nom `clitest.config.yaml`.

Voir la section [réglage des paramètres](#setup) pour trouver les éléments qu’on peut définir dedans.



<a id="all-touches"></a>

### Liste complète des touches

| Touche                         | Code                                   |
| ------------------------------ | -------------------------------------- |
| Flèche bas                     | `key(:down)`<br />`key[:arrow_down]`   |
| Touche Return (retour chariot) | `key[:n]`<br />`key[:return]`          |
| Flèche vers droite             | `key[:right]`<br />`key[:arrow_right]` |
| Flèche vers haut               | `key[:up]`<br />`key[:arrow_up]`       |
| Flèche vers gauche             | `key[:left]`<br />`key[:arrow_left]`   |
| Touche Backspace               | `key[:backspace]`                      |
| Touche Ctrl + c                | `key[:control_c]`                      |
| Touche Ctrl + d                | `key[:control_d]`                      |
| Touche Ctrl + z                | `key[:control_z]`                      |
|                                |                                        |


<a id="gels"></a>

### Gels et dégels

Les gels et les dégels sont utilisés pour repartir rapidement d’un état de l’application (au niveau des fichiers, de la base de données, des configurations, etc.). Dans les tests, la commande **`degel`** permet d’appeler un état gelé.

~~~ruby
CLITest.new("Mon test avec dégel") do
  
  degel('etat-initial')
  
  # ... opérations
  
end
~~~

Cette fonctionnalité étant intrinsèquement liée au fonctionnement de l’application testée, il est nécessaire de programmer par soi-même le fonctionnement d’un dégel.

~~~ruby
# À placer dans un fichier qui sera toujours requis lors du lancement des tests
class CLITest
  class Gels
    
    def self.degel
      
      # Les opérations à exécuter pour dégeler les données
 			# --------------------------------------------------
      # - Remise dans l'état de la base de données (injection des données)
      # - Restauration des données sur disque (p.e. dossier 'data')
      # - Fichier de configuration
      # - etc.
      
    end
    
  end #/Gels
end #/CLITest
~~~



---

<a id="data-menus"></a>

### Définition intelligente des menus

Comme nous l’avons dit, on peut définir les différents menus qui sont rencontrés au cours de l’utilisation de l’application (avec `tty-prompt`) par exemple, grâce à la méthode `keys_to_menu(<menu>)`.

Cette données se compose de cette manière :

~~~ruby
DATA_MENUS = [
	{name: "Mon premier menu", value: [<classe>, <methode>]},
  {name: "Mon second menue", value: [
  	{name: "Mon premier sous-menu du second menu", value: [<classe>, <methode>]},
    {name: "Mon second sous-menu du second menu", value: [<d’autres menus> ]}
  ]}
]
~~~

Comme on peut le voir, chaque élément de la liste se compose comme une donnée `choices` de `tty-prompt`, avec en `:name` le nom qui apparaitra à l’écran et en value :

* soit la méthode de classe qu’il faudra invoquer (la procédure à lancer) — qui peut elle-même retourner une liste de menus dynamiques !),
* soit une nouvelle définition de menus pour des menus imbriqués.

#### Illustration de l’helper `keys_to_menu`

Avec les données ci-dessus, si nous appelons :

~~~ruby
CLITest.new("Ma séquence de menu") do
  
  sequence = keys_to_menu("Mon second sous-menu de second menu")
  # -> retournera (en abrégé humainement compréhensible) :
  #    [
  #      <flèche bas>, 		# pour descendre au second menu
  #      <retour chariot>	# pour entrer dans le second menu et
  #												# afficher ses sous-menus
  #												# le premier sous-menu est sélectionné
  #      <flèche bas>			# pour descendre au second sous-menu que
  #												# nous voulons
  #			 <retour chariot> # pour activer ce menu
  #    ]
  
end
~~~

Il suffit ensuite de définir les actions à faire. Par exemple :

~~~ruby
CLITest.new("Ma séquence de menu") do
  sequence = keys_to_menu("Mon second sous-menu de second menu")
  sequence += [
  	key(:n),   				# pour valider le premier choix par défaut
    "Bonjour\n", 			# pour écrire "Bonjour" et valider
    key([:down, :n])	# pour choisir le 2e choix proposé et valider
    									# Noter l'utilisation d'une liste de touches ici
    etc.
  ]
end
~~~

Noter que si l’on ne veut pas que le menu soit activé (pour vérifier par exemple qu’il affiche le bon texte seulement), il suffit de `pop`er la séquence :

~~~ruby
CLITest.new("Ma séquence jusqu'au menu non joué") do
  sequence = keys_to_menu("Mon second sous-menu de second menu")
  sequence.pop
  contenu_fenetre = run('macommande', sequence, 4)
  # => Retourne le contenu de la fenêtre avec la flèche sur le
  #    second sous-menu qui n'a pas été joué.
end
~~~

## Mots réservés

Les mots réservés, donc impossible à utiliser à l’intérieur des cas de tests sont les suivants :

* **`degel`**. Permet de gérer les [gels et les dégels](#gels)
* **`expect`**. Produit une expectation, une attente concernant un résultat.
* **`key`**. Permet d’obtenir les touches pour composer les séquences de la commande `run`.
* **`run`**. La méthode invoquant l’application testée.
* **`resultat`**. Reçoit le retour de la commande `run`, c’est-à-dire le contenu de la fenêtre, ou seulement une portion. Particulièrement utile pour les blocs [`with_waiting_message`](#with-waiting-message).
