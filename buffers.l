%option noyywrap
%{
#include <iostream>
#include <stdlib.h>
using namespace std;
#define YY_DECL extern "C" int yylex()

%}

%x incl
%%

include BEGIN(incl);
[A-Za-z]+ {cout<<"text\n";}
<incl>[ \t]*"<"	
<incl>[^ \t\n>]+ { yyin = fopen(yytext,"r");
		if(!yyin)
		cout<<"ERROR opening file";
		else
		cout<<"Reading file : "<<yytext<<"\n";
		yypush_buffer_state(yy_create_buffer( yyin, YY_BUF_SIZE ));
BEGIN(INITIAL)	;}

 <<EOF>> {
     			yypop_buffer_state();
     
                 if ( !YY_CURRENT_BUFFER )
                     {
                     yyterminate();

                   }
                 }
. ;
%%
int main()
{
FILE *myfile = fopen("sample.txt", "r");
if (!myfile) {
cout << "not opened!"<<endl;
}
yyin = myfile;
yypush_buffer_state(yy_create_buffer(yyin, YY_BUF_SIZE));
yylex();
}
 

