<%
Fproduct   IF   E           K DISK                        

/free
	/* 
		In this example you see a very simple REST Service Server created in 
		fixed format RPG combined with free format RPG.
		You can test this Service by entering:
		http://192.168.1.1:7800/chainRest.rpgle?prodkey=100 
		in your Browser, where you should use your IP address of your IBM i 
		and the Portnumber of your IceBreak Server Instance you run the 
		REST Service of course.

		You can find my IceBreak Tutorials at:
		https://www.mlitters.com/IceDocu.aspx

		-----------------------------------------------------------------------------

		In diesem Beispiel, sehen Sie einen einfachen REST Service Server, der in
		spaltenorientiertem RPG gemischt mit free Format RPG erstellt wurde.
		Sie können den Service testen, indem Sie in Ihren Browser eingeben:
		http://192.168.1.1:7800/chainRest.rpgle?prodkey=100 
		wobei Sie natürlich die IP Adresse Ihrer IBM i, sowie die Portnummer Ihrer
		IceBreak Server Instanz eingeben müssen.		

		Meine IceBreak Tutorials finden Sie unter:
		https://www.mlitters.com/IceDocu.aspx
	*/

	setContentType('application/json;charset=UTF-8');               

	prodkey = reqNum('prodkey');
	chain prodkey productr;                                
	if not %found;         
		%>{ 
			"sucess" : false
		}<%    
	else;          
		%>{
			"sucess" 	: true,     
			"prodkey"	:  <%= %char(prodkey) %>,  
			"prodid"	: "<%= prodid %>",   
			"desc"		: "<%= desc %>",  
			"manuid"	: "<%= manuid %>",   
			"price"    	:  <%= %char(price) %>,  
			"stockcnt"	:  <%= %char(stockCnt)%>,   
			"stockdate"	: "<%= %char(stockDate) %>"                        
		}<%
	endif;                                                 

	return;
/end-free
%>


