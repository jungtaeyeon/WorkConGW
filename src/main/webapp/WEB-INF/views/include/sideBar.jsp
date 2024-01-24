<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1); margin-top: 50px; left:0px;">
  <div class="sidebar-scroll">
      <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 25px; ">
          <button type="button"  id="schedule_go_btn" onclick="schedule_go()" style="background-color: #2980b9; color: white; border: 0px; width: 14rem; height: 3.8rem; margin-left: 3.5%; border-radius: 5%; margin-top: 12%; font-family: InfinitySans-RegularA1">새 일정</button>
      </div>
      <div class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
          <ul class="main-menu metismenu">
              <li id="li_mySchedule">
                  <a href="javascript:event.preventDefault();"  style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="privateSchedule"></i></i> <span>개인일정</span></a>
              </li>
              <li id="li_importantSchedule">
                  <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="importantSchedule"></i> <span>중요일정</span></a>
              </li>
          </ul>
          <div id="commonHeader" class="tab-content p-l-0 p-r-0" style="font-size: 25px; margin-left: 3%; padding-bottom: 0; font-family: S-CoreDream-4Regular">
              공유 일정
          </div>
          <ul class="main-menu metismenu">
              <li id="li_companySchedule">
                  <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="companySchedule"></i> <span>회사일정</span></a>
              </li>
              <li id="li_deptSchedule">
                  <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="deptSchedule"></i> <span>부서일정</span></a>
              </li>
              <li id="li_teamSchedule">
                  <a href="javascript:event.preventDefault();" class="" style="font-family: S-CoreDream-4Regular; font-size: 20px;"><i class="fa fa-square" id="teamSchedule"></i> <span>팀일정</span></a>
              </li>
          </ul>
      </div>
      나의 일정
  </div>
</div>