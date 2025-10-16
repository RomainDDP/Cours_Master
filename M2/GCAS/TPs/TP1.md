# TP1 - Prise en main

L'objectif de ce TP est de mettre un oeuvre un compilateur pour un langage dédié **IOML** (Input-Output Management Language) dont (a) le front-end est fourni et (b) le back-end reste à écrire. Les phases à implanter sont une partie de l'analyse sémantique, la génération du code, la sélection des instructions, l'allocation des registres et des optimisations.

Pour réaliser le TP, suivez les directives qui vont suivre et essayez de vous conformer au temps indicatif fourni pour chaque partie.

_Le TP se clôture par la remise des sources que vous aurez produit sur le dépôt correspondant sur Moodle à la date demandée._

Pour obtenir l'archive à déposer, tapez la commande :
```
	$ make tp1
```

## Le langage IOML (20mn)

* la structure du code imposant l'utilisation d'automate/machine à état.

Les instructions peuvent être :

* des affectations

	`GPIOD_BSRR = 1 << GREEN_LED`

* des affectations de bit(s) ou de champs de bits

	`GPIOD_BSRR[GREEN_LED + 16] = 1`

	`GPIOA_OTYPER[2*USER_BUT+1 .. 2*USER_BUT] = GPIO_PUPDR_PD`

* des sélections

	`if TIM3_CNT > 10 then ... else ... endif`

* des changements d'état

	`goto down`

* l'arrêt du programme

	`stop`

Le langage n'accepte qu'un seul type de donné : les entiers 32-bit, et implante les expressions habituelles du C avec des opérateurs supplémentaires :
* `E1 >>> E2` : rotation à droite,
* `E1 <<< E2` : rotation à gauche,
* `E1 [E2]` : accès au bit de numéro _E2_,
* `E1 [E2 .. E3]` : accès à un champ de bit (à partir du bit de poids faible _E3_ jusqu'au bit de poids fort _E2_ inclusif).

On notera également que, contrairement au C, conditions et expressions n'ont pas la même nature. Les conditions peuvent être formées de comparaisons (`\=\=`, `!=`, ...) et des constructeurs logiques `not`, `and` et `or`.

Enfin, le programme en `.ioc` est composé d'entités qui peuvent être:

* des constantes

	`const GPIO_MODER_OUT = 0b01`

* des variables

	`var x`

* des registres d'entrée/sortie

	`const GPIOA_BASE = 0x40020000 + 0*0x400`

	`reg GPIOA_ODR @ GPIOA_BASE + 0x14`


* des signaux (des bits dans les registres d'entrée/sortie)

	`sig BUTTON @ GPIOA_IDR[USER_BUT]`

* des automates

```
auto A

	GPIOD_MODER[2*GREEN_LED+1 .. 2*GREEN_LED] = GPIO_MODER_OUT
	GPIOA_MODER[2*USER_BUT+1 .. 2*USER_BUT] = GPIO_MODER_IN
	GPIOA_OTYPER[2*USER_BUT+1 .. 2*USER_BUT] = GPIO_PUPDR_PD

	state up:
		GPIOD_BSRR[GREEN_LED + 16] = 1
		when BUTTON:
			goto down

	state down:
		GPIOD_BSRR[GREEN_LED] = 1
		when !BUTTON:
			goto up
```

[VIEW] Pour visualiser un programme complet, vous pouvez ouvrir test [pushdown-init.io](test/pushdown-init.io).

Dans le programme ci-dessus, les GPIO A et B sont initialisés dans l'automate `A` qui démarre dans l'état `up`.

A l'entrée de l'état `up`, la LED verte est éteinte et dès que le signal `BUTTON` se déclenche (le bit `USER_BUT` de `GPIOA_IDR` passe à 1), l'automate passe dans l'état `down`. Ce dernier éteint la LED et attend que `BUTTON` passe à 0 pour repasser dans l'état `up`. Bien sûr, on peut avoir autant de clauses `when` que l'on veut.

> Pour notre compilateur, on considèrera seulement qu'on dispose d'un seul automate.




## Structure du compilateur (20mn)

**[TODO]** Construisez le compilateur avec `make`.
	`$ make`

**[TODO]** Compilez votre premier fichier :

	`$ ./ioc -print-ast -stop-after-print test/pushdown-init.io`

Les fichiers suivants sont intéressants :

* `lexer.ll` -- analyseur lexical.
* `parser.yy` -- analyseur syntaxique.
* `main.cpp` -- programme principal, interface de commande.
* `AST.hpp`, `AST.cpp` -- classes pour les AST.
* `eval.cpp` -- fonctions pour l'évaluation des expressions constantes.
* `reduce.cpp` -- fonctions pour la réduction des expressions constantes.

D'autres fichiers sources seront explorées dans le reste des TPs mais nous allons nous focaliser sur les AST.

La définition des classes pour représenter les AST se trouve dans le fichier `AST.hpp`. La classe de base s'appelle `AST` et fournit principalement des services pour localiser l'AST dans le source (variable `pos`) et une fonction abstraite pour afficher les AST : `AST::print()` qui est appelée quand on essaie d'afficher un AST sur `cout`.

La classe `AST` se décline selon 4 sous-classes :

* `Statement` -- les instructions,
* `Expression` -- les expressions,
* `Condition` -- les conditions,
* `Declaration` -- les déclarations (variable, registre, etc).

A leur tour, ces classes sont dérivées en sous-classes pour couvrir toutes les formes des AST. Par exemple, `Statement` est dérivée en `SetStatement`, `SeqStatement`, `IfStatement`, etc. On remarquera que chaque famille d'AST partage un type -- fonction `type()` permettant de retrouver le vrai type de l'AST.

La classe `AutoDecl` permet de représenter un automate, c'est l'AST le plus complexe : il est donc composé d'états (classe `State`) et chaque état est composé de clauses _when_ (classe `When`).


## Analyse sémantique : réduction des constantes (temps restant)

Certaines constructions de **IOML** nécessitent des constantes mais ces constantes peuvent être calculées à partir d'autres constantes (comme l'adresse des registres d'entrée/sortie calculée à partir de l'adresse de base). Il s'agit de la valeur d'une constante, de l'initialisation d'une variable, de l'adresse d'un registre ou de l'indice du bit utilisé dans un signal, comme dans les exemples ci-dessous :

```
	const GPIOA_BASE = 0x40020000 + 0*0x400
	reg GPIOA_IDR @ GPIOA_BASE + 0 x10
	const USER_BUT = 0
	const GREEN_LED = 12
	sig BUTTON @ GPIOA_IDR[USER_BUT]
```

Donc, au moment de l'analyse, ces constantes sont vues comme des expressions qui doivent être réduites en constantes de type `value\_t` = `uint32\_t`. Pour ce faire, on utilise les fonctions `eval()` de la classe `Expression`. Cette fonction renvoie une valeur optionnelle de type `optional\<value\_t>`. Cette valeur s'évalue à _vrai_ si elle est définie (constante), à _faux_ sinon. Dans le premier cas, on peut utiliser `\*` pour récupérer la valeur optionnelle. Au nvieau du C++, cette valeur peut être renvoyée par `{}` pour indiquer une valeur _indéfinie_ ou la valeur elle-même.

Ainsi, si on a l'addition, `A + B`, on évalue _A_ et _B_ et si les deux renvoient des valeurs optionnelles définies (constantes), on peut produire une nouvelle constante _A_ + _B_ dont la valeur est renvoyée. Si _A_ ou _B_ sont indéfinies (une des deux n'est pas constante), alors la somme n'est pas une constante et on renvoie la valeur indéfinie `{}`.

