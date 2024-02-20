<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap CSS, js CDN -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- TreeView -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/jquery.treeview.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/treeview/screen.css" />
<script src="<%=request.getContextPath() %>/js/treeview/jquery.treeview.js"></script>





<body>

<ul id="codeList">
        <ul id="lvl0"><!-- 자식 노드가 들어올 공간--></ul>
</ul>

<form id="searchForm">
    <input type="hidden" name="parent" value="0" />
</form>

</body>

<script>
    function deptTrees() {
        $.ajax({
            type: "GET",
            url: "<c:url value='/orgList'/>",
            contentType: "application/json",
            processData: true,
            success: function (data) {
                data.forEach(function (e, i) {
                    let deptId = e.deptId;
                    let deptName = e.deptName;
                    let deptSupId = e.deptSupId;
                    let position = e.position
                    let level = e.level || 5;

                    let li = "";
                    if (position) {
                        li = '<li id="' + deptId + '" lvl="' + level + '"><img src="<%=request.getContextPath() %>/js/treeview/images/file.gif"><a class="file code myHover">' + " " + deptName + " " + e.position + '</a></li>';
                    } else {
                        li = '<li id="' + deptId + '" lvl="' + level + '"><img src="<%=request.getContextPath() %>/js/treeview/images/folder-closed.gif"><a class="file code">' + " " + deptName + " " + '</a></li>';
                    }

                    // 1레벨은 그냥 추가
                    // 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
                    if (level == 1) {
                        $("#lvl0").append(li);
                    } else {
                        let parentLi = $("li[id='" + deptSupId + "']");
                        parentLi.addClass("expandable lastExpandable");
                        parentLi.find("a").removeClass("file");
                        parentLi.find("a").addClass("folder");
                        let bUl = parentLi.children("ul");

                        // 하위 그룹이 없으면 li로 추가
                        // 하위 그룹이 있으면 ul로 추가
                        if (bUl.length == 0) {
                            let div = "<div onclick='plusFromMinus(this);' class='hitarea expandable-hitarea lastExpandable-hitarea '></div>"
                            li = "<ul class='' style='display: none;'>" + li + "</ul>";
                            parentLi.append(div);
                            parentLi.append(li);
                        } else {
                            if (position) {
                                bUl.prepend(li);
                            } else {
                                bUl.append(li);
                            }
                        }
                    }
                });
            }
        });
    }

    //열고 닫는 함수
    function plusFromMinus(obj){
        let parentLi = $(obj).parent("li");
        let deptId = parentLi.attr("id");
        if($(obj).hasClass("expandable-hitarea")){
            $(obj).parent("li").removeClass("expandable lastExpandable");
            $(obj).parent("li").addClass("collapsable lastCollapsable");
            $(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
            $(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
            $(obj).parent("li").children("ul").css("display","block");
        }else{
            $(obj).parent("li").removeClass("collapsable lastCollapsable");
            $(obj).parent("li").addClass("expandable lastExpandable");
            $(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
            $(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea");
            $(obj).parent("li").children("ul").css("display","none");
        }
    }

    $(document).ready(function(){
        deptTrees();
        $("#refresh").click(function() {
            $("#codeList").empty();
            deptTrees();
        });
        $("#codeList").treeview({
            collapsed: true
        });
    });

</script>

<script type="text/javascript">
    $(function() {
        $("#browser").treeview();
    });
</script>

