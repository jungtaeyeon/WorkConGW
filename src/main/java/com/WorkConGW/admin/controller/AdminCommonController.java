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
import com.google.api.client.json.Json;
import com.google.api.services.storage.Storage;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;


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


     @ResponseBody
     @PostMapping("/graphEmp")
    public String graphEmp(Model model)
     {
         LocalDateTime now = LocalDateTime.now();
         LocalDateTime startDt = now.minus(1, ChronoUnit.MONTHS);
         LocalDateTime endDt = now;
         logger.info("startDt : "+startDt.toString());
         logger.info("endDt"+endDt.toString());
         List<Map<String,Object>> graphList = new ArrayList<>();
         Map<String,Object> dataMap = new HashMap<>();
         dataMap.put("startDt",startDt);
         dataMap.put("endDt", endDt);
         dataMap = empService.selectGraphEmp(dataMap);

         graphList.add(dataMap);

         logger.info(graphList.toString());


         ////////////////////GSON 변환/////////////////////////

         Gson gson = new Gson();
         JsonArray jArray = new JsonArray();
         int total = 0;
         int chaJang = 0;
         Iterator<Map<String,Object>> it = graphList.iterator();
         int deari = 0;
         int sawon = 0;
         int buJang = 0;
         int gwaJang = 0;
         while(it.hasNext()){
             Map<String,Object> curMap = it.next();
             JsonObject object = new JsonObject();

             logger.info("curMap:"+curMap.toString());
             List<EmpVO> empVOList = (List)curMap.get("emp");
             logger.info("empVOList:"+empVOList.toString()); // 리스트로받아옴


             for(EmpVO empVO : empVOList)
             {

                 String userId = empVO.getEmp_Id();
                 int cnt = empVO.getCnt();
                 total += cnt;


                 if(("차장").equals(empVO.getcode_Name()))
                 {

                     chaJang += cnt;

                 }

                else if(("대리").equals(empVO.getcode_Name())){
                     deari += cnt;
                 }

                 else if(("사원").equals(empVO.getcode_Name())){
                     sawon += cnt;

                 }

                 else if(("부장").equals(empVO.getcode_Name())){
                     buJang += cnt;

                 }

                 else  if(("과장").equals(empVO.getcode_Name())){
                     gwaJang += cnt;

                 }



             }

             JsonObject empObject = new JsonObject();
             empObject.addProperty("ID", "사원");
             empObject.addProperty("Count", sawon);
             jArray.add(empObject);

             empObject = new JsonObject();
             empObject.addProperty("ID", "대리");
             empObject.addProperty("Count", deari);
             jArray.add(empObject);
             

             empObject = new JsonObject();
             empObject.addProperty("ID", "차장");
             empObject.addProperty("Count", chaJang);
             jArray.add(empObject);

             empObject = new JsonObject();
             empObject.addProperty("ID", "과장");
             empObject.addProperty("Count", gwaJang);
             jArray.add(empObject);

             empObject = new JsonObject();
             empObject.addProperty("ID", "부장");
             empObject.addProperty("Count", buJang);
             jArray.add(empObject);


             empObject = new JsonObject();
             empObject.addProperty("ID","합계");
             empObject.addProperty("Count", total);
             jArray.add(empObject);





//             object.addProperty("Sawon", sawon);
//             object.addProperty("BuJang", buJang);
//             object.addProperty("JwaJang", jwaJang);
//             object.addProperty("Count", total);
//             object.addProperty("Sawon", sawon);
//             object.addProperty("ChaJang", chaJang);
//             object.addProperty("Deari", deari);



     }


         String jsonGraph = gson.toJson(jArray);
         logger.info(jsonGraph);

         model.addAttribute("jsonGraph", jsonGraph);

         return jsonGraph;

     }








	
}
