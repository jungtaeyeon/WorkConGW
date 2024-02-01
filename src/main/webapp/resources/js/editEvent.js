/* ****************
 *  일정 편집
 * ************** */
var editEvent = function (event, element, view) {

    $("#deleteEvent").data("id", event.calno); //클릭한 이벤트 ID

    $(".popover.fade.top").remove();
    $(element).popover("hide");
    
    if (event.allDayjs == true) {
       $("#edit-allDay").prop('checked', true);  
    } else {
       $("#edit-allDay").prop('checked', false);
    }
    
    if (event.schk=="1") {
       $("#edit-schk").prop('checked', true);
    } else {
       $("#edit-schk").prop('checked', false);
       
    }
          
    if (event.end === null) {
        event.end = event.start;
    }

    if (event.allDayjs == true ) {
    	$("#edit-end").val(event.end.format('YYYY-MM-DD'));
    	$("#edit-start").val(event.start.format('YYYY-MM-DD'));
    } else {
       $("#edit-end").val(event.end.format('YYYY-MM-DD HH:mm'));
       $("#edit-start").val(event.start.format('YYYY-MM-DD HH:mm'));
    }

    modalTitle.html('일정 수정');
    $("#edit-title").val(event.title);
    $("#edit-type").val(event.type);
    $("#edit-desc").val(event.description);
    $("#edit-color").val(event.backgroundColor).css('color', event.backgroundColor);
    
    if(id==event.username){
        addBtnContainer.hide();
        modifyBtnContainer.show();
        clodseBtnContainer.hide();
     }else{
        addBtnContainer.hide();
        modifyBtnContainer.hide();
        clodseBtnContainer.show();
     }
    eventModal.modal('show');

    //업데이트 버튼 클릭시
    $('#updateEvent').unbind();
    $('#updateEvent').on('click', function () {
    	var eventData = {
                title: $("#edit-title").val(),
                start: $("#edit-start").val(),
                end: $("#edit-end").val(),
                description: $("#edit-desc").val(),
                type: $("#edit-type").val(),
                username: event.username, // controller에서 session에 있는 값으로 넣어줘야 한다.
                backgroundColor: $("#edit-color").val(),
                textColor: "ffffff",
                allDay: "0",
                schk :"0"
            };

    	if ($("#edit-schk").is(":checked")) {
        	eventData.schk = "1"
        }  
    	
        if ($("#edit-start").val() > $("#edit-end").val()) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if ( $("#edit-title").val() === '') {
            alert('일정명은 필수입니다.')
            return false;
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
               
        //일정 업데이트
        $.ajax({
            type: "get",
            url: "scheduleupdate",
            data: {
            	"schk":eventData.schk,"username":event.username,
            	"description":eventData.description,
            	"start":eventData.start, "end":eventData.end,
            	"type":eventData.type,"calno":event.calno,
            	"backgroundColor":eventData.backgroundColor,
            	"textColor":eventData.textColor,"allDay":eventData.allDay, "title":eventData.title
            },
            success: function (response) {
                alert('수정되었습니다.');
                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('refetchEvents');
            }
        });

    });
};

// 삭제버튼
$('#deleteEvent').on('click', function () {
    
    $('#deleteEvent').unbind();
    $("#calendar").fullCalendar('removeEvents', $(this).data('id'));
    eventModal.modal('hide');
alert("삭제");
alert($(this).data('id'))
    //삭제시
    $.ajax({
        type: "get",
        url: "scheduledelete",
        data: {
           "calno":$(this).data('id')
        },
        success: function() {
            alert('삭제되었습니다.');
        }
    });

});