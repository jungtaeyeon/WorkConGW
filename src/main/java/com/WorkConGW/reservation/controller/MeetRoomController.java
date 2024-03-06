package com.WorkConGW.reservation.controller;

import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.command.FileUploadCommand;
import com.WorkConGW.common.controller.BaseController;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.reservation.dto.*;
import com.WorkConGW.reservation.service.MeetRoomService;
import com.google.api.Http;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cglib.core.Local;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reservation/*")
@Slf4j
public class MeetRoomController extends BaseController {
	private final MeetRoomService meetRoomService;

	@Autowired
	public MeetRoomController(MeetRoomService meetRoomService) {
		this.meetRoomService = meetRoomService;
	}

	@Value("${meetroomPath}")
	private String fileUploadPath;

	@Value("${meetroomPath}")
	private String picturePath;


	/** 메인 페이지 **/
	@GetMapping("/main")
	public String reservationMain(MeetRoomFormVO meetRoomFormVO, Model model,HttpSession session) throws Exception {
		log.info("메인컨트롤러");
		List<MeetRoomVO> allRoomList = meetRoomService.getAllMeetRoomList();

		EmpVO user = (EmpVO)session.getAttribute("loginUser");
		String empId = user.getEmp_Id();
		String deptId = meetRoomService.getDept(empId);

		MeetRoomReservationVO searchMeetRoomVO = new MeetRoomReservationVO();
		MeetRoomVO meetRoomVO = new MeetRoomVO();

		searchMeetRoomVO.setEmp_Id(empId);
		searchMeetRoomVO.setMeet_Room_Dept_Id(deptId);

		ReservationNoticeVO searchReservationNoticeVO = new ReservationNoticeVO();

		// 내 예약
		List<MeetRoomReservationVO> myReservationList = meetRoomService.getSearchReservation(searchMeetRoomVO);
		log.info(myReservationList.toString());
		model.addAttribute("myReservationList", myReservationList);

		// 부서 예약
		searchMeetRoomVO.setIsType("dept"); //강제로 dept를 넣는다 sql에서 조건을 주기위함
		log.info(searchMeetRoomVO.getIsType());
		List<MeetRoomReservationVO> deptReservationList = meetRoomService.getSearchReservation(searchMeetRoomVO);
		log.info(deptReservationList.toString()); //여기서는 isType이 user이다 왜? 원래 등록할 때 user가 디폴트이다 (dept는 조건을 위해 넣은것 셀렉한건 원래 결과인 user)
		model.addAttribute("deptReservationList", deptReservationList);

		// 관리자 공지
		List<ReservationNoticeVO> reservationNoticeList = meetRoomService.getSearchReservationNotice(searchReservationNoticeVO);
		model.addAttribute("reservationNoticeList", reservationNoticeList);

		String date = getDate();
		model.addAttribute("compareDate", date);

		model.addAttribute("allRoomList", allRoomList);
		return "reservation/main";
	}


