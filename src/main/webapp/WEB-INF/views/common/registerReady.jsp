<%--
  Created by IntelliJ IDEA.
  User: Ohjihwan
  Date: 2024-02-11
  Time: 오후 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>

alert('메일 인증 하세요.')
self.location = "<%=request.getContextPath()%>/common/loginForm";

</script>