<%
// Example: 
// Use qsh and send the result back to the client
// ------------------------------------------------------------------ 
/free
  *inlr = *ON;
  %><html><body><pre><%
  shell ('ls');
  %></pre></body></html><%
