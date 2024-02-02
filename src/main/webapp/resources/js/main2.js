//원래 프로젝트 원본 하지만 수정이 필요
var calendar = $('#calendar').fullCalendar({ //캘린더 설정

    /** ******************
     *  OPTIONS
     * *******************/
    locale                    : 'ko',
    timezone                  : "local",
    nextDayThreshold          : "09:00:00",
    allDaySlot                : false,
    displayEventTime          : true,
    displayEventEnd           : true,
    firstDay                  : 0, //월요일이 먼저 오게 하려면 1
    weekNumbers               : false,
    selectable                : true,
    weekNumberCalculation     : "ISO",
    eventLimit                : true,
    showNonCurrentDates		: true, // 다른 달의 일정도 렌더링 할 것인지 여부 (기본 true)
    views                     : {
        month : { eventLimit : 12 } // 한 날짜에 최대 이벤트 12개, 나머지는 + 처리됨
    },
    eventLimitClick           : 'popover',
    navLinks                  : true,
    defaultDate               : inputDate,
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
        left   : 'today, prevYear, nextYear',
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
    visibleRange : function(searchDate){
        return{
            start: searchDate.clone().subtract(1,'days')
            ,end  : searchDate.clone().add(3,'days')
        }
    },


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
    events: function (start, end, timezone, callback) {
        viewStart = moment(start).format('YYYY-MM-DD');
        viewEnd = moment(end).format('YYYY-MM-DD');
        setTimezone = timezone;
        setCallback = callback;

// 		console.log('일정 받을 때 Date (start - end, moment로 셋팅한 순)------');
// 		console.log(viewStart);
// 		console.log(viewEnd);
// 		console.log(moment(viewStart).format('YYYY-MM-DD'));
// 		console.log(moment(viewEnd).format('YYYY-MM-DD'));
// 		console.log('일정 받을 때 Date END------');

        var dateData;
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
        }
// 		console.log("--- dateData ---");
// 		console.log(dateData);
// 		console.log("searchImportant >> " + setImportant);
// 		console.log("--- dateData end ---");

        $.ajax({
            type: "POST"
            ,url: "list"
            ,data:JSON.stringify(dateData) // 서버로 전송할 데이터 타입
            ,dataType:"json" // 서버 응답 데이터 타입
            ,contentType:"application/json;charset=utf-8"
            ,success: function (response) {
//         console.log(response);
                var fixedDate = response.map(function (array) {
                    // 만약 AllDay 일정이면서 시작 날짜와 종료 날짜가 다르다면, 종료 날짜에 하루를 더함
                    if (array.allDay && array.start !== array.end) {
                        array.end = moment(array.end).add(1, 'days'); // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력
                    }
                    return array;
                });
                callback(fixedDate); // 수정된 데이터를 콜백 함수에 전달
            }
            ,error: function(request, status, error){ // Ajax 요청이 실패한 경우 실행할 콜백 함수
                console.log("에러발생 >> " + request + " , " + status + "," + error);
            }
        });

    },


    eventAfterAllRender: function (view) {
        if (view.name == "month") $(".fc-content").css('height', 'auto');
    },


    //일정 리사이즈 삭제예정
//      eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
//        $('.popover.fade.top').remove();

//        /** 리사이즈시 수정된 날짜반영
//         * 하루를 빼야 정상적으로 반영됨. */
//        var newDates = calDateWhenResize(event);

//        //리사이즈한 일정 업데이트
//        $.ajax({
//          type: "get",
//          url: "",
//          data: {
//            //id: event._id,
//            //....
//          },
//          success: function (response) {
//            alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
//          }
//        });

//      },

    //  eventDragStart: function (event, jsEvent, ui, view) {
//       draggedEventIsAllDay = event.allDay;
    //  },

    //일정 드래그앤드롭
    eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
        $('.popover.fade.top').remove();

        //주,일 view일때 종일 <-> 시간 변경불가
//        if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
//         if (draggedEventIsAllDay !== event.allDay) {
//           alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
//           location.reload();
//           return false;
//         }
//        }

        // 드랍시 수정된 날짜반영
        var newDates = calDateWhenDragnDrop(event);
//        console.dir(event);
//        console.dir(newDates);

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

//        console.log(selectGroup);

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
                                    '${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
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
            //alert('fc-body 클릭');
//           e.jsEvent.preventDefault();

            var sendStart = moment(startDate).format('YYYY-MM-DDTHH:mm');
            var sendEnd = moment(endDate).format('YYYY-MM-DDTHH:mm');

            OpenWindow('registForm?start='+sendStart+'&end='+sendEnd,'일정등록','675','700');

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

        return false;
    },

    //이벤트 클릭시 상세조회 수정이벤트
    eventClick: function (event, jsEvent, view) {
        //alert('이벤트 클릭 >> ' + event);
        jsEvent.preventDefault();
        OpenWindow('detail?scheduleId='+event._id,'일정 상세조회','700','715');
//       event.stopPropagation();

        return false;

    }

});