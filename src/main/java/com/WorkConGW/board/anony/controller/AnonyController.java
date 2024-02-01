package com.WorkConGW.board.anony.controller;


import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.anony.dto.AnonyReplyVO;
import com.WorkConGW.board.anony.dto.AnonyVO;
import com.WorkConGW.board.anony.service.AnonyService;
import com.WorkConGW.common.PaginationInfo;
import com.WorkConGW.common.controller.CommonController;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;



@Controller
@RequestMapping("/board/anony/*")
public class AnonyController extends CommonController{
    @Autowired
    private AnonyService anonyService;

    Logger logger = LoggerFactory.getLogger(AnonyController.class);





    @ResponseBody
    @PostMapping("/reply/modify")
    public void replyModify(AnonyReplyVO anonyReplyVO)
    {
        anonyService.modifyAnonyReply(anonyReplyVO);
    }


    // @GetMapping("/list")
    // public String list(@ModelAttribute("boardFormVO")@Valid BoardFormVO boardFormVO , HttpSession session, HttpServletResponse response, HttpServletRequest request,Model model)throws Exception
    // {

    //     logger.info(boardFormVO.getSearchAnonyVO().toString());
    //     Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
    //     if(null != inputFlashMap) {
        
    //         model.addAttribute("msg",(String) inputFlashMap.get("msg"));
            
    //     }

    //     String url = "/board/anony/list";
    //     AnonyVO searchAnonyVO = boardFormVO.getSearchAnonyVO();
    //     logger.info(searchAnonyVO.toString());
    //     removeCookieByName(request,response,"annoy_Board_Id");
       
    //     logger.info("다시들어오니?");
    //     PaginationInfo paginationInfo = new PaginationInfo();
    //     paginationInfo.setCurrentPageNo(searchAnonyVO.getPageIndex()); //현재 페이지 번호에 pageindex 값을 넣는다.
        
    //     paginationInfo.setRecordCountPerPage(searchAnonyVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
    //     paginationInfo.setPageSize(searchAnonyVO.getPageSize());

    //     searchAnonyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    //     searchAnonyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
       
    //     List<AnonyVO> anonyList = anonyService.getAnnoyList(searchAnonyVO);
    //     int totCnt = anonyService.searchListTotalCount(searchAnonyVO);
    //     paginationInfo.setTotalRecordCount(totCnt);
    //     logger.info(paginationInfo.toString());
    //     searchAnonyVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
    //     searchAnonyVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
    //     searchAnonyVO.setPrev(paginationInfo.getXprev());
    //     searchAnonyVO.setNext(paginationInfo.getXnext());
    //     model.addAttribute("searchAnonyVO", searchAnonyVO);
    //     model.addAttribute("anonyList", anonyList);
    //     model.addAttribute("paginationInfo", paginationInfo);
    //     model.addAttribute("totCnt", totCnt);
    //     model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchAnonyVO.getPageUnit()));
    //     model.addAttribute("today", new Date());
    //     return url;
    // }


