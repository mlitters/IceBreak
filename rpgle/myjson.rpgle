<%@ language="RPGLE" %>
<%
ctl-opt copyright('edvberatung.litters (C), 2018');
ctl-opt decEdit('0,') datEdit(*YMD.) main(main);
ctl-opt debug(*yes) bndDir('NOXDB' :'ICEUTILITY':'QC2LE':'ICEBREAK');
/* ----------------------------------------------------------------------------- */
// Include the IceBreak, ILob and JSon parser prototypes 
/include qasphdr,icebreak
/include qasphdr,ilob
/include qasphdr,jsonparser

  /* -----------------------------------------------------------------------------
   Main
   ----------------------------------------------------------------------------- */     
dcl-proc main;

    dcl-s getUrl varchar(1024);

    SetContentType('application/json; charset=utf-8');

    getUrl = postJSON();
    if (getUrl = 'ERROR');
        %> POST war fehlerhaft<%
    else;
        getJSON(getUrl);
    endif;

    return;

end-proc;

  /* -----------------------------------------------------------------------------
   Post JSON Data to Webservice
   ----------------------------------------------------------------------------- */     
dcl-proc postJSON;

dcl-pi *n varchar(1024);
end-pi;

dcl-s url                 varchar(1024);
dcl-s Error               ind;  
dcl-s jNode               pointer;
dcl-s pOutput             pointer; 
dcl-s pReq                pointer; 
dcl-s pResp               pointer; 
dcl-s jResult             pointer;
dcl-s fromCC              int(10) inz(1208);
dcl-s toCC                int(10) inz(0);
dcl-s msg                 varchar(256);
dcl-s result              varchar(150);

    json_setDelimiters('/\@[] .{}');

    pOutput = json_newObject();
    json_setStr(pOutput: 'IceBreak10' : 'Hallo RPG');

    pReq = iLob_new();
    pResp = ilob_new();

    ilob_setHeaderBuf(
        pReq
        :'Content-Type: application/json; charset="utf-8"'
    );
    iLob_SerializeJson(pReq :pOutput);
    ilob_xlate(pReq:toCC:fromCC);

    json_delete(pOutput);

    url = 'https://api.myjson.com/bins';
    %> Daten senden an:    <% = url %>
<%
    error = httpRequest2 ( 
        '{ -
            request : {-
                url  : "' + url + '", -
                method      : "POST", -
                timeout     : 30 -
            }, -
            traceFile: "/www/myjson-trace.txt" -
        }'
        :*NULL
        :*OMIT
        :*OMIT
        :pReq 
        :*OMIT
        :*OMIT
        :pResp
    );                           

    ilob_xlate(pResp:fromCC:toCC);
    ilob_SaveToTextStream(
        pResp
        :'/www/myjson-post.json'
    );

    if error;
        %> - FEHLER: <% =  GetlastError('*MSGTXT') %><%
        return 'ERROR';
    else;
        jResult = json_parseILOB(pResp:'syntax=loose':273:0);
        if Json_Error(jResult) ;       
            msg = Json_Message(jResult);
            Json_dump(jResult);         
            Json_Close(jResult);        
            %> - Fehler in JSON: <% = msg %><%
            return 'ERROR';                   
        endif;                       
        jNode = JSON_locate(jResult: '/uri');                                    
        result = json_getStr(jNode);
            %>Antwort vom Server: <% = result %>
<%
    endif;   
    ilob_delete(pResp);
    json_delete(jResult);

    return result;

end-proc;

  /* -----------------------------------------------------------------------------
   Get JSON Data from Webservice
   ----------------------------------------------------------------------------- */     
dcl-proc getJSON;

dcl-pi *n;
    url varchar(1024);
end-pi;

dcl-s Error               ind;  
dcl-s jNode               pointer;
dcl-s pReq                pointer; 
dcl-s pResp               pointer; 
dcl-s jResult             pointer;
dcl-s fromCC              int(10) inz(1208);
dcl-s toCC                int(10) inz(0);
dcl-s msg                 varchar(256);
dcl-s result              varchar(150);

    json_setDelimiters('/\@[] .{}');

    pReq = iLob_new();
    pResp = ilob_new();

    ilob_setHeaderBuf(
        pReq
        :'Content-Type: application/json; charset="utf-8"'
    );
    ilob_xlate(pReq:toCC:fromCC);

    %> Daten holen von:    <% = url %>
<%
    error = httpRequest2 ( 
        '{ -
            request : {-
                url  : "' + url + '", -
                method      : "GET", -
                timeout     : 30 -
            }, -
            traceFile: "/www/myjson-trace.txt" -
        }'
        :*NULL
        :*OMIT
        :*OMIT
        :pReq 
        :*OMIT
        :*OMIT
        :pResp
    );                           

    ilob_xlate(pResp:fromCC:toCC);
    ilob_SaveToTextStream(
        pResp
        :'/www/myjson-get.json'
    );

    if error;
        %> - FEHLER: <% =  GetlastError('*MSGTXT') %><%
        return;
    else;
        jResult = json_parseILOB(pResp:'syntax=loose':273:0);
        if Json_Error(jResult) ;       
            msg = Json_Message(jResult);
            Json_dump(jResult);         
            Json_Close(jResult);        
            %> - Fehler in JSON: <% = msg %><%
            return;                   
        endif;                       
        jNode = JSON_locate(jResult: '/IceBreak10');                                    
        result = json_getStr(jNode);
            %>Antwort vom Server: <% = result %><%
    endif;   
    ilob_delete(pResp);
    json_delete(jResult);

    return;
    
end-proc;
%>

