package com.WorkConGW.common.service;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.WorkConGW.common.controller.CommonController;
import com.WorkConGW.common.dao.DashboardDAO;
import com.WorkConGW.common.dao.HomeDAO;
import com.WorkConGW.common.dto.DashboardVO;
import com.WorkConGW.emp.dto.EmpVO;


@Service
public class HomeService {
    
    Logger logger = LoggerFactory.getLogger(HomeService.class);
    @Autowired
    private HomeDAO homeDAO;

    @Value("${weather.app.key}")
    private String weatherAppKey;

    @Autowired
    private DashboardDAO dashboardDAO;


    public void modifyDashboard(DashboardVO dashboardVO) throws SQLException{
        dashboardDAO.updateDashboard(dashboardVO);
        
    }


    public void insertDashboard(DashboardVO dashboardVO)
    {
        dashboardDAO.insertDashboard(dashboardVO);
    }

    /* 이 부분 리팩토링 대상 emp로 옮겨야하나 common으로 두어야하나... */
    public int updateProfile(MultipartFile profileImage, String webPath, EmpVO empVO)throws IOException, IllegalStateException {
    
        logger.info("profile Service updateProfile 들어오니?");
        String temp = empVO.getEmp_Picture(); // 이전 이미지 저장
        logger.info(temp);
        String rename = null;

        if(profileImage.getSize() > 0) // 업로드된 이미지가 있을 경우
        {
            rename = fileRename(profileImage.getOriginalFilename(), empVO);
            logger.info(rename);
            logger.info("if : profileImage 사진이 있을 때");
            //바뀐 이름 저장
            empVO.setEmp_Picture(rename);
        }
        else{ // 없는 경우 
            empVO.setEmp_Picture(null); //세션이미지를 null로 변경해서 삭제한다.
            logger.info(" else : profileImage 사진이 없을 때");
        }

        int result = homeDAO.updateProfile(empVO);

        if(result > 0) // 성공했을 경우
        {
            if(rename != null) // 새 이미지가 업로드 된 경우
            {
                if(empVO.getEmp_Picture()!= null)
                {
                    profileImage.transferTo(new File(rename));

                }
            }////////////end of if/////////////
        }//////////////////////////end of if /////////////////////////////

        else{ // 실패한 경우
            empVO.setEmp_Picture(temp); // 이전 이미지로 다시 세팅

        }/////////////////////////end of else /////////////////////////////

        return result;
    }


    public static String fileRename(String originFileName, EmpVO empVO) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));
		
		int ranNum = (int) (Math.random() * 100000); // 5자리 랜덤 숫자 생성
		
		String str = "_" + String.format("%05d", ranNum);
		
		String ext = originFileName.substring(originFileName.lastIndexOf("."));
        
		
		return empVO.getEmp_Id() + str + ext;
	}


    public String getWeather() {
        String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid="+weatherAppKey+"&units=metric&lang=kr";
        logger.info(apiUrl);


        try{
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection(); //apiUrl를 HttpUrl형식으로 연결.
            connection.setRequestMethod("GET");
            int responseCode = connection.getResponseCode(); //상태코드(요청을 보낸 다음에 받아온 응답코드)
            BufferedReader br;
            if(responseCode==200)
            {
                br = new BufferedReader(new InputStreamReader(connection.getInputStream()));

            }
            else
            {
                br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            }
            String inputLine;
            StringBuilder response = new StringBuilder();
            while((inputLine=br.readLine())!=null)
            {
                response.append(inputLine);
            }
            br.close();
            logger.info("response :" + response.toString());
            return response.toString();
        }catch(Exception e)
        {
            return "failed to get response!";
        }
    }

	
}
