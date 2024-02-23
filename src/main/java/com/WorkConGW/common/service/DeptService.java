package com.WorkConGW.common.service;

import java.sql.SQLException;
import java.util.List;


import com.WorkConGW.common.dao.DeptDAO;
import com.WorkConGW.common.dto.DeptVO;
import com.WorkConGW.emp.dto.EmpVO;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


@Service
@Slf4j
public class DeptService {


    private final DeptDAO deptDAO;

    @Autowired
    public DeptService(DeptDAO deptDAO) {
        this.deptDAO = deptDAO;
    }

//    public List<DeptVO> selectAllDeptName() throws SQLException{
//        List<DeptVO> deptNameList = deptDAO.selectAllDeptName();
//        /* 활성화된 모든 부서의 기본 정보와 부서장의 정보(만약 지정되어 있다면)를 검색한 리스트 값을 반환 */
//
//        return deptNameList;
//    }

    // https://oingdaddy.tistory.com/400
    // var user = $('select[name="loginUser"]').val(); loginForm.jsp에서 받아온 값.
    // RequestContextHolder = HttpServletRequest에 직접 접근 할 수 있도록 도와주는 역할한다.
    public List<DeptVO> selectDeptListByTeamYn(DeptVO deptVO) throws SQLException{
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        //Request 가지고 오기
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);
        //Session 가지고 오기
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        // loginUser로 사용자에대한 정보를 가져온다.(session 이용) 그렇게 되면 emp는 사용자에 대한 정보를 쥐고있다.

        String deptId = emp.getDept_Id(); //FK
        String empId = emp.getEmp_Id(); // PK
        String codeId = emp.getCode_Id();
        /* deptId : emp에 대한 DeptId를 넣는다. --> 사용자가 회원가입할때 넣은 값 */

        // 파라미터로 들어온 deptVO값에 deptId값을 넣는다. (로그인한 사용자에 대한 deptId값을 부서에 넣는다.)
        deptVO.setDept_Id(deptId); // FK넣는다.
        deptVO.setCode_Id(codeId);


        if(StringUtils.isEmpty(deptVO.getFlag()) && !"adminDept".equals(deptVO.getFlag())) deptVO.setEmp_Id(empId);
// 관리자가 아닌 일반사원인 경우 (if) < emp_id(set한다.)
// 관리자인 경우는 emp_id을 할 필요가 없다. 왜? 이미 지정되어있음


        log.info(deptVO.toString());
        List<DeptVO> DeptList = deptDAO.selectDeptListByTeamYn(deptVO);
        log.info(DeptList.toString());
        // 조회를 하게 되면
        return DeptList;
    }
    public List<DeptVO> selectAllList(DeptVO deptVO) throws Exception {
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        //Request 가지고 오기
        HttpSession session = servletRequestAttribute.getRequest().getSession(true);
        //Session 가지고 오기
        EmpVO emp = (EmpVO)session.getAttribute("loginUser");
        String empId = emp.getEmp_Id();

        deptVO.setEmp_Id(empId);
        List<DeptVO> deptList = deptDAO.selectAllList(deptVO);
        return deptList;
    }
	/*
	  StringUtils는 null-safe 한 연산을 해준다.
		 adminDept 부분은 사용자에게 관리자 권한이 있다고 가정한다.
		 일반 사원인 경우는
		 관리자인경우 모든 부서의 정보 조회가 가능하다.
		 부서정보를 조회한다고 가정했을떄, 일반사용자 + 관리자인 경우 2가지를 나눠 조회한다.
		 일반사용자) 자기 부서만 조회가능함.
		 관리자) 모든 부서의 정보를 조회함. ("권한을 갖는다.")

		 쿼리문 ) --> 팀인경우 / 부서인경우 조회를 다르게간다(deptTeamYn)에 대한 값이 필요함.
	 *
	 */

//    public List<DeptVO> selectDeptPagingList(DeptVO searchDeptVO) throws SQLException{
//        List<DeptVO> deptList = deptDAO.selectDeptPagingList(searchDeptVO);
//
////		for(DeptVO deptVO : deptList) {
////			if(!"없음".equals(deptVO.getDeptLeaderId())) {
////				String leaderName = deptDAO.selectEmpNameByLeaderId(deptVO.getDeptLeaderId());
////				deptVO.setDeptLeaderName(leaderName);
////			}
////		}
//
//        return deptList;
//    }

//    public int selectDeptCount(DeptVO searchDeptVO) throws SQLException{
//        return deptDAO.selectDeptCount(searchDeptVO);
//    }
//
//    public int seletDeptEmpCount(DeptVO deptVO) throws SQLException{
//        return deptDAO.seletDeptEmpCount(deptVO);
//    }
//
//    public void insertDept(DeptVO deptVO) throws SQLException{
//        deptDAO.insertDept(deptVO);
//    }

//    public DeptVO selectDeptByDeptId(String deptId) {
//
//        DeptVO deptVO = new DeptVO();
//        // DeptVO객체를 생성해서 사용자로부터 입력받은 deptId값을
//        // setDeptId해서 사용자가 입력한 부서코드deptId를 detpVO객체에 set한다.
//
//
//        deptVO.setDept_Id(deptId);
//        deptVO = deptDAO.selectDeptByDeptId(deptVO);
//        // 부서장 조회 + deptVO 객체를 넘겨서 dept_id에 대응되는 부서를 찾아서 deptVO에 담는다.
//
//        return deptVO;
//    }

//    public void registDept(DeptVO deptVO) throws SQLException {
//        deptDAO.insertDept(deptVO);
//    }
//
//    public int dupleCheckDeptName(String deptName) {
//        int result = deptDAO.dupleCheckDeptName(deptName);
//        return result;
//    }
//
//    public void modifyDept(DeptVO deptVO) {
//        deptDAO.updateDept(deptVO);
//    }

}