/**회의실 등록 **/
@ResponseBody
@PostMapping(value = "/regist")
public String registRoom(MeetRoomFormVO meetRoomFormVO, Model model, HttpSession session) throws Exception {
	MeetRoomVO meetRoomVO = new MeetRoomVO();
	meetRoomVO = meetRoomFormVO.getMeetRoomVO();
	String msg;

	log.info(meetRoomVO.toString());

	//로그인한 회원 부서확인 (관리자체크)
	EmpVO user = (EmpVO)session.getAttribute("loginUser");
	meetRoomVO.setMeet_Room_Admin_Id(user.getEmp_Id());
	log.info(meetRoomVO.getMeet_Room_Admin_Id());

	String empId = meetRoomVO.getMeet_Room_Admin_Id();
	String deptId = meetRoomService.getDept(empId);

	if(user.getAuth_Id().equals("s")) {
		log.info("관리자 입니다");
		meetRoomFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
		List<MeetRoomVO> attachList = saveFile(meetRoomFormVO.getFileUploadCommand(), meetRoomVO);
		meetRoomFormVO.getMeetRoomVO().setAttachList(attachList);

		meetRoomService.registMeetRoom(meetRoomVO);
		msg = "생성에 성공하였습니다";
	} else {
		log.info("관리자가 아닙니다");
		msg = "생성에 실패하였습니다";
	}

	model.addAttribute("msg", msg);
	return msg;
}






	@RequestMapping("/adminMain")
	public String adminMain(MeetRoomFormVO meetRoomFormVO, Model model, HttpSession session) throws SQLException {

		log.info("관리페이지컨트롤러");
		log.info(meetRoomFormVO.getSearchMeetRoomVO().getSearchKeyword());
		log.info(Integer.toString(meetRoomFormVO.getMeetRoomVO().getMeet_Room_St()));
		EmpVO user = (EmpVO)session.getAttribute("loginUser");

	/** 회의실 현황 **/
		MeetRoomVO searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO(); //회의실객체
		MeetRoomReservationVO searchMeetRoomReservationVO = meetRoomFormVO.getSearchMeetRoomReservationVO(); //회의실예약객체
		PaginationInfo paginationInfo = new PaginationInfo(); //페이징처리
		setUpPaginationInfo(paginationInfo, searchMeetRoomVO);
		searchMeetRoomVO.setMeet_Room_St(getMeetRoodSt(searchMeetRoomVO)); //활성 비활성화 식별
		List<MeetRoomVO> meetRoomList = meetRoomService.meetRoomList(searchMeetRoomVO);
		log.info(meetRoomList.toString());
		int totCnt = meetRoomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("meetRoomList", meetRoomList);


		/** 전체 예약 가져오기**/
		searchMeetRoomReservationVO.setEmp_Id(user.getEmp_Id());
		List<MeetRoomReservationVO> meetRoomReservationList = meetRoomService.getSearchReservationAll(searchMeetRoomReservationVO);
		model.addAttribute("reservationList", meetRoomReservationList);




		/** 공지 리스트 가져오기 **/
		ReservationNoticeVO searchReservationNoticeVO = meetRoomFormVO.getSearchReservationNoticeVO();
		paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchReservationNoticeVO);

		List<ReservationNoticeVO> reservationNoticeList = meetRoomService.getSearchReservationNotice(searchReservationNoticeVO); // 로그인 유저로 예약 검색

		totCnt = meetRoomService.selectreservationNoticeListTotalCount(searchReservationNoticeVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("reservationNoticeList", reservationNoticeList);
		model.addAttribute("paginationInfo2",paginationInfo);



		/**민원 리스트 가져오기**/
		ReservationComplainVO searchReservationComplainVO = meetRoomFormVO.getSearchReservationComplainVO();
		searchReservationComplainVO.setEmp_Id(user.getEmp_Id());// 관리자계정을 상수로 쓰지않고 어차피 관리자만 해당 컨트롤러를 탄다
		paginationInfo = new PaginationInfo();

		setUpPaginationInfo(paginationInfo, searchReservationComplainVO);
		List<ReservationComplainVO> complainList = meetRoomService.getMyComplainList(searchReservationComplainVO);

		totCnt = meetRoomService.selectreservationComplainListTotalCount(searchReservationComplainVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("complainList", complainList);
		model.addAttribute("paginationInfo3",paginationInfo);
	return "reservation/adminMain";
	}

	@RequestMapping("/roomList")
	public String meetRoomList(MeetRoomFormVO meetRoomFormVO, Model model) throws SQLException {
	log.info("룸리스트");
	MeetRoomVO searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();

		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchMeetRoomVO);

		List<MeetRoomVO> meetRoomList = meetRoomService.meetRoomList(searchMeetRoomVO);

		int totCnt = meetRoomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("meetRoomList", meetRoomList);

		return "reservation/adminMain";
	}


	@RequestMapping("/notUseRoomList")
	public String notUseRoomList(MeetRoomFormVO meetRoomFormVO, HttpSession session, Model model)throws SQLException {

		MeetRoomVO searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();

		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchMeetRoomVO);

		List<MeetRoomVO> meetRoomList = meetRoomService.notUseRoomList(searchMeetRoomVO);

		int totCnt = meetRoomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);



		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("meetRoomList", meetRoomList);

		return "reservation/adminMain";
	}


	@RequestMapping("/modifyForm")
	public String modifyForm(MeetRoomVO meetRoomVO, Model model)throws Exception {
		int meetRoomId = meetRoomVO.getMeet_Room_Id();
		MeetRoomVO meetRoomModify = meetRoomService.getMeetRoomVOForDetail(meetRoomId);

		model.addAttribute("meetRoomVO", meetRoomModify);
		return "reservation/modifyForm";
	}

	@ResponseBody
	@PostMapping("/modify")
	public String modifyRoom(MeetRoomVO meetRoomVO , HttpSession session)throws Exception {

//	MeetRoomVO meetRoomVO = new MeetRoomVO();
//		meetRoomVO = meetRoomFormVO.getMeetRoomVO();
		String msg;

		log.info(meetRoomVO.toString());

		//회원의 권한을 받아오기
		EmpVO user = (EmpVO) session.getAttribute("loginUser");
		meetRoomVO.setMeet_Room_Admin_Id(user.getEmp_Id());
		String empId = meetRoomVO.getMeet_Room_Admin_Id();
		String deptId = meetRoomService.getDept(empId);

		//관리자만 수정 가능
		if (user.getAuth_Id().equals("s")) {
			log.info("관리자 입니다");
			meetRoomService.modifyMeetRoom(meetRoomVO);
			msg ="생성에 성공하였습니다";
		}else {
			log.info("관리자가 아닙니다");
			msg ="생성에 실패하였습니다";
		}

		return msg;

	}


	@RequestMapping("/noticeRegistForm")
	public String noticeRegistFrom(MeetRoomFormVO meetRoomFormVO)  {
		String url="reservation/noticeRegistForm";
		return url;
	}

	@ResponseBody
	@PostMapping("/registNotice")
	public void regist(MeetRoomFormVO meetRoomFormVO) throws Exception {
		log.info("공지등록");
		log.info(meetRoomFormVO.getReservationNoticeVO().toString());


//		ReservationNoticeVO reservationNoticeVO = new ReservationNoticeVO();
//		reservationNoticeVO = meetRoomFormVO.getReservationNoticeVO();
//
//		meetRoomFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
//		List<ReservationNoticeVO> attachList = saveNoticeFile(meetRoomFormVO.getFileUploadCommand(), reservationNoticeVO);
//		meetRoomFormVO.getReservationNoticeVO().setAttachList(attachList);
		meetRoomService.registNotice(meetRoomFormVO.getReservationNoticeVO());
	}


	@RequestMapping("/reservationNoticeDetail")
	public String reservationNoticeDetail(ReservationNoticeVO reservationNoticeVO, Model model)throws Exception {
		log.info("공지사항디테일");
		log.info(Integer.toString(reservationNoticeVO.getReservation_Notice_Id()));
		ReservationNoticeVO noticeVO = meetRoomService.getNoticeVOForDetail(reservationNoticeVO);

		model.addAttribute("noticeVO",noticeVO);

		return "reservation/reservationNoticeDetail";
		/* 여기 */
	}



	@GetMapping("/detail")
	public String detail(MeetRoomVO meetRoomVO, Model model) throws SQLException {
//		MeetRoomVO meetRoomVO1 = meetRoomFormVO.getMeetRoomVO();
//		MeetRoomVO meetRoomVO = meetRoomService.getMeetRoomVOForDetail(meetRoomVO1);
//		meetRoomFormVO.setMeetRoomVO(meetRoomVO);
//
//		model.addAttribute("meetRoomVO", meetRoomVO);
//		return "reservation/detail";
		log.info("디테일");
		int meetRoomId = meetRoomVO.getMeet_Room_Id();
		log.info(Integer.toString(meetRoomId));

		MeetRoomVO meetRoomDetail = meetRoomService.getMeetRoomVOForDetail(meetRoomId);
		model.addAttribute("meetRoomVO", meetRoomDetail);
		return "reservation/detail";
	}

	@ResponseBody
	@PostMapping("/remove")
	public ResponseEntity<String> removeRoom(MeetRoomVO meetRoomVO) throws Exception{
	log.info("회의실 삭제");
		ResponseEntity<String> entity = null;
		log.info(Integer.toString(meetRoomVO.getMeet_Room_Id()));
		meetRoomService.remove(meetRoomVO.getMeet_Room_Id());
		log.info("회의실 삭제시도");
		entity = new ResponseEntity<>("1", HttpStatus.OK);
		return entity;
	}

	@RequestMapping("/reservationNoticeRemove")
	@ResponseBody
	public ResponseEntity<String> noticeRemove(ReservationNoticeVO reservationNoticeVO) throws Exception{
	log.info("공지사항삭제");
	log.info(Integer.toString(reservationNoticeVO.getReservation_Notice_Id()));
	ResponseEntity<String> entity = null;
		try {
			meetRoomService.removeNotice(reservationNoticeVO.getReservation_Notice_Id());
			entity = new ResponseEntity<String>("1", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}




	@RequestMapping("/getPicture")
	@ResponseBody
	public ResponseEntity<byte[]> getPicture(String picture) throws Exception {
	log.info(picturePath);
		log.info(picture);
	ResponseEntity<byte[]> entity = null;
		if(StringUtils.isNotEmpty(picture)) {
			entity = getPicture(picturePath, picture);
		}
		return entity;
	}

	 //회의실 조회버튼 클릭시
	@ResponseBody
	@PostMapping(value = "/searchRoom", produces="application/json;charset=utf-8")
	public   List<MeetRoomVO> searchRoom(@RequestBody Map<String, Object> data) throws Exception {
	log.info("회의실 조회시작");
//	log.info(meetRoomReservationVO.getReservation_Date());
//	log.info(Integer.toString(meetRoomReservationVO.getReservation_Start_Time()));
//	log.info(Integer.toString(meetRoomReservationVO.getReservation_End_Time()));
		log.info(data.toString());

	List<MeetRoomVO> meetRoom = meetRoomService.searchRoom(data);
	log.info(meetRoom.toString());
		return meetRoom;
	}


	//한개의 방 정보를 가져오는함수
	@ResponseBody
	@GetMapping("/searchRoomInfo")
	public  MeetRoomVO searchRoomInfo(MeetRoomVO meetRoomVO) throws Exception {
		log.info("서치품인포");
	int roomId = meetRoomVO.getMeet_Room_Id();
		log.info(Integer.toString(roomId));
	MeetRoomVO room = meetRoomService.searchRoomInfo(roomId);
		return room;
	}

	// 예악을 해주는 메서드
	@PostMapping(value = "/makeReservation")
	@ResponseBody
	public ResponseEntity<String> makeReservation(@RequestBody MeetRoomReservationVO meetRoomReservationVO, HttpSession session) throws Exception {

		log.info("예약메소드");
		EmpVO user = (EmpVO) session.getAttribute("loginUser");
		meetRoomReservationVO.setEmp_Id(user.getEmp_Id());
		String empId = meetRoomReservationVO.getEmp_Id();
		log.info(empId);
		//팀예약 조회를 위한 팀명 가져오기
		String deptId = meetRoomService.getDept(empId);
		meetRoomReservationVO.setMeet_Room_Dept_Id(deptId);
		log.info(deptId);
		log.info(meetRoomReservationVO.toString());
		log.info(Integer.toString(meetRoomReservationVO.getMeet_Room_Reservation_Id()));
		log.info(Integer.toString(meetRoomReservationVO.getMeet_Room_Id()));
		log.info(Integer.toString(meetRoomReservationVO.getReservation_Start_Time()));
		log.info(Integer.toString(meetRoomReservationVO.getReservation_End_Time()));
		log.info(meetRoomReservationVO.getReservation_Date());
		log.info(meetRoomReservationVO.getMeet_Room_Detail());
		log.info(meetRoomReservationVO.getMeet_Room_Dept_Id());
		log.info(Integer.toString(meetRoomReservationVO.getMeet_Room_reservation_St()));

		//부서 예약 조회를 위한 팀명 가져오기

		ResponseEntity<String> entity = null;
		try {
			log.info("예약시도");
			meetRoomService.makeReservation(meetRoomReservationVO);
			log.info(meetRoomReservationVO.toString());

			entity = new ResponseEntity<String>("1", HttpStatus.OK);
			log.info("예약성공");

		} catch (Exception e) {
			e.printStackTrace();
			log.info("예약실패");
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}


	@RequestMapping("/reservationDetail")
	public String reservationDetail(MeetRoomReservationVO meetRoomReservationVO, Model model)throws Exception {

		int reservationId = meetRoomReservationVO.getMeet_Room_Reservation_Id();
		log.info(Integer.toString(reservationId));

		MeetRoomReservationVO meetRoomVO = meetRoomService.getReservationVOForDetail(reservationId);//예약정보 가져오고


		model.addAttribute("meetRoomVO",meetRoomVO);


		return "reservation/reservationDetail";
	}

	@RequestMapping("/reservationRemove")
	public ResponseEntity<String> reservationRemove(MeetRoomReservationVO meetRoomReservationVO) throws Exception{
	ResponseEntity<String> entity = null;
		log.info(Integer.toString(meetRoomReservationVO.getMeet_Room_Reservation_Id()));
		try {
			meetRoomService.reservationRemove(meetRoomReservationVO.getMeet_Room_Reservation_Id());
			log.info("삭제성공");
			entity = new ResponseEntity<String>("1", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}


	@RequestMapping("/reservationList")
	public String reservationList(MeetRoomFormVO meetRoomFormVO ,Model model, HttpSession session)throws Exception {

		EmpVO user = (EmpVO) session.getAttribute("loginUser");
		String empId = user.getEmp_Id();

		/*예약 리스트 가져오기*/
		MeetRoomReservationVO searchMeetRoomReservationVO = meetRoomFormVO.getSearchMeetRoomReservationVO();
		searchMeetRoomReservationVO.setEmp_Id(empId);

		/*내문서인지 부서문서문서인지 식별*/
		String type = "";
		type = searchMeetRoomReservationVO.getIsType();
		if(type.equals("dept")) {
			log.info("부서문서");
			searchMeetRoomReservationVO.setMeet_Room_Dept_Id(meetRoomService.getDept(empId)); //부서가져오기
			model.addAttribute("type", type);/*화면을 위해 저장*/
		}else if (type.equals("user")) {
			log.info("개인문서");
			model.addAttribute("type", type);/*화면을 위해 저장*/

		}

		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchMeetRoomReservationVO);

		List<MeetRoomReservationVO> reservationList = meetRoomService.getSearchReservation(searchMeetRoomReservationVO); // 로그인 유저로 예약 검색

		//회의실 조회수를 위한 객체생성
		MeetRoomVO searchMeetRoomVO = new MeetRoomVO();

		int totCnt = meetRoomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("reservationList", reservationList);

		/*공지 리스트 가져오기*/
		ReservationNoticeVO searchReservationNoticeVO = meetRoomFormVO.getSearchReservationNoticeVO();
		searchReservationNoticeVO.setEmp_Id(empId);
		paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchReservationNoticeVO);

		List<ReservationNoticeVO> reservationNoticeList = meetRoomService.getSearchReservationNotice(searchReservationNoticeVO); // 로그인 유저로 예약 검색

		totCnt = meetRoomService.selectreservationNoticeListTotalCount(searchReservationNoticeVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("reservationNoticeList", reservationNoticeList);
		model.addAttribute("paginationInfo2",paginationInfo);

		/*민원 리스트 가져오기*/
		ReservationComplainVO searchReservationComplainVO = meetRoomFormVO.getSearchReservationComplainVO();
		searchReservationComplainVO.setEmp_Id(empId);
		paginationInfo = new PaginationInfo();

		setUpPaginationInfo(paginationInfo, searchReservationComplainVO);
		List<ReservationComplainVO> complainList = meetRoomService.getMyComplainList(searchReservationComplainVO);

		totCnt = meetRoomService.selectreservationComplainListTotalCount(searchReservationComplainVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("complainList", complainList);
		model.addAttribute("paginationInfo3",paginationInfo);

		String date = getDate();

		model.addAttribute("compareDate",date);

		return "reservation/reservationList";
	}


	@PostMapping(value="/registComplain")
	public String registComplain(MeetRoomFormVO meetRoomFormVO, Model model) throws Exception {
	log.info("민원컨트롤러");
	log.info(meetRoomFormVO.getReservationComplainVO().toString());
//	meetRoomService.registComplain(meetRoomFormVO.getReservationComplainVO());


		meetRoomService.registComplain(meetRoomFormVO.getReservationComplainVO());
		return "reservation/complainSuccess";
	}

	@RequestMapping("/complain/detail")
	public String complainDetail(ReservationComplainVO reservationComplainVO, Model model) throws Exception{
		ReservationComplainVO complainVO = meetRoomService.getComplainVOForDetail(reservationComplainVO);

		model.addAttribute("complain",complainVO);

		return "reservation/complain/detail";
	}



	/**
	 * 사용하는 메소드
	 */



	private String getDate() {
		LocalDate currentDate = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return currentDate.format(formatter);
	}


	/**
	 * 활성, 비활성화 식별 메소드
	 * @param searchMeetRoomVO
	 * @return
	 */
	protected int getMeetRoodSt(MeetRoomVO searchMeetRoomVO) {
		int meetRoomSt = 0;
		int st = searchMeetRoomVO.getMeet_Room_St();
		log.info(Integer.toString(st));

		if (st == 0) meetRoomSt = 1; //초기값0이 넘어와서 첫화면은 활성화만 보여주기 위해

		if (st == 1) {
			meetRoomSt = 1;
		}else if (st == 2){
			meetRoomSt = 0;
		}
		log.info("반환되는 숫자={}", meetRoomSt);
		return meetRoomSt;
	}

	protected List<MeetRoomVO> saveFile(FileUploadCommand fileUploadCommand, MeetRoomVO meetRoomVO) throws Exception {

		List<MeetRoomVO> attachList = new ArrayList<MeetRoomVO>();

		if(fileUploadCommand.getUploadFile() != null) {

			for(MultipartFile multi : fileUploadCommand.getUploadFile()) {
				if(multi.isEmpty()) continue;
				String attachName = RandomStringUtils.randomAlphanumeric(20) +"!!"
						+ multi.getOriginalFilename();
				File target = new File(fileUploadCommand.getFileUploadPath(), attachName);

				if (!target.exists()) {
					target.mkdirs();
				}

				multi.transferTo(target);

				MeetRoomVO attach = new MeetRoomVO();
				meetRoomVO.setMeet_Room_Attach_Origin(attachName);
				meetRoomVO.setMeet_Room_Attach_Name(multi.getOriginalFilename());
				meetRoomVO.setMeet_Room_Attach_Type(attachName.substring(attachName.lastIndexOf(".")+1).toUpperCase());


				attachList.add(attach);
			}
		}

		return attachList;
	}



//	protected List<ReservationNoticeVO> saveNoticeFile(FileUploadCommand fileUploadCommand, ReservationNoticeVO reservationNoticeVO) throws Exception {
//
//		List<ReservationNoticeVO> attachList = new ArrayList<ReservationNoticeVO>();
//
//		if(fileUploadCommand.getUploadFile() != null) {
//
//			for(MultipartFile multi : fileUploadCommand.getUploadFile()) {
//				if(multi.isEmpty()) continue;
//				String attachName = RandomStringUtils.randomAlphanumeric(20) +"!!"
//						+ multi.getOriginalFilename();
//				File target = new File(fileUploadCommand.getFileUploadPath(), attachName);
//
//				if (!target.exists()) {
//					target.mkdirs();
//				}
//
//				multi.transferTo(target);
//
//				ReservationNoticeVO attach = new ReservationNoticeVO();
//
//				reservationNoticeVO.setAttach_Origin(attachName);
//				reservationNoticeVO.setAttach_Name(multi.getOriginalFilename());
//				reservationNoticeVO.setAttach_Type(attachName.substring(attachName.lastIndexOf(".")+1).toUpperCase());
//
//
//				attachList.add(attach);
//			}
//		}
//
//		return attachList;
//	}

	@PostMapping("/reservationComplainRemove")
	@ResponseBody
	public ResponseEntity<String> complainRemove(@RequestParam String removeId) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			meetRoomService.removeComplain(Integer.parseInt(removeId));
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

}
