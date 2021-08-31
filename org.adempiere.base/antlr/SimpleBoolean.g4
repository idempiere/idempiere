grammar SimpleBoolean;
@header {
    package org.idempiere.expression.logic;
}
parse
 : expression EOF
 ;

expression
 : LPAREN expression RPAREN                       #parenExpression
 | NOT expression                                 #notExpression
 | left=expression op=comparator right=expression #comparatorExpression
 | left=expression op=binary right=expression     #binaryExpression
 | bool                                           #boolExpression
 | VARIABLE				    	    			  #contextVariables
 | QTEXT										  #quotedText
 | DQTEXT										  #doubleQuotedText
 | TEXT                                     	  #text
 | DECIMAL                                        #decimalExpression
 ;

comparator
 : GT | GE | LT | LE | EQ | NE | RE
 ;

binary
 : AND | OR
 ;

bool
 : TRUE | FALSE
 ;

AND        : '&' ;
OR         : '|' ;
NOT        : '$!';
TRUE       : 'true' ;
FALSE      : 'false' ;
GT         : '>' ;
GE         : '>=' ;
LT         : '<' ;
LE         : '<=' ;
EQ         : '=' ;
NE         : [!^] ;
RE		   : '~' ;
LPAREN     : '(' ;
RPAREN     : ')' ;
DECIMAL    : '-'? [0-9]+ ( '.' [0-9]+ )? ;
VARIABLE   : '@'(.*?)'@' ;
QTEXT 	   : ['](.*?)['] ;
DQTEXT 	   : ["](.*?)["] ;
TEXT 	   : [a-zA-Z_0-9,]+ ;
WS         : [ \r\t\u000C\n]+ -> skip;
