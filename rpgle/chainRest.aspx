<%
Fproduct   IF   E           K DISK                        

/free
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


