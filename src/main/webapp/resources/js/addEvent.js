var eventModal = $("#eventModal");

var modalTitle = $(".modal-title");
var editAllDay = $("#edit-allDay");
var editTitle = $("#edit-title");
var editStart = $("#edit-start");
var editEnd = $("#edit-end");
var editType = $("#edit-type");
var editColor = $("#edit-color");
var editContent = $("#edit-content")
var editDesc = $("#edit-desc");

var addBtnContainer = $(".modalBtnContainer-addEvent");
var modifyBtnContainer = $(".modalBtnContainer-modifyEvent");

var clodseBtnContainer = $(".modalBtnContainer-closeEvent");
/* ****************
 *  새로운 일정 생성
 * ************** */
var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김

    modalTitle.html('새로운 일정');
    $("#edit-title").val('');
    $("#edit-start").val(start);
    $("#edit-end").val(end);
    $("#edit-desc").val('');

    clodseBtnContainer.hide();
    
    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');


    //새로운 일정 저장버튼 클릭
    $("#save-event").unbind();
    $("#save-event").on('click', function () {
        var eventData = {
            title: $("#edit-title").val(),
            start: $("#edit-start").val(),
            end: $("#edit-end").val(),
            description: $("#edit-desc").val(),
            type: $("#edit-type").val(),
            username: "", // controller에서 session에 있는 값으로 넣어줘야 한다.
            backgroundColor: $("#edit-color").val(),
            textColor: "ffffff",
            allDay: "0",
            schk :"0"
        };

        if (eventData.start > eventData.end) {
            alert("끝나는 날짜가 앞설 수 없습니다.");
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }
       
        var realEndDay;
        
        if ($("#edit-schk").is(":checked")) {
        	eventData.schk = "1"
        }     
        if ($("#edit-allDay").is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD 00:00');
            //render시 날짜표기수정
            eventData.end = moment(eventData.start).add(1,'day').format('YYYY-MM-DD 00:00');
            //DB에 넣을때(선택)
            realEndDay =eventData.start;

            eventData.allDay = "1";
        }else{
        	eventData.start = moment(eventData.start).format('YYYY-MM-DD HH:mm');
            //render시 날짜표기수정
            eventData.end =  moment(eventData.end).format('YYYY-MM-DD HH:mm');
            //DB에 넣을때(선택)         
        }
       
        $("#calendar").fullCalendar("renderEvent", eventData, true);
        $("#eventModal").find("input, textarea").val("");
        $("#edit-allDay").prop("checked", false);
        eventModal.modal("hide");
        
        //새로운 일정 저장
        insertCal();
        
        function insertCal(){
	        $.ajax({
	            type: "get",
	            url: "scheduleinsert",
	            data: {
	            	"schk":eventData.schk,
	            	"description":eventData.description,
	            	"start":eventData.start, "end":eventData.end,
	            	"type":eventData.type,
	            	"backgroundColor":eventData.backgroundColor,
	            	"textColor":eventData.textColor,"allDay":eventData.allDay, "title":eventData.title
	            },
	            success: function (response) {
	            	alert("저장을 완료했습니다. ");
	                //DB연동시 중복이벤트 방지를 위한
	                $('#calendar').fullCalendar('removeEvents');
	                $('#calendar').fullCalendar('refetchEvents');
	            }
	        });
        }
    });
};