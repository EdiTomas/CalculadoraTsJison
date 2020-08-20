/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%
\s+											// se ignoran espacios en blanco
"//".*	
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]	
"print"             return 'imprimir';
"string"            return 'rstring';
"int"               return 'rint';
"double"            return 'rdouble';
"bool"              return 'rbool';
"char"              return 'rchar';
"do"                return 'rdo';
"while"             return 'rwhile';
"if"                return 'rif';
"else"              return 'relse';
"for"               return 'rfor';
"switch"            return 'rswicht';
"case"              return 'rcase';
"default"           return 'rdefault';
"continue"          return 'rcontinue';
"break"             return 'rbreak';
"void"              return 'rvoid';
"true"              return 'rtrue';
"false"             return 'rfalse';
";"                 return 'ptcoma'; 
"("                 return 'pa_izq';
")"                 return 'pa_der';
"}"                 return 'lla_izq';
"{"                 return 'lla_der';
"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'por';
"/"                 return 'div';
"%"                 return 'mod';
"="                 return 'igual';
"=="                return 'equals';
"!="                return 'diferente';
">="                return 'mayorigual';
"<="                return 'menorigual';
"<"                 return 'menor';
">"                 return 'mayor';
"&&"                return 'and';
"||"                return 'or';
"!"                 return 'not';
"++"                return 'incremento';
"--"                return 'decremento';





/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

\"[^\"]*\"				{ yytext = yytext.substr(1,yyleng-2); 
                          return 'cadena'; 
						}
[0-9]+("."[0-9]+)?\b    return 'decimal';
[0-9]+\b                return 'entero';
\'[.]?\'                return 'caracter'
([a-zA-Z])[a-zA-Z0-9_]*	return 'id';
<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

%{
//const TIPO_OPERACION	= require('./instrucciones').TIPO_OPERACION;
//	const TIPO_VALOR 		= require('./instrucciones').TIPO_VALOR;
//	const TIPO_DATO			= require('./tabla_simbolos').TIPO_DATO; //para jalar el tipo de dato
//	const instruccionesAPI	= require('./instrucciones').instruccionesAPI;
 const tipoexpr  =   require('./Expresion').Operadores        
 const tipoValor =   require('./Valor').valores        
  
%}



/* Asociación de operadores y precedencia */

%left  'mas' 'menos'
%left  'por' 'div' 'mod'
                  // %left  exponente    
%left  'umenos'
%left  'or'
%left  'and'
%right 'not'
%nonassoc 'equals' 'diferente' 'menorigual' 'mayorigual' 'menor' 'mayor'  

%start init

%% /* Definición de la gramática */

init
	: L_INSTRUCCIONES EOF
     {
		 return $1;
	 } 
;

L_INSTRUCCIONES
              : L_INSTRUCCIONES  L_INSTRUCCION {}
              | L_INSTRUCCION {}  
;

L_INSTRUCCION : DECLARACION {}
              | IMPRIMIR   {}   
              | SENTENCIA {} 
;

DECLARACION 
            : TIPO id igual EXP ptcoma   
              {}
 ;

IMPRIMIR 
       : imprimir pa_izq EXP pa_der  
         {}
;

TIPO : rstring  {}
     | rint     {}
	 | rdouble  {} 
     | rbool    {}
	 | rchar    {}
;

EXP
	: EXP or EXP         {}
	| EXP and EXP        {}
	| not EXP            {}
	| EXP equals EXP     {}
    | EXP diferente EXP  {}
	| EXP mayorigual EXP {}
    | EXP menorigual EXP {}
    | EXP menor EXP {}
	| EXP mayor EXP {}
	| menos EXP %prec umenos  { $$ = $2 *-1; }
	| EXP mas EXP             { $$ = $1 + $3; }
	| EXP menos EXP           { $$ = $1 - $3; }
	| EXP por  EXP            { $$ = $1 * $3; }
	| EXP div EXP             { $$ = $1 / $3; }
	| EXP mod EXP             { $$ = $1 / $3;}
	| pa_izq EXP pa_der       { $$ = $2;  }
	| entero                  { $$ = $1;  }
	| decimal                 { $$ = $1; }
	| cadena   {  $$ = $1; }
	| id       {  $$ = new Valor(char($1),tipoValor.caracter);    }
	| caracter {     
	   $$ = $1;
	 }
               
;
SENTENCIA 
          : IF
		     {

			 }
		  | WHILE
		    {

			}  
		  | DOWHILE
		   {

		   } 
	    //| FOR 
;
DOWHILE 
       :lla_izq L_INSTRUCCIONES lla_der rwhile pa_izq E pa_der ptcoma
         {

		 }
;

WHILE 
       : rwhile pa_izq E pa_der lla_izq L_INSTRUCCIONES lla_der
         {

		 }
;

IF 
     : rif pa_izq E pa_der lla_izq L_INSTRUCCIONES lla_der ELSE
       {

	   }
     | rif pa_izq E pa_der lla_izq L_INSTRUCCIONES lla_der
      {

	  }
     
;
ELSE 
      : relse lla_izq L_INSTRUCCIONES lla_der
        {}
;




  // | rif pa_izq E pa_der lla_izq L_INSTRUCCIONES lla_der ELSEIF
  // | rif pa_izq E pa_der lla_izq L_INSTRUCCIONES lla_der ELSEIF ELSE


/*
ELSEIF 
       :   relse pa_izq E pa_der lla_izq L_INSTRUCCIONES lla_der ELSEIF
       |   relse pa_izq E pa_der lla_izq L_INSTRUCCIONES lla_der ELSE
;
*/