    @GetMapping("/list")
    public String list(@ModelAttribute("boardFormVO")@Valid BoardFormVO boardFormVO ,ModelAndView mnv, HttpSession session, HttpServletResponse response, HttpServletRequest request,Model model)throws Exception
    {

        logger.info(boardFormVO.getSearchAnonyVO().toString());
        Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
        if(null != inputFlashMap) {
        
            model.addAttribute("msg",(String) inputFlashMap.get("msg"));
            
        }

        String url = "/board/anony/list";
        AnonyVO searchAnonyVO = boardFormVO.getSearchAnonyVO();
        logger.info(searchAnonyVO.toString());
        removeCookieByName(request,response,"annoy_Board_Id");
       
        logger.info("다시들어오니?");
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(searchAnonyVO.getPageIndex()); //현재 페이지 번호에 pageindex 값을 넣는다.
        
        paginationInfo.setRecordCountPerPage(searchAnonyVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(searchAnonyVO.getPageSize());

        searchAnonyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        searchAnonyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
       
        List<AnonyVO> anonyList = anonyService.getAnnoyList(searchAnonyVO);
        int totCnt = anonyService.searchListTotalCount(searchAnonyVO);
        paginationInfo.setTotalRecordCount(totCnt);
        logger.info(paginationInfo.toString());
        searchAnonyVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        searchAnonyVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        searchAnonyVO.setPrev(paginationInfo.getXprev());
        searchAnonyVO.setNext(paginationInfo.getXnext());
        model.addAttribute("searchAnonyVO", searchAnonyVO);
        model.addAttribute("anonyList", anonyList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("totCnt", totCnt);
        model.addAttribute("totalPageCnt", (int)Math.ceil(totCnt/(double)searchAnonyVO.getPageUnit()));
        model.addAttribute("today", new Date());
        mnv.setViewName(url);
        return url;
    }


/* 얘는 비동기 통신일 떄 사용한다. ajax로 처리 그렇게 되면 main페이지가 필요하다. */
    // @ResponseBody
    // @PostMapping("/list/paging")
    // public String tlist(@ModelAttribute("boardFormVO")@Valid BoardFormVO boardFormVO ,@RequestBody(required = false) String filterJSON, HttpServletResponse response, ModelMap model)throws Exception
    // {
    //     logger.info("여기들어오나?");
    //     JSONObject obj = new JSONObject();
    //     response.setContentType("text/html; charset=UTF-8");
    //     AnonyVO searchAnonyVO = boardFormVO.getSearchAnonyVO();
    //     PrintWriter out = response.getWriter();

    //     try{

    //         ObjectMapper mapper = new ObjectMapper();
    //         AnonyVO searchVO  = (AnonyVO)mapper.readValue(filterJSON, new TypeReference<AnonyVO>(){});
            
    //         PaginationInfo paginationInfo = new PaginationInfo();
    //         paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
    //         paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
    //         paginationInfo.setPageSize(searchVO.getPageSize());
    //         searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    //         searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
            
    //         List<AnonyVO> anonyList = anonyService.getAnnoyList(searchAnonyVO);
    //         int totCnt = anonyService.searchListTotalCount(searchAnonyVO);
    //         logger.info(String.valueOf(totCnt));
    //         paginationInfo.setTotalRecordCount(totCnt);
    //         searchVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
    //         searchVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
    //         searchVO.setPrev(paginationInfo.getXprev());
    //         searchVO.setNext(paginationInfo.getXnext());
    //         searchVO.setRealEnd(paginationInfo.getRealEnd());
    
    //         obj.put("resultList",anonyList);
    //         obj.put("resultCnt", totCnt);
    //         obj.put("totalPageCnt", (int)Math.ceil(totCnt / (double)searchVO.getPageUnit()));
    //         obj.put("searchVO", searchVO);
    //         logger.info(String.valueOf(obj));
    //     }
    //     catch(Exception e)
    //     {
    //         System.out.println(e.toString());
    //         obj.put("res","error");
    //     }

    
     
    //     out.print(obj);


    //     return null;

    // }

    




    // @ResponseBody
    // @PostMapping(value = "/list/paging", produces = "application/json;charset=utf-8")
    // public Object tlist(@RequestBody(required = false) String filterJSON, HttpServletResponse response, ModelMap model)throws Exception
    // {
    //     JSONObject obj = new JSONObject();
    //     response.setContentType("text/html; charset=UTF-8");
    //     PrintWriter out = response.getWriter();

    //         ObjectMapper mapper = new ObjectMapper();
    //         AnonyVO searchVO  = (AnonyVO)mapper.readValue(filterJSON, new TypeReference<AnonyVO>(){});
            
    //         PaginationInfo paginationInfo = new PaginationInfo();
    //         paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
    //         paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
    //         paginationInfo.setPageSize(searchVO.getPageSize());
    //         searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    //         searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
            
    //         List<AnonyVO> anonyList = anonyService.getAnnoyList(searchVO);
    //         int totCnt = anonyService.searchListTotalCount(searchVO);
    //         logger.info(String.valueOf(totCnt));
    //         paginationInfo.setTotalRecordCount(totCnt);
    //         searchVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
    //         searchVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
    //         searchVO.setPrev(paginationInfo.getXprev());
    //         searchVO.setNext(paginationInfo.getXnext());
    //         searchVO.setRealEnd(paginationInfo.getRealEnd());
    
    //         obj.put("resultList",anonyList);
    //         obj.put("resultCnt", totCnt);
    //         model.addAttribute("paginationInfo", paginationInfo);
    //         obj.put("totalPageCnt", (int)Math.ceil(totCnt / (double)searchVO.getPageUnit()));
    //         obj.put("searchVO", searchVO);
    //         logger.info(String.valueOf(obj));


    //     return obj;

    // }

    






    /* 
     * @작성자 : 오지환
     * @작성일자 : 2024/01/29
     * @메소드 설계 목적 : 
     */

    @GetMapping("/detail")
    public ModelAndView detail(@ModelAttribute("boardFormVO")@Valid BoardFormVO boardFormVO, @RequestParam("anony_board_id") int queString,ModelAndView mnv, HttpServletResponse response, HttpServletRequest request)throws Exception
    {
        logger.info("detail"+"여기들어와수까?");
        String url = "/board/anony/detail";
        //boardForVO.getannoyVO()하면 board_id값을 파라미터로 넘긴다음, 그 테이블을 boardFormVO에 담는다.
        boardFormVO.setannoyVO(anonyService.getAnony(queString)); // 디비에서 게시글을 가져옴
        AnonyVO anonyVO = boardFormVO.getannoyVO(); //밖 boardFormVO에서 annoyVO를 얻어온다.
        if(!isCookieExist(request,response,"anony_board_id",String.valueOf(anonyVO.getAnony_Board_Id())))
        {
        /* 쿠키가 존재하면 true / 없으면 false */
            anonyService.increaseAnonyReadcnt(anonyVO);
        }

        logger.info("페이징처리 시작 전");
        /* ///////////////////페이지네이션//////////////////////////////////////////// */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(anonyVO.getPageIndex()); //현재 페이지 번호에 pageindex 값을 넣는다.
        
        paginationInfo.setRecordCountPerPage(anonyVO.getPageUnit()); //한 페이지당 게시되는 게시물 수에 pageunit의 디폴트 값인 10 을 넣는다.
        paginationInfo.setPageSize(anonyVO.getPageSize());

        anonyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        anonyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        int totCnt = anonyService.searchListTotalCount(anonyVO);
        paginationInfo.setTotalRecordCount(totCnt);
        logger.info(paginationInfo.toString());
        anonyVO.setEndDate(paginationInfo.getLastPageNoOnPageList());
        anonyVO.setStartDate(paginationInfo.getFirstPageNoOnPageList());
        anonyVO.setPrev(paginationInfo.getXprev());
        anonyVO.setNext(paginationInfo.getXnext());
        /* ///////////////////페이지네이션//////////////////////////////////////////// */
        AnonyVO detailVO = anonyService.getAnony(queString);
        boardFormVO.setannoyVO(detailVO);
        logger.info(anonyVO.toString());
        mnv.addObject("anony", anonyVO);
        mnv.addObject("paginationInfo", paginationInfo);
        mnv.setViewName(url);

        return mnv;

    }

    @ResponseBody
    @PostMapping("/regist")
    public void regist(AnonyVO anonyVO){
        anonyService.regist(anonyVO);
    }

    @GetMapping("/modifyForm")
    public String modifyForm(BoardFormVO boardFormVO)
    {
        String url = "board/anony/modifyForm";
        return url;
    }

    @ResponseBody
    @PostMapping("/modify")
    public void modify(BoardFormVO boardFormVO)
    {
        anonyService.modify(boardFormVO);
    }

    @ResponseBody
    @PostMapping("/remove")
    public void remove(BoardFormVO boardFormVO)
    {
        anonyService.remove(boardFormVO.getannoyVO());
    }


}
