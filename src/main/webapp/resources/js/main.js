var draggedEventIsAllDay;
var activeInactiveWeekends = true;
var inputDate = moment();

var g_code = $("#hidden").val();

var id = $("#id").val();
var str = "<label class='checkbox-inline'><input class='filter' type='checkbox'";
str += " value='" + id +"' checked>개인일정</label>" ;
$("#joinedMember").html(str);

var calendar = $('#calendar').fullCalendar({
		
	
	 /** ******************
	   *  OPTIONS
	   * *******************/
	  locale                    : 'ko',    
	  timezone                  : "local", 
	  nextDayThreshold          : "09:00:00",
	  allDaySlot                : false,
	  displayEventTime          : false,
	  displayEventEnd           : false,
	  firstDay                  : 0, //월요일이 먼저 오게 하려면 1
	  weekNumbers               : false,
	  selectable                : true,
	  weekNumberCalculation     : "ISO",
	  eventLimit                : true,
	  views                     : { 
	                                month : { eventLimit : 12 } // 한 날짜에 최대 이벤트 12개, 나머지는 + 처리됨
	                              },
	  eventLimitClick           : 'week', //popover
	  navLinks                  : true,
	  defaultDate               : inputDate, //실제 사용시 현재 날짜로 수정
	  timeFormat                : 'HH:mm',
	  defaultTimedEventDuration : '01:00:00',
	  editable                  : true,
	  minTime                   : '00:00:00',
	  maxTime                   : '24:00:00',
	  slotLabelFormat           : 'HH:mm',
	  weekends                  : true,
	  nowIndicator              : true,
	  dayPopoverFormat          : 'MM/DD dddd',
	  longPressDelay            : 0,
	  eventLongPressDelay       : 0,
	  selectLongPressDelay      : 0,  
	  header                    : {
	                                left   : 'today, prevYear, nextYear, viewWeekends',
	                                center : 'prev, title, next',
	                                right  : 'month, agendaWeek, agendaDay, listWeek'
	                              },
	  views                     : {
	                                month : {
	                                  columnFormat : 'dddd'
	                                },
	                                agendaWeek : {
	                                  columnFormat : 'M/D ddd',
	                                  titleFormat  : 'YYYY년 M월 D일',
	                                  eventLimit   : false
	                                },
	                                agendaDay : {
	                                  columnFormat : 'dddd',
	                                  eventLimit   : false
	                                },
	                                listWeek : {
	                                  columnFormat : ''
										,textColor : '#000000'
	                                }
	                              },
	  customButtons             : { //주말 숨기기 & 보이기 버튼
	                                viewWeekends : {
	                                  text  : '주말',
	                                  click : function () {
	                                    activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
	                                    $('#calendar').fullCalendar('option', { 
	                                      weekends: activeInactiveWeekends
	                                    });
	                                  }
	                                }
	                               },
	visibleRange : function(searchDate){
		return{
			start: searchDate.clone().subtract(1,'days')
			,end  : searchDate.clone().add(3,'days')
		}
	},
	//  여기 부분을 건드리면 출력에 영향을 미친다
	  eventRender: function (event, element, view) {
		  var important = event.important;
		  var popImportant = '';
		  if(important == 'true'){
			  popImportant = '<p class="importantStrong"><strong>💥중요💥</strong></p>';
		  }

		  popoverSchedule(element);

		  var content = event.description;
		  if(!content) content = "내용 없음";
		  var id = event._id;

		  //일정에 hover시 요약
		  $(element).popover({
			  title: $('<div />'
				  ,{class: 'popoverTitleCalendar'
					  ,text: event.title}).css({'background': event.backgroundColor
				  ,'color': event.color
				  ,'padding': "15px"
				  ,'margin':"-5px"
				  ,"width":"170px"})
			  ,content: $('<div />'
				  ,{class: 'popoverInfoCalendar'})
				  .append(popImportant)
				  .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
				  .append('<div class="popoverDescCalendar" ><strong>설명:</strong> ' + content + '</div>')
			  ,delay: { show: "300"
				  ,hide: "50"}
			  ,trigger: 'hover'
			  ,placement: 'top'
			  ,html: true
			  ,container: 'body'
//     });
		  }).popover('show');



		  return true;
	  },
	
	  /* ****************
	   *  일정 받아옴 
	   * ************** */
	  //리스트
	  events: function (start, end, timezone, callback){
		  viewStart = moment(start).format('YYYY-MM-DD');
		  viewEnd = moment(end).format('YYYY-MM-DD');
		  setTimezone = timezone;
		  setCallback = callback;

		  var dateData;

		  /** 이상하게 이거때문에 달력 출력이 안됨 ...
		  if(searchStart){
			  dateData = {
				  // 화면이 바뀌면 Date 객체인 start, end 가 들어옴
				  start : moment(searchStart).format('YYYY-MM-DD')
				  ,end   : moment(searchEnd).format('YYYY-MM-DD')
				  ,username : loginId
				  ,searchType:setType
				  ,searchCondition:setCondition
				  ,searchKeyword:setKeyword
				  ,searchImportant:setImportant

			  };
		  }else{
			  dateData = {
				  // 화면이 바뀌면 Date 객체인 start, end 가 들어옴
				  start : moment(start).format('YYYY-MM-DD')
				  ,end   : moment(end).format('YYYY-MM-DD')
				  ,username : loginId
				  ,searchType:setType
				  ,searchCondition:setCondition
				  ,searchKeyword:setKeyword
				  ,searchImportant:setImportant

			  };
		  } //end of if, else
			  */

		  $.ajax({
	      type: "post",
	      url: "/schedule/list",
			//data:JSON.stringify(dateData),// {"g_code" : g_code}
	      dataType:"json",
			  data: JSON.stringify({
			  	// start: moment(start).format('YYYY-MM-DD'),
			  	// end: moment(end).format('YYYY-MM-DD'),
			  }),
			  contentType:"application/json;charset=utf-8",
	      success: function (response){
			  var fixedDate = response.map(function (array) {
				  //만약 AllDay 일정이면서 시작 날짜와 종료 날짜가 다르다면, 종료 날짜에 하루를 더함
				  if (array.allDay && array.start !== array.end) {
					  array.end = moment(array.end).add(1, 'days'); // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력
				  }
				  return array;
				  // return {
					//   title: array.title,
					//   start: array.start,
					//   end: array.end,
					//   allDay: array.allDay
				  // }
			  });
			  callback(fixedDate); // 수정된 데이터를 콜백 함수에 전달
	      }
			  ,error:  function(request, status, error){ // Ajax 요청이 실패한 경우 실행할 콜백 함수
				  console.log("에러발생 >> " + request + " , " + status + "," + error);
			  }
	    });
	  },
	
	  eventAfterAllRender: function (view) {
	    if (view.name == "month") $(".fc-content").css('height', 'auto');
	  },


	  // // 일정 리사이즈 삭제 예정
	  // eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
	  //   $(".popover.fade.top").remove();
	  //
	  //
	  //   /** 리사이즈시 수정된 날짜반영
	  //    * 하루를 빼야 정상적으로 반영됨.
	  //  */
	  //   var newDates = calDateWhenResize(event);
	  //
	  //   //리사이즈한 일정 업데이트
	  //   $.ajax({
	  //     type: "get",
	  //     url: "dragupdate",
	  //     data: {
	  //   	  "calno":event.calno,
	  //   	  "start":newDates.startDate, "end":newDates.endDate
	  //     },
	  //     success: function (response) {
	  //       alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
	  //     }
	  //   });
	  //
	  // },
	  //
	  // eventDragStart: function (event, jsEvent, ui, view) {
	  //   draggedEventIsAllDay = event.allDay;
	  //  },


	//일정 드래그앤드롭
	     eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
	        // if(id==event.username){
	           $('.popover.fade.top').remove();
	            
	           /**
			   //주,일 view일때 종일 <-> 시간 변경불가
	             if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
	               if (draggedEventIsAllDay !== event.allDay) {
	                 alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
	                 location.reload();
	                 return false;
	               }
	             }
				   */

	         
	             // 드랍시 수정된 날짜반영
	             var newDates = calDateWhenDragnDrop(event);

			 var selectGroup = '';
			 switch(event.type){
				 case '개인일정':
					 selectGroup = 'S01';
					 break;
				 case '회사일정':
					 selectGroup = 'S02';
					 break;
				 case '부서일정':
					 selectGroup = 'S03';
					 break;
				 case '팀일정':
					 selectGroup = 'S04';
					 break;
			 }

			 var eventData = {
				 _id:event._id
				 ,start:newDates.startDate
				 ,end:newDates.endDate
				 ,type:selectGroup
			 }

			 if(confirm(newDates.startDate + ' ~ ' + newDates.endDate + ' 일자로\n일정을 수정 하시겠습니까?')){

				 //드롭한 일정 업데이트
				 $.ajax({
					 type:"post"
					 ,url:"<%=request.getContextPath()%>/schedule/modify"
					 ,data:JSON.stringify(eventData)
					 ,dataType:"json"
					 ,contentType:"application/json;charset=utf-8"
					 ,success:function(response){
						 if(selectGroup == 'S02'){
							 $(response.empList).each(function(index, item){
								 var empId = item.empId;
// 							console.log(empId);
								 (function(index, item){
									 sendMessage('${pageContext.request.contextPath}',
										 empId,
										 '회사 일정이 수정되었습니다. 확인해주세요.',
										 event.title,
										 '${pageContext.request.contextPath}/schedule/detail?schedule_Id='+response.schedule_Id,
										 '일정관리');
								 })(index, item);
							 });
						 }else if(selectGroup == 'S03'){
							 $(response.empList).each(function(index, item){
								 var empId = item.empId;
								 // 					console.log(empId);
								 (function(index, item){
									 sendMessage('${pageContext.request.contextPath}',
										 empId,
										 '부서 일정이 수정되었습니다. 확인해주세요.',
										 event.title,
										 '${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
										 '일정관리');
								 })(index, item);
							 });
						 }else if(selectGroup == 'S04'){
							 $(response.empList).each(function(index, item){
								 var empId = item.empId;
// 							console.log(empId);
								 (function(index, item){
									 sendMessage('${pageContext.request.contextPath}',
										 empId,
										 '팀 일정이 수정되었습니다. 확인해주세요.',
										 event.title,
										 '${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
										 '일정관리');
								 })(index, item);
							 });
						 }

						 alert('일정이 수정되었습니다.');
						 // 				window.location.reload(true);
					 }
					 ,error:function(request, status, error){
						 console.log("error 발생 >> " + request +", "+ status+", "+error);
					 }
				 });
			 }else{
				 window.location.reload(true);
			 }
	     },
	
	  select: function (startDate, endDate, jsEvent, view) {
	
	    $(".fc-body").unbind('click');
	    $(".fc-body").on('click', 'td', function (e) {

			let sendStart = moment(startDate).format('YYYY-MM-DDTHH:mm');
			let sendEnd = moment(endDate).format('YYYY-MM-DDTHH:mm');

			OpenWindow('registForm?start='+sendStart+'&end='+sendEnd,'일정등록','675','700');
	
	      // $("#contextMenu")
	      //   .addClass("contextOpened")
	      //   .css({
	      //     display: "block",
	      //     left: e.pageX,
	      //     top: e.pageY
	      //   });
	      // return false;
	    });

		  $("#scheduleForm").trigger("click");

	    var today = moment();
	
	    if (view.name == "month") {
	      startDate.set({
	        hours: today.hours(),
	        minute: today.minutes()
	      });
	      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
	      endDate = moment(endDate).subtract(1, 'days');
	
	      endDate.set({
	        hours: today.hours() + 1,
	        minute: today.minutes()
	      });
	      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
	    } else {
	      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
	      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
	    }
	
	    //날짜 클릭시 카테고리 선택메뉴
	    var $contextMenu = $("#contextMenu");
	    $contextMenu.on("click", "a", function (e) {
	      e.preventDefault();
	
	      //닫기 버튼이 아닐때
	      if ($(this).data().role !== 'close') {
	        newEvent(startDate, endDate, $(this).html());
	      }
	
	      $contextMenu.removeClass("contextOpened");
	      $contextMenu.hide();
	    });
	
	    $('body').on('click', function () {
	      $contextMenu.removeClass("contextOpened");
	      $contextMenu.hide();
	    });
	
	  },
	
	  //이벤트 클릭시 수정이벤트
	  eventClick: function (event, jsEvent, view) {
		  jsEvent.preventDefault();
		  window.location.href ='/schedule/detail?schedule_Id='+event.id;
		  //editEvent(event);

		  return false;
	  }
	
	});

