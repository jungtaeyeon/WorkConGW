package com.WorkConGW.emp.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.WorkConGW.emp.dto.EmpVO;
import com.WorkConGW.emp.service.EmpService;

@Repository
public class EmpDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;


    Logger logger = LoggerFactory.getLogger(EmpService.class);

    public EmpVO selectEmpById(String emp) {
        logger.info(emp);
        List<EmpVO> empvo = sqlSessionTemplate.selectList("selectEmpById", emp);
        logger.info(empvo.toString());

        if(empvo != null && !empvo.isEmpty()) {
            EmpVO empvo2 = empvo.get(0);
            logger.info(empvo.toString());
            return empvo2;
        } else {
            return null;
        }

    }

    public List<EmpVO> selectEmpList() {
        List<EmpVO> empList = sqlSessionTemplate.selectList("selectEmpList");
        logger.info(empList.toString());
        return empList;
    }

    public List<EmpVO> selectEmpIdListByDeptId(EmpVO empVO ) {
        logger.info(empVO.toString());
        List<EmpVO> empLIst = sqlSessionTemplate.selectList("selectEmpIdListByDeptId", empVO);
        logger.info(empLIst.toString());
        return empLIst;
    }

    public EmpVO checkEmpUpdateYn(String emp_id) {
        EmpVO empVO = sqlSessionTemplate.selectOne("selectEmpById",emp_id);
        return empVO;
    }



    public int updateSign(EmpVO empVO) {
        logger.info("/////////////UpdateSign 전입니다.////////////////");

        return sqlSessionTemplate.update("updateSign", empVO);
    }

    public void updateEmpMyPage(EmpVO empVO) {
        sqlSessionTemplate.update("updateEmpMyPage",empVO);
    }


    public void register(EmpVO empVO){
        sqlSessionTemplate.insert("register", empVO);
    }

    public int idCnt(EmpVO empVO)
    {
        return sqlSessionTemplate.selectOne("idCnt", empVO);
    }
	

    public int findPw(String emp_Email, String emp_Id, String emp_Pwd)
    {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("emp_Email",emp_Email); // {"emp_Email"=emp_Email, "emp_Id" = emp_Id, "emp_Pwd"=emp_Pwd}
        map.put("emp_Id", emp_Id);
        map.put("emp_Pwd",emp_Pwd);
        return sqlSessionTemplate.update("findPw",map); // 성공 1 실패 0 반환
    }

    public int findPwCheck(EmpVO empVO)
    {
        return sqlSessionTemplate.selectOne("findPwCheck",empVO);
    }

	public void createAuthKey(String emp_Email,String emp_authkey) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emp_Email", emp_Email);
		map.put("emp_authkey", emp_authkey);
		
		sqlSessionTemplate.selectOne("createAuthKey", map);
		
	}

    public void empAuth(String emp_Email) throws Exception{
		sqlSessionTemplate.update("empAuth", emp_Email);
	}


}
