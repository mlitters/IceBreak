<%

h bnddir('ICECAP')
	/* 
	In this example you see the Power of the virtual 5250 Emulator we can use 
        inside our RPG / Cobol Programs.
        With this you can create REST Services from within your 5250 Dialog 
        Applications and reuse your stable business logic!
        The example uses the WRKSYSSTS Screen but you can do it with EVERY
        Screen you run on your system. You don't need Source Code or anything!
        Attention: This example uses the german language on the Display.
        If you run another language you need to change that.

		You can find my IceBreak Tutorials at:
		https://www.mlitters.com/IceDocu.aspx

		-----------------------------------------------------------------------------

        In diesem Beispiel sehen Sie die Mächtigkeit des virtuellen 5250 
        Emulators, den wir direkt in RPG / Cobol nutzen können.
        Damit können Sie REST Services direkt aus Ihren 5250 Dialog Anwendungen
        erstellen und Ihre bewährte und stabile Geschäftslogik weiterverwenden!
        Das Beispiel nutzt den WRKSYSSTS Screen. Sie können jedoch JEDEN Screen
        verwenden, der auf Ihrem System läuft. Sie brauchen auch keinen Quellcode!

		Meine IceBreak Tutorials finden Sie unter:
		https://www.mlitters.com/IceDocu.aspx
	*/

/include qasphdr,iceCap


d cpuUsed         s              5  2 
d sysAspSize      s              7  2 
d sysAspUsed      s              9  4 

d i               s              9  0
d panelFound      s               n
d decp            s              1    inz(',') 
d pVts            s               *   inz(*null)
d vtSessoin       ds                  likeds(vtsDS) based(pVts)                                
d vtField         ds                  likeds(vtFieldDS)


/free
//' ------------------------------------------------------------------------------------
//' Main line:
//' Setup JSONP client response: the function name is received in querystring callback
//' this makes this service Cross domain safe simply by wraping the JSON 
//' response in a function call- Just call the client function with the JSON object
//' ------------------------------------------------------------------------------------
  *INRT = *ON;
  SetContentType('application/json; charset=utf-8');

  //' Open IceCap Virtual Terminal Session if not open yet. 
  if (pVts = *null); 
     pVts = vtOpen(); 
  endif;

  //' Locate the "Work with System Status" panel
  PanelFound = *OFF;
  dou (PanelFound); 
    select;
      //' logon if the signon is displayed
      when vtSaaTitleContains(pVts:'Anmelden');  
        vtSetFieldNo(pVts: 1 : 'USER');    // First field is the userprofile
        vtSetFieldNo(pVts: 2 : 'PASSWORD');    // Second field is the password
        vtSetFieldNo(pVts: 3 : 'QCMD');    // Program to run - QCMD
        vtPressKey(pVts: vtENTER);
       
      when vtSaaTitleContains(pVts:'Programmnachrichten anzeigen');  
        vtPressKey(pVts: vtENTER);
      
      //' run wrksyssts if command entry is displayed        
      when vtSaaTitleContains(pVts:'Befehlseingabe');  
        vtSetFieldNo(pVts: 1 : 'wrksyssts'); 
        vtPressKey(pVts: vtENTER);
        
      //' Refresh statistics in the system status is displayed
      when vtSaaTitleContains(pVts:'Mit Systemstatus arbeiten');
        vtPressKey(pVts: vtF10);
        PanelFound = *ON;

      other;
        // !! TODO - invalid screen
        %>{ "ok": false}<%
        return; 
    endsl;     
  enddo;
  

  cpuUsed     = num(vtGetScreen(pVts: 3: 33 : 6 ): decp); // session/line/column/len  
  sysAspSize  = num(vtGetScreen(pVts: 4: 70 :  8 ): decp); // session/line/column/len 
  sysAspUsed  = num(vtGetScreen(pVts: 5: 70 : 10 ): decp); // session/line/column/len

  %>{
    "cpuUsed"    : <% = %char(cpuUsed) %>,
    "sysAspSize" : <% = %char(sysAspSize) %>, 
    "sysAspUsed" :  <% = %char(sysAspUsed) %>
  }<%
  
  return; 
  
