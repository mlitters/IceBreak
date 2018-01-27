<%
    dcl-s name char(30);
    name = reqstr('name');
%>
    Willkommen bei IceBreak <%=name%>

<% 
    *inlr=*on;
    return;
%>
