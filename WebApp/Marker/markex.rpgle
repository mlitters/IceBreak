<%@ language="RPGLE" %>
<%
ctl-opt copyright('edvberatung.litters (C), 2018');
ctl-opt decEdit('0,') datEdit(*YMD.) main(main);
/* 
    This example shows how to use Marker together with HTML #tags
    and the IceBreak Function "ResponseWriteTag".
    The output works similiar to the write into a Displayfile!

    ATTENTION:
    Please be aware that you can use any ILE Language in any format (Total Free,
    fixed format or mixed) the Compilers can compile!

    You can find my IceBreak Tutorials at:
    https://www.mlitters.com/IceDocu.aspx

    -----------------------------------------------------------------------------

    In diesem Beispiel sehen Sie, wie Sie mittels HTML #tags und der IceBreak 
    Funktion "ResponseWriteTag" sog. Marker nutzen können. 
    Dabei erfolgt die Ausgabe ähnlich wie ein WRITE in eine Display File!

    ACHTUNG: 
    Sie können jede ILE Sprache verwenden in jedem Format (Total Free, 
    spaltenorientiert oder gemischt), welche die IBM Compiler umwandeln können.

    Meine IceBreak Tutorials finden Sie unter:
    https://www.mlitters.com/IceDocu.aspx
*/
dcl-proc main;

  dcl-s index  int(10);

  ResponseWriteTag('./Beispiele/Marker/markex.htm' : '*FIRST');
  for index = 1 to 1000;
     SetMarker('MyCounter': %char(index));
     SetMarker('MyTime'   : %char(%timestamp));
     ResponseWriteTag('./Beispiele/Marker/markex.htm' : 'detail');
  endfor; 
  ResponseWriteTag('./Beispiele/Marker/markex.htm' : 'end');
  return; 

end-proc;
%>