<%@ language="RPGLE" pgmtype="srvpgm" pgmopt="export(*ALL)" %>
<%
ctl-opt copyright('System & Method (C), 2016');
ctl-opt decEdit('0,') datEdit(*YMD.) nomain; 
ctl-opt bndDir('NOXDB' );
/* 
    This is a small IceBreak RPG Microservice Module example created in 2016.
    This is called via the Microservice Router you find in this folder too.

    ATTENTION:
    Please be aware that you can use any ILE Language in any format (Total Free,
    fixed format or mixed) the Compilers can compile!

    You can find my IceBreak Tutorials at:
    https://www.mlitters.com/IceDocu.aspx

    -----------------------------------------------------------------------------

    Bei diesem Beispiel handelt es sich um ein kleines IceBreak RPG 
    Microservice Modul aus 2016.
    Dieses Modul wird über den Microservice Router aufgerufen, welchen Sie ebenfalls
    in diesem Ordner finden.

    ACHTUNG: 
    Sie können jede ILE Sprache verwenden in jedem Format (Total Free, 
    spaltenorientiert oder gemischt), welche die IBM Compiler umwandeln können.

    Meine IceBreak Tutorials finden Sie unter:
    https://www.mlitters.com/IceDocu.aspx
*/
/* -----------------------------------------------------------------------------

  CRTICEPGM STMF('/www/MicroServices/msSimple.rpgle') SVRID(microserv)

  By     Date       PTF     Description
  ------ ---------- ------- ---------------------------------------------------
  NLI    22.06.2016         New program
  ----------------------------------------------------------------------------- */
 /include noxDB
 /include qasphdr,iceUtility

/* -------------------------------------------------------------------- *\ 
    The mother of all samples: hellow world
       
    note the "action" can be either from the URL or by a selfcontained message:

    dksrv206:60060/router?payload={
        "action":"msSimple.Hello",
        "message" : "My name is John"
    }

    or by url:

    dksrv206:60060/router/msSimple/Hello?payload={
        "message" : "My name is John"
    }

\* -------------------------------------------------------------------- */
dcl-proc Hello export;

    dcl-pi *n pointer;
        pInput          pointer value;
    end-pi;

    dcl-s  pOutput      pointer;
    dcl-s  n packed(5); 

    n = 123;

    pOutput = json_newObject();

    json_setStr(pOutput: 'text' : 'Hello world ' + %char(n));
    json_setStr(pOutput: 'time' : %char(%timestamp()));
    json_setStr(pOutput: 'message' : json_getStr(pInput : 'message'));
    
    return pOutput;

end-proc;
