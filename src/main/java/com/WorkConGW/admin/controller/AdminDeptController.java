package com.WorkConGW.admin.controller;


import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.common.dto.DeptVO;
import com.WorkConGW.common.service.DeptService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/admin/dept/*")
public class AdminDeptController extends CommonController {
    Logger logger = LoggerFactory.getLogger(AdminCommonController.class);


    @Autowired
    private DeptService deptService = null;


    @PostMapping("/regist")
    public ResponseEntity<String> regist(@ModelAttribute("deptVO")DeptVO deptVO)
    {
        logger.info("여기들어오니?");
        ResponseEntity<String> entity = null;

        try {
            deptService.registDept(deptVO);
            entity = new ResponseEntity<>("1", HttpStatus.OK);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            entity = new ResponseEntity<>("0", HttpStatus.INTERNAL_SERVER_ERROR);

        }


        return entity;
    }

    @GetMapping("/deptInsert")
    public String deptInsert(Model model)
    {
        String url = "admin/dept/insert";
        model.addAttribute("deptVO", new DeptVO());
        return url;
    }

    @PostMapping("/checkName")
    public ResponseEntity<String> checkName(@RequestParam("deptName")String deptName, Model model)
    {
        ResponseEntity<String> entity = null;
        int result;
        try{
            result = deptService.checkName(deptName);
            entity = new ResponseEntity<>(result+"", HttpStatus.OK);
        }
        catch (Exception e){
            entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

        }

        return entity;
    }
	
}
