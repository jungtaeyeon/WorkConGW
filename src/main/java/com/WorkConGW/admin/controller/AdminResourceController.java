package com.WorkConGW.admin.controller;




import com.WorkConGW.common.BSPageBar;
import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.common.dto.BaseVO;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/admin/resource/*")
public class AdminResourceController extends CommonController {

    Logger logger = LoggerFactory.getLogger(AdminResourceController.class);
    @RequestMapping("/loginlog")
    public String loginLog(Model model) throws Exception{
        String url =  "/admin/resource/loginlog";
        String logFilePath = "src/main/resources";
        String fileName = logFilePath+ File.separator+"$$login_user_log.txt";
        File file = new File(fileName);
        /* 파일을 읽기 위한 BufferedReader를 생성 */
        BufferedReader bufReader = new BufferedReader(new FileReader(file));
        /*로그인 로그를 저장할 리스트를 생성한다.*/
        List<String> loginLogList = new ArrayList<>();
        String line = "";

        while((line = bufReader.readLine())!=null) // 파일에서 한 줄씩 읽어와서 리스트에 추가한다.
        {
            loginLogList.add(line);
        }
        bufReader.close();
        int totCnt = loginLogList.size();
        int numPerPage = 3;
        int nowPage = 0;




        logger.info(loginLogList.toString());
        model.addAttribute("loginLogList", loginLogList);
        model.addAttribute("totCnt", totCnt);
        return url;
    }
	
	
}
