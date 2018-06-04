<%
/* 
    Classical Hello World exmaple.
    Call this program from within your Browser like this:
    http://192.168.1.1:7900/hello.rpgle?name=Hugo

    Where you should enter the IP of your IBM i and the port number of 
    your IceBreak Server Instance which is running the example.
    
    ATTENTION:
    Please be aware that you can use any ILE Language (RPG, COBOL, C, C++, CL) in any 
    format (Total Free, fixed format or mixed) the Compilers can compile!

    You can find my IceBreak Tutorials at:
    https://www.mlitters.com/IceDocu.aspx

    -----------------------------------------------------------------------------

    Das klassische Hallo Welt Beispiel.
    Rufen Sie dieses Programm aus Ihrem Browser wie folgt auf:
    http://192.168.1.1:7900/hello.rpgle?name=Hugo

    Wobei SIe bitte die IP Adresse Ihrer IBM i und die Portnummer der IceBreak Server
    Instanz verwenden, auf der das Beispiel läuft.

    ACHTUNG: 
    Sie können jede ILE Sprache (RPG, COBOL, C, C++, CL) verwenden in jedem Format 
    (Total Free, spaltenorientiert oder gemischt), welche die IBM Compiler umwandeln können.

    Meine IceBreak Tutorials finden Sie unter:
    https://www.mlitters.com/IceDocu.aspx
*/
    dcl-s name char(30);
    name = reqstr('name');
%>
    Willkommen bei meinen IceBreak Beispielen <%=name%>
<% 
    *inlr=*on;
    return;
%>
