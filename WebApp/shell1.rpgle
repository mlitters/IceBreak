<%
/* 
    Send any QSHELL / PASE content to your Browser - no problem with IceBreak!
    
    ATTENTION:
    Please be aware that you can use any ILE Language (RPG, COBOL, C, C++, CL) in any 
    format (Total Free, fixed format or mixed) the Compilers can compile!

    You can find my IceBreak Tutorials at:
    https://www.mlitters.com/IceDocu.aspx

    -----------------------------------------------------------------------------

    Beliebige QSHELL / PASE Inhalte auf den Browser ausgeben - kein Problem mit IceBreak!

    ACHTUNG: 
    Sie können jede ILE Sprache (RPG, COBOL, C, C++, CL) verwenden in jedem Format 
    (Total Free, spaltenorientiert oder gemischt), welche die IBM Compiler umwandeln können.

    Meine IceBreak Tutorials finden Sie unter:
    https://www.mlitters.com/IceDocu.aspx
*/

// Example: 
// Use qsh and send the result back to the client
// ------------------------------------------------------------------ 
/free
  *inlr = *ON;
  %><html><body><pre><%
  shell ('ls');
  %></pre></body></html><%
/end-free
%>
