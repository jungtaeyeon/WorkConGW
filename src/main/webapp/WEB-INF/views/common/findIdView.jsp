<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>WorkConGW</title>
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
            crossorigin="anonymous"
    />
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"
    ></script>
</head>
<body>

                <form id = "find" action = "<%=request.getContextPath()%>/emp/findId" method="post">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control rounded-4" id="emp_Name" name = "emp_Name" />
                        <label for="emp_Name">성명</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control rounded-4" id="emp_Email" name = "emp_Email" />
                        <label for="emp_Email">이메일</label>
                    </div>
                    <button class="w-100 mb-2 btn btn-lg rounded-4 btn-secondary" type="button" onclick="findId();">사번 찾기</button>
                    <hr id="findid-hr" class="my-4" style="display:none"/>
                    <strong class="text-muted" id="foundId">
                        <div id="findid-spinner" class="spinner-border spinner-border-sm text-primary" style="display: none" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </strong>
                </form>



                <script>

                    function findId()
                    {
                        let empVO = $("#find").serialize();
                        console.log('empVO : '+empVO)

                        $.ajax({
                            url: "<%=request.getContextPath()%>/emp/findId",
                            type: "post",
                            data: empVO,
                            success:function (data)
                            {

                                alert('아이디 찾기에 성공했습니다.')
                                console.log(data)
                                // 팝업 창을 닫습니다.
                                window.close();
                                window.opener.location.href = "<%=request.getContextPath()%>/emp/findList?"+empVO
                            },
                            error: function(xhr, status, error) {
                                var errorMessage = xhr.responseText; // AJAX 응답에서 오류 메시지 추출
                                alert(errorMessage); // 에러 메시지를 알림창으로 출력
                            }
                        })

                    }
                </script>


</body>
</html>
