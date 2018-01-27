<%
FPRODUCT   IF   E           K DISK
D i               s              4B 0

%>
<table border="1">
    <thead>
        <tr>
            <th>Produkt ID</th>
            <th>Beschreibung</th>
        </tr>
    </thead>
<%
/Free
    setll *loval PRODUCTR;
    read PRODUCTR;  
    i = 0;                                                                   
    dow (not %eof(PRODUCT) and i < 200) ; 
      i = i + 1; 
%>
    <tr>
        <td><% = ProdId %></td>
        <td><% = Desc %></td>
    </tr>
<%
      read PRODUCTR;  
    EndDo;
%>
</table>
<%
    *inlr=*on;
    return;
/End-Free
%>
