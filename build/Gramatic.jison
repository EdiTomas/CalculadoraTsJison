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
";"                 return 'ptcoma'; 
"("                 return 'pa_izq';
")"                 return 'pa_der';
"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'por';
"/"                 return 'div';
"%"                 return 'mod';





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
//	const instruccionesAPI	= require('./instrucciones').instruccionesAPI;
 const {Suma}  =   require('./Suma')        
 const {Resta} =   require('./Resta')        
 const {Multiplicacion} =   require('./Multiplicacion')        
 const {Division} =   require('./Division')    
 const {Modulo} =   require('./Modulo')
 const {Menos} =   require('./menos')
 const {Valor}= require('./Valor')        
  
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
	: EXP EOF
     {
		 return $1;
	 } 
;
 EXP 
     : menos EXP %prec umenos  { $$ = new Menos($2,@1.first_line,@1.first_column); }
	 | EXP mas EXP             { $$ = new Suma($1,$3,@2.first_line,@2.first_column); }
	 | EXP menos EXP           { $$ = new Resta($1,$3,@2.first_line,@2.first_column); }
	 | EXP por  EXP            { $$ = new Multiplicacion($1,$3,@2.first_line,@2.first_column); }
	 | EXP div EXP             { $$ = new Division($1,$3,@2.first_line,@2.first_column); }
	 | EXP mod EXP             { $$ = new Modulo($1,$3,@2.first_line,@2.first_column);}
	 | pa_izq EXP pa_der       { $$ = $2;  }
	 | entero                  { $$ = new Valor(Number($1)); }
	 | decimal                 { $$ = new Valor(Number($1)); }
;