**[TODO]** L'implémentation de l'évaluation des constantes est définie dans le fichier `eval.cpp` où on retrouve la spécialisation de cette fonction pour chacune des classes dérivées d'`Expression` :

1. Observez et comprenez `ConstExpr::eval()`.
2. Observez et comprenez `MemExpr::eval()`.
3. Complétez `UnopExpr::eval()`.
4. Complétez `BinopExpr::eval()`.
5. Ecrivez `BitFieldExpr::eval()`.

> **ATTENTION :** si BitFieldExpr avait une forme avec un seul indice, `\_hi` = `\_lo`, il serait bien que, après réduction, on garde cette propriété. Cela nous permettra d'améliorer les phases de compilation suivantes.

Vous pourrez tester votre implantation avec les fichiers `eval.io`, `noconst.io` et `test/pushdown.io`. Pour appeler le compilateur sur ces fichiers, on tapera la commande :

	`$ ./ioc -print-ast -reduce-const -stop-after-print test/fichier.io`

> **ATTENTION :** que fait-on quand on a une expression _e1 / e2_ avec _e1_ et _e2_ constants et _e2 = 0_ ?


Il est possible d'appliquer cette évaluation de constante aux expressions utilisées dans les AST : ainsi, toute expression constante ne génèrera pas de code et l'exécution sera plus rapide. Pour cela, on ajoute à chaque AST une fonction `AST::reduce()` qui est appelée pour tenter de réduire au maximum les expressions contenues dans les AST. Elle est définie dans les classes et sous-classes `Statement`, `Condition` et `Declaration`.

Dans le cas des expressions, cette fonction renvoie l'expression réduite en constante (class `ConstExpr`) si cela est possible ou elle essaie de réduire en constante une des sous-expressions de l'expression. Ces fonctions sont définies dans le fichier `reduce.cpp`.


**[TODO]** Complétez les fonctions `reduce()` suivantes (vous remarquerez qu'on utilise autant-que-faire-se-peut les fonctions `eval` définies dans l'exercice précédent):

1. Observez et analysez les fonctions `reduce()` des classes `Statement` et `Condition`.
2. Implantez `BinopExpr::reduce()`.
3. Implantez `BitFieldExpr::reduce()`.

> **ATTENTION :** la remarque ci-dessus faite sur `BitFieldExpr` s'applique également.

Vous pourrez tester la fonction avec le fichier `test/pushdown.io`. Pour appeler le compilateur sur ces fichiers, on tapera la commande :

	`$ ./ioc -print-ast -reduce-const -stop-after-print test/fichier.io`
