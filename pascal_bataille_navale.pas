PROGRAM bataille_navale;
uses crt;

//Principe : Utiliser des fonctions et des procédures. Mon but étant de ne pas réaliser une bataille navale classique, mais une bataille à un bateau, avec un joueur plaçant le bateau et l'autre essayant de deviner. Cependant, pour faire une bataille navale "classique", il suffirait de créer deux procédures de création de flottes afin de permettre à deux joueurs de jouer.

TYPE cell = RECORD
	row,col : integer;
END;

TYPE bateau = RECORD
	case1,case2,case3 : cell;
END;

TYPE flotte = RECORD
	bateau1,bateau2,bateau3 : bateau;
END;

procedure creation_case (ma_case:cell);
VAR
	cpt:integer;
BEGIN
	FOR cpt:=1 TO 5 DO
	BEGIN
		ma_case.row:=cpt;
		ma_case.col:=cpt;
	END;
END;

function comparaison_cases (ma_case:cell;mon_bateau:bateau) : boolean;
BEGIN
	comparaison_cases:=(((ma_case=mon_bateau.case1)AND(ma_case<>mon_bateau.case2)AND(ma_case<>mon_bateau.case3))OR((ma_case=mon_bateau.case2)AND(ma_case<>mon_bateau.case1)AND(ma_case<>mon_bateau.case3))OR((ma_case=mon_bateau.case3)AND(ma_case<>mon_bateau.case2)AND(ma_case<>mon_bateau.case1)));
END; // FPC affiche que mes lignes sont trop longues, mais, problème plus important, (une erreur que je n'ai malheureusement pas réussi à résoudre), FPC m'affiche également une erreur "operator overloaded", je pense donc que ma condition est trop longue, mais je n'ai pas trouvé le moyen de la racourcir.

procedure creation_bateau (mon_bateau:bateau);
BEGIN
	WHILE (((mon_bateau.case1.row<1)OR(mon_bateau.case1.row>5))AND((mon_bateau.case1.col<1)OR(mon_bateau.case1.col>5)))
	BEGIN
	writeln('Entrez la premiere case de votre bateau, en premier la ligne puis la colonne');
	readln(mon_bateau.case1.row);
	readln(mon_bateau.case1.col);
	END;
	WHILE ((((mon_bateau.case2.row<>mon_bateau.case1.row-1)OR(mon_bateau.case2.row<>mon_bateau.case1.row+1))AND(mon_bateau.case2.col<>mon_bateau.case1.col))OR(((mon_bateau.case2.col<>mon_bateau.case1.col-1)OR(mon_bateau.case2.col<>mon_bateau.case1.col+1))AND(mon_bateau.case2.row<>mon_bateau.case1.row))AND((mon_bateau.case2.row<1)OR(mon_bateau.case2.row>5))AND((mon_bateau.case2.col<1)OR(mon_bateau.case2.col>5))) DO
	BEGIN
		writeln('Entrez la deuxieme case de votre bateau, en premier la ligne puis la colonne');
		readln(mon_bateau.case2.row);
		readln(mon_bateau.case2.col);
	END;
	WHILE ((((mon_bateau.case3.row<>mon_bateau.case2.row-1)OR(mon_bateau.case3.row<>mon_bateau.case2.row+1))AND(mon_bateau.case3.col<>mon_bateau.case2.col))OR(((mon_bateau.case3.col<>mon_bateau.case2.col-1)OR(mon_bateau.case3.col<>mon_bateau.case2.col+1))AND(mon_bateau.case3.row<>mon_bateau.case2.row))AND((mon_bateau.case3.row<1)OR(mon_bateau.case3.row>5))AND((mon_bateau.case3.col<1)OR(mon_bateau.case3.col>5))) DO
	BEGIN
		writeln('Entrez la troiIFeme case de votre bateau, en premier la ligne puis la colonne');
		readln(mon_bateau.case3.row);
		readln(mon_bateau.case3.col);
	END;
END;

function touche_bateau (ma_case:cell,mon_bateau:bateau,comparaison_case:boolean) : boolean;
BEGIN
	comparaison_case(ma_case,mon_bateau);
	touche_bateau:=comparaison_case;
END;

function touche_flotte (touche_bateau:boolean) : boolean;
BEGIN
	touche_flotte:=(coule=3);
END;
	

VAR
	coule,erreur : integer;
	ma_case:cell;
	mon_bateau:bateau;
	ma_flotte:flotte;

BEGIN
	coule:=0;
	erreur:=0;
	creation_case(ma_case);
	creation_bateau(mon_bateau);
	WHILE ((touche_flotte=FAUX)OR(erreur=10)) DO
	BEGIN
		writeln('Proposez une case');
		readln(ma_case);
		IF (touche_bateau=VRAI) DO
		BEGIN
			writeln('Touche !');
			coule:=(coule+1);
		ELSE
		writeln('Rate !');
		erreur:=(erreur+1);
		END;
	END;
	IF (touche_flotte=VRAI) THEN
	BEGIN
		writeln('Attaquant a gagne !');
	ELSE
		writeln('La flotte a gagne !');
	END;
END.