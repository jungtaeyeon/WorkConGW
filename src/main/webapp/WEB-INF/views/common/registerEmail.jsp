<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Insert title here</title>
</head>
<body>
<script type="text/javascript">

  alert(' 회원가입을 축하합니다. 확인버튼을 누르면 최초 비밀번호 설정해주세요.');
  self.location = "<%=request.getContextPath()%>/emp/firstChange";
</script>
</body>
</html>