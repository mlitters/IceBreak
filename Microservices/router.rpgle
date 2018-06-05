<%@ language="RPGLE" runasowner="*YES" owner="QPGMR"%>
<%
ctl-opt copyright('System & Method (C), 2016');
ctl-opt decEdit('0,') datEdit(*YMD.) main(main); 
ctl-opt bndDir('NOXDB':'ICEUTILITY':'QC2LE');
/* 
    This is a small IceBreak RPG Microservice Router example created in 2016.
    With this you can dynamically call ILE Modules in ILE Serviceprograms from
    everywhere via REST.
    Of course you should close this router for security reasons when you go live
    and limit the access to the modules you want to be called! :-)

    ATTENTION:
    Please be aware that you can use any ILE Language in any format (Total Free,
    fixed format or mixed) the Compilers can compile!

    You can find my IceBreak Tutorials at:
    https://www.mlitters.com/IceDocu.aspx

    -----------------------------------------------------------------------------

    Hier haben wir ein kleines Beispiel für einen IceBreak RPG Microservice Router.
    Mit diesem Programm können Sie jedes beliebige ILE Modul aus Ihren ILE Serviceprogrammen
    von überall als REST Call aufrufen.
    Selbstverständlich sollten Sie das Programm im Produktivbetrieb aus Sicherheitsgründen 
    auf die Module beschränken, die Sie tatsächlich aufrufen wollen! :-)

    ACHTUNG: 
    Sie können jede ILE Sprache verwenden in jedem Format (Total Free, 
    spaltenorientiert oder gemischt), welche die IBM Compiler umwandeln können.

    Meine IceBreak Tutorials finden Sie unter:
    https://www.mlitters.com/IceDocu.aspx
*/

/* -----------------------------------------------------------------------------
   Service . . . : microservice router
   Author  . . . : Niels Liisberg 
   Company . . . : System & Method A/S
  
   CRTICEPGM STMF('/www/MicroServices/router.rpgle') SVRID(microserv)
   
   By     Date       PTF     Description
   ------ ---------- ------- ---------------------------------------------------
   NLI    10.05.2016         New program
   ----------------------------------------------------------------------------- */
 /include noxdb 
 /include qasphdr,iceutility
 
// --------------------------------------------------------------------
// Main line:
// --------------------------------------------------------------------
dcl-proc main;

    dcl-s pPayload       pointer;

    pPayload = unpackParms();
    if pPayload <> *NULL;
        processAction(pPayload);
        cleanup(pPayload);
    endif;
    return;

end-proc;
// --------------------------------------------------------------------  
dcl-proc processAction; 

    dcl-pi *n;
        pAction pointer value;
    end-pi;
    
    dcl-s pResponse     pointer;        

    pResponse = runService (pAction);
    if (pResponse = *NULL);
        responseWrite('null');
    else;
        responseWriteJson(pResponse);
        if json_getstr(pResponse : 'success') = 'false';
            setStatus ('500 ' + json_getstr(pResponse: 'message'));
            consoleLogjson(pResponse);
        endif;
        json_close(pResponse);
    endif;

end-proc;
/* -------------------------------------------------------------------- *\  
   get data form request
\* -------------------------------------------------------------------- */
dcl-proc unpackParms;

    dcl-pi *n pointer;
    end-pi;

    dcl-s pPayload      pointer;
    dcl-s msg           varchar(4096);

    SetContentType('application/json; charset=utf-8');
    SetEncodingType('*JSON');
    json_setDelimiters('/\@[] ');
    json_sqlSetOptions('{'             + // use dfault connection
        'upperCaseColname: false,   '  + // set option for uppcase of columns names
        'autoParseContent: true,    '  + // auto parse columns predicted to have JSON or XML contents
        'sqlNaming       : false    '  + // use the SQL naming for database.table  or database/table
    '}');

    if getServerVar('REQUEST_METHOD') = 'POST';
        pPayload = json_ParseRequest();
    else;
        pPayload = *NULL;
    endif;

    if json_error(pPayload);
        msg = json_message(pPayload);
        %>{ "text": "Microservices. Ready for transactions. Please POST payload in JSON", "desc": "<%= msg %>"}<%
        return *NULL;
    endif;

    return pPayload;

end-proc;
// -------------------------------------------------------------------------------------
dcl-proc cleanup;
    
    dcl-pi *n;
        pPayload pointer value;
    end-pi;

    json_close(pPayload);

end-proc;
/* -------------------------------------------------------------------- *\ 
    run a a microservice call
\* -------------------------------------------------------------------- */
dcl-proc runService export; 

    dcl-pi *n pointer;
        pActionIn pointer value options (*string);
    end-pi;

    dcl-pr ActionProc pointer extproc(pProc);
        payload pointer value;
    end-pr;
    
    dcl-s Action        varchar(128);
    dcl-s prevAction    varchar(128) static;
    dcl-s pgmName       char(10);
    dcl-s procName      varchar(128);
    dcl-s pProc         pointer (*PROC) static;
    dcl-s pAction       pointer;
    dcl-s pResponse     pointer;        
    dcl-s errText       char(128);
    dcl-s errPgm        char(64);
    dcl-s errList       char(4096);
    dcl-s len           int(10);

// will return the same pointer id action is already a parse object
    pAction = json_parseString(pActionIn);

    action   = json_GetStr(pAction:'action');
    action = strUpper(action);
    pgmName  = word (action:1:'.');
    procName = word (action:2:'.');

    //if  action <> prevAction;
    //  prevAction = action;
    pProc = loadServiceProgramProc ('*LIBL': pgmName : procName);
    //endif;

    if (pProc = *NULL);
        pResponse= FormatError (
            'Invalid action: ' + action + ' or service not found'
        );
    else;
        monitor;

        pResponse = ActionProc(pAction);

        on-error;                                     
            soap_Fault(errText:errPgm:errList);    
            pResponse =  FormatError (
                'Error in service ' + action + ', ' + errText
            );
        endmon;                                         

    endif;

    // if my input was a jsonstring, i did the parse and i have to cleanup
    if pAction <> pActionIn;
        json_delete (pAction);
    endif;

    return pResponse; 

end-proc;

/* -------------------------------------------------------------------- *\ 
   JSON error monitor 
\* -------------------------------------------------------------------- */
dcl-proc FormatError export;

    dcl-pi *n pointer;
        description  varchar(256) const options(*VARSIZE);
    end-pi;                     

    dcl-s msg                   varchar(4096);
    dcl-s pMsg                  pointer;

    msg = json_message(*NULL);
    pMsg = json_parseString (' -
        { -
            "success": false, - 
            "description":"' + description + '", -
            "message": "' + msg + '"-
        } -
    ');

    consoleLog(msg);
    return pMsg;

end-proc;
/* -------------------------------------------------------------------- *\ 
   JSON error monitor 
\* -------------------------------------------------------------------- */
dcl-proc successTrue export;

    dcl-pi *n pointer;
    end-pi;                     

    return json_parseString ('{"success": true}');

end-proc;




