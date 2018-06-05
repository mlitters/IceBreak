<%@ language="RPGLE" %>
<%
H BndDir('NOXDB')        

 /include noxDB     
                                  
D pRow            s               *                   
D sqlHnd          s               *                   
D sql             s            512    varying         
D text            s            512    varying         
D ints            s             10i 0                 
D numbers         s             11  2                 
D dates           s               d                   
D msg             s            512    varying         
/free
	/* 
		In this example you see the Power of noxDB (not only XML), which is integrated 
            in IceBreak.
		Access the DB2 Tables via SQL and return pure JSON. Then process that JSON in RPG!

		You can find my IceBreak Tutorials at:
		https://www.mlitters.com/IceDocu.aspx

		-----------------------------------------------------------------------------

		In diesem Beispiel, sehen Sie die Mächtigkeit von noxDB (not only XML), welches
            in IceBreak integriert ist.
            Greifen Sie per SQL auf die DB2 zu und erhalten reines JSON, welches Sie dann
            in RPG verarbeiten!

		Meine IceBreak Tutorials finden Sie unter:
		https://www.mlitters.com/IceDocu.aspx
	*/

	setContentType('application/json;charset=UTF-8');                                                            
   // Open our SQL cursor. Use a simple select        
   sqlhnd  = json_sqlOpen(                            
      'Select * from product'                         
   );                                                 
                                                      
   // Was there a problem ?                           
   if json_Error(sqlhnd);                             
      msg = json_Message(sqlhnd);       
      %>Error: <% = msg 
%><%              
      json_sqlDisconnect();                                                                          
      return;  // You can return, however the rest of the routines a roubust enough to just continue 
   endif;                                                                                            

   // Now iterate on each row in the resultset                                                       
   pRow = json_sqlFetchNext(sqlhnd);                                                                 
   dow (pRow <> *NULL );                                                                             
      ints    = json_getNum (pRow : 'PRODKEY');                                                      
      text    = json_getStr (pRow : 'PRODID');                                                       
      %>ProdId: <% = text %>
<%                                                                                       
      text    = json_getStr (pRow : 'DESC');                                                         
      %>Description: <% = text %>
<%                                                                                       
      text    = json_getStr (pRow : 'MANUID');                                                       
      numbers = json_getNum (pRow : 'PRICE');                                                        
      %>Price: <% = %char(numbers) %>
<%                                                                                       
      ints    = json_getNum (pRow : 'STOCKCNT');                                                     
      dates   = %date(json_getStr (pRow : 'STOCKDATE'));                                             
      json_NodeDelete(pRow); // Always dispose it before get the next - IMPORTANT   
                 
      pRow = json_sqlFetchNext(sqlhnd);                                                              
   enddo;               

   // Finaly and always !! close the SQL cursor and dispose the json row object   
   json_sqlClose(sqlhnd);                                                         
   json_sqlDisconnect();                                                          
                                                                                  
    // That's it..                                                                 
    *inlr = *on;                                                                   
    return;
%>