function getDisplayEventDate(event) {
  let displayEventDate;

    let startTimeEventInfo = moment(event.start).format('HH:mm');
    let endTimeEventInfo = moment(event.end).format('HH:mm');
    displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;

  return displayEventDate;
}

function filtering(){

	calendar.fullCalendar('refetchEvents');
	gotoDate(searchStart);
}

// 특정 날짜로 이동
function gotoDate(toDate){
	if(toDate){
		calendar.fullCalendar('gotoDate', moment(toDate).format('YYYY-MM'));
	}else{
		calendar.fullCalendar('gotoDate', moment().format('YYYY-MM'));
	}
}

// 이벤트를 필터링하여 조건에 맞는 이벤트만 보여주는 역할
// function filtering(event) {
// 	var show_username = true;
// 	var username = $(".filter:checked").map(function () {
// 		return $(this).val();
// 	}).get();
// 	show_username = username.indexOf(event.username) >= 0;
// 	return show_username;
// }




function calDateWhenResize(event) {
  var newDates = {
    startDate: '',
    endDate: ''
  };
	if(!event.end) {
		event.end = event.start;
	}

	newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
	newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');

	return newDates;

}

function calDateWhenDragnDrop(event) {
  // 드랍시 수정된 날짜반영
  var newDates = {
    startDate: '',
    endDate: ''
  }
  // 날짜 & 시간이 모두 같은 경우
  if(!event.end) {
    event.end = event.start;
  }
  //하루짜리 all day
  if (event.allDay && event.end === event.start) {
    console.log('1111')
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = newDates.startDate;
  }
  //2일이상 all day
  else if (event.allDay && event.end !== null) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  }
  //all day가 아님
  else if (!event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }
  return newDates;
}