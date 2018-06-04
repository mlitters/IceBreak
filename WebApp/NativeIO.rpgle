<%
/* 
    This is a very simple example how you can mix HTML5 together with RPG and native I/O.
    Therefore I used a mix of fixed-format and free RPG and a simple HTML Table.

    ATTENTION:
    Please be aware that you can use any ILE Language (RPG, COBOL, C, C++, CL) in any 
    format (Total Free, fixed format or mixed) the Compilers can compile!

    You can find my IceBreak Tutorials at:
    https://www.mlitters.com/IceDocu.aspx

    -----------------------------------------------------------------------------

    Dies ist ein einfaches Beispiel, wie man HTML5 mit RPG und native I/O mischen kann.
    Ich habe hier wieder spaltenorientiertes RPG mit Free RPG gemischt und einer einfachen
    HTML Tabelle.

    ACHTUNG: 
    Sie können jede ILE Sprache (RPG, COBOL, C, C++, CL) verwenden in jedem Format 
    (Total Free, spaltenorientiert oder gemischt), welche die IBM Compiler umwandeln können.

    Meine IceBreak Tutorials finden Sie unter:
    https://www.mlitters.com/IceDocu.aspx
*/
FPRODUCT   IF   E           K DISK
D i               s              4B 0

%>
<table border="1">
    <thead>
        <tr>
            <th>Produkt ID</th>
            <th>Beschreibung</th>
        </tr>
    </thead>
<%
/Free
    setll *loval PRODUCTR;
    read PRODUCTR;  
    i = 0;                                                                   
    dow (not %eof(PRODUCT) and i < 200) ; 
      i = i + 1; 
%>
    <tr>
        <td><% = ProdId %></td>
        <td><% = Desc %></td>
    </tr>
<%
      read PRODUCTR;  
    EndDo;
%>
</table>
<%
    *inlr=*on;
    return;
/End-Free
%>
