<%
/* 
    This is a very simple example how to use HTML5 together with CSS and a little bit
    of JavaScript together with RPG in IceBreak.
    The main work happens in the HTML File, which is saved in a template file, we 
    include into the RPG code via the #include Function.
    
    ATTENTION:
    Please be aware that you can use any ILE Language (RPG, COBOL, C, C++, CL) in any 
    format (Total Free, fixed format or mixed) the Compilers can compile!

    You can find my IceBreak Tutorials at:
    https://www.mlitters.com/IceDocu.aspx

    -----------------------------------------------------------------------------

    Dies ist ein einfaches Beispiel, wie man mittels IceBreak HTML5 zusammen mit CSS
    und ein klein wenig JavaScript direkt in RPG nutzen kann.
    Die Hauptarbeit findet dabei in der HTML Datei statt, die in eine template Datei
    ausgelagert wurde und mittels IceBreak #include Funktion eingebunden wird.

    ACHTUNG: 
    Sie können jede ILE Sprache (RPG, COBOL, C, C++, CL) verwenden in jedem Format 
    (Total Free, spaltenorientiert oder gemischt), welche die IBM Compiler umwandeln können.

    Meine IceBreak Tutorials finden Sie unter:
    https://www.mlitters.com/IceDocu.aspx
*/
ctl-opt BndDir('JSONPARSER' : 'ICEBREAK');

/include qasphdr,jsonparser

dcl-s pJson2 varchar(5000);
dcl-s pJson3 varchar(5000);
// Änderung wegen git

dcl-ds chartDS qualified;
    jan    zoned(4:0) inz(30);
    feb    zoned(4:0) inz(200);
    mar    zoned(4:0) inz(100);
    apr    zoned(4:0) inz(400);
    mai    zoned(4:0) inz(150);
    jun    zoned(4:0) inz(250);
    jul    zoned(4:0) inz(130);
    aug    zoned(4:0) inz(100);
    sep    zoned(4:0) inz(140);
    okt    zoned(4:0) inz(200);
    nov    zoned(4:0) inz(150);
    dez    zoned(4:0) inz(50);
end-ds;

 setContentType('text/html;charset=UTF-8');               

 chartDS.jan = FormNum('januar'); 
 chartDS.feb = FormNum('februar'); 
 chartDS.mar = FormNum('maerz'); 

 // Der Einfachheit halber wird das JSON hier als String zusammengebaut
 // Alternativ kann dies mit den mächtigen JSON Funktionen von
 // IceBreak erledigt werden, welche eine dynamische Erstellung sehr 
 // leicht machen (s. hierzu die REST Beispiele)
pJson2 = '{ +
                    bindto: "#mitte", +
                    data: { +
                        type: "bar", +
                        columns: [ +
                            ["Halbjahr1", ' + %char(chartDS.jan) + ', ' + 
                            %char(chartDS.feb) + ', ' + 
                            %char(chartDS.mar) + ', ' + 
                            %char(chartDS.apr) + ', ' + 
                            %char(chartDS.mai) + ', ' + 
                            %char(chartDS.jun) + '], +
                            ["Halbjahr2", ' + %char(chartDS.jul) + ', ' + 
                            %char(chartDS.aug) + ', ' + 
                            %char(chartDS.sep) + ', ' + 
                            %char(chartDS.okt) + ', ' + 
                            %char(chartDS.nov) + ', ' + 
                            %char(chartDS.dez) + '] +
                        ] +
                    } +
                }';

%>

<!--#include file="#.htm" tag="Init" -->

<!--#include file="#.htm" tag="Example" -->

<!--#include file="#.htm" tag="End" -->

<% *inlr = *on;
   return; %>

