package com.WorkConGW.admin.controller;


import com.WorkConGW.YAMLConfig;
import com.WorkConGW.admin.dto.AdminFormVO;
import com.WorkConGW.board.notice.dto.NoticeVO;
import com.WorkConGW.board.notice.service.NoticeService;
import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.common.dto.DeptVO;
import com.WorkConGW.common.dto.TimeVO;
import com.WorkConGW.common.service.DeptService;
import com.WorkConGW.common.service.TimeService;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;
import com.WorkConGW.reservation.dto.ReservationComplainVO;
import com.WorkConGW.reservation.service.MeetRoomService;
import com.google.api.services.storage.Storage;
import io.micrometer.common.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin/*")
public class AdminCommonController extends CommonController {
    Logger logger = LoggerFactory.getLogger(AdminCommonController.class);
    @Autowired
    private TimeService timeService;
    @Autowired
    private EmpService empService;
    @Autowired
    private DeptService deptService;
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private YAMLConfig config;
    @Autowired
    private MeetRoomService meetRoomService;

     @RequestMapping(value = "/main")
     public String adminMain(Model model, AdminFormVO adminFormVO){
        String url = "/admin/main";

         NoticeVO noticeVO = adminFormVO.getNoticeVO(); //noticeVO객체를 얻어옴
         noticeVO.setRecordCountPerPage(5); //5개 지정
         Map<String,Object> dataMap = noticeService.getNoticeList(noticeVO);

         logger.info(dataMap.toString());

         ReservationComplainVO reservationComplainVO = adminFormVO.getReservationComplainVO();
         reservationComplainVO.setRecordCountPerPage(5);
         List<ReservationComplainVO> complainList = meetRoomService.getAllComplainList(reservationComplainVO);
         logger.info(complainList.toString());

        List<EmpVO> loginUserList = getLoginUserList();
        List<DeptVO> deptList = deptService.selectAllDeptName();
        logger.info(deptList.toString());
        model.addAttribute("loginUserList",loginUserList);
        model.addAttribute("deptList",deptList);
        model.addAttribute("noticeList",dataMap.get("importantNoticeList"));
        model.addAttribute("complainList",complainList);
        return url;
     }

     @GetMapping("/access_denied")
     public String access_denied(String msg, Model model)
     {
         model.addAttribute("msg",msg);
         String url = "admin/access_denied";
         return url;
     }

    @RequestMapping("/getPicture")
    @ResponseBody
    public ResponseEntity<byte[]> getPicture(String picture) throws Exception {
        ResponseEntity<byte[]> entity = null;
        /* 비어있지않으면 실행 */
        if (StringUtils.isNotEmpty(picture)) {
            entity = getPicture(config.getUploadPath(), picture);
        }

        return entity;
    }

     @GetMapping("/time")
     public String time(Model model) throws Exception{
         String url = "/admin/time";
         TimeVO timeVO = timeService.getTime();
         logger.info(timeVO.toString());
         model.addAttribute("time", timeVO);
         return url;
     }


     @PostMapping("/time/modify")
    public String modifyTime(TimeVO timeVO) throws Exception{
         logger.info(timeVO.toString());
         timeService.modifyTime(timeVO);
         return "/admin/time";
     }



     /*
     @작성자 : 오지환
     @메소드 설명 :
     - searchLoginUser는 검색한 사용자를 도출한 리스트이다. (EMP_NAME)으로 검색한다.
     - EmpVO는 검색한 사용자의 리스트를 돌면서 EmpVO emp : searchLoginUser
     - users("emp_Id",session) 이렇게 저장 되어 있다.
     - users.get(emp.getEmp_Id()) != null --> 즉, 리스트에 사람이 있다면, loginList에 add해라. 이 값을 home화면에서 ajax시 뿌린다.
     * */

     @ResponseBody
     @PostMapping("/emp/search")
    public List<EmpVO> searchLoginUser(EmpVO empVO)
     {
         List<EmpVO> searchLoginUser = empService.searchLoginUser(empVO); // 검색한 사용자를 도출한 리스트
         List<EmpVO> loginList = new ArrayList<>();
         logger.info(searchLoginUser.toString());

         for(EmpVO emp : searchLoginUser) {
             if(users.get(emp.getEmp_Id()) != null) {
                 loginList.add(emp);
             }
         }
         logger.info("loginList :" + loginList.toString());
         return loginList;

     }




	
}
