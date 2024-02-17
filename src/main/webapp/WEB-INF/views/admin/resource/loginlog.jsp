<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import ="com.WorkConGW.common.BSPageBar"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>




<body>
<%
    List<String> bList = (List)request.getAttribute("loginLogList");
    int size = 0;
    if(bList != null)
    {
        size = bList.size();

    }

    int numPerPage = 10;
    int nowPage =  0;
    if(request.getParameter("nowPage")!= null)
    {
        nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }

%>

<!-- 메인 content -->
<section class="subPageContain" style="display: flex">
    <!-- 사이드바 -->
    <%@ include file="../sidebar.jsp"%>

<div class="container-fluid">
    <div class="row clearfix">
        <div class="col-lg-12">
            <div class="card">
                <div class="header">
                    <span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">자원 관리</span><br>
                    <h3 style="display:inline-block; font-family: S-CoreDream-6Bold">사용자 로그인 기록</h3>
                    <div class="row clearfix">
                        <div class="col-lg-12 col-md-12">
                            <div class="card" style="font-family: S-CoreDream-6Bold">
                                <div class="body">
                                    <div class="table-responsive">
                                        <table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
                                            <thead class="thead-dark">
                                            <tr>
                                                <th>최근접속날짜</th>
                                                <th>사원번호</th>
                                                <th>접속IP주소</th>
                                                <th>결과</th>
                                            </tr>
                                            </thead>
                                            <tbody>
<%
    for(int i = nowPage*numPerPage; i <(nowPage*numPerPage)+numPerPage;i++)
    {
        if(size == i){
            break;
        }

        String log = bList.get(i);
%>
                                            <tr>
                                                <td><%= log.split(",")[1] %></td>
                                                <td><%= log.split(",")[2] %></td>
                                                <td><%= log.split(",")[3] %></td>
                                                <%
                                                    if (log.split(",")[4].equals("실패")) {
                                                %>
                                                <td><span class="badge badge-danger">실패</span></td>
                                                <%
                                                } else if (log.split(",")[4].equals("성공")) {
                                                %>
                                                <td><span class="badge badge-primary">성공</span></td>
                                                <%
                                                    }
                                                %>
                                            </tr>
<%
    }
%>



                                            </tbody>
                                        </table>


                                        <div>
                                            <ul class="pagination">
                                                <%
                                                    String pagePath = "";
                                                    BSPageBar bspb = new BSPageBar(numPerPage,  size, nowPage, pagePath);
                                                    out.print(bspb.getPageBar());
                                                %>
                                            </ul>
                                        </div>


                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</section>

</body>