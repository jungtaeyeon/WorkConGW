package com.WorkConGW.board.anony.service;


import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.WorkConGW.board.BoardFormVO;
import com.WorkConGW.board.anony.dao.AnonyDAO;
import com.WorkConGW.board.anony.dto.AnonyReplyVO;
import com.WorkConGW.board.anony.dto.AnonyVO;



@Service
public class AnonyService {

     Logger logger = LoggerFactory.getLogger(AnonyService.class);
    @Autowired
	private AnonyDAO anonyDAO;


    /* @ 작성자 : 오지환
     * @ 작성일자 : 2024.01.29
     * @ 설계목적 : 
     * - anonyVO 필드를 보면, 댓글 List가 존재한다. 1번 게시물에 대해 모든 댓글을 출력해야함.
     * - 1. anonyDAO.selectList로 모든 게시물에 대해서 List로 저장.
     * - 2. for문을 통해서 게시물 List를 순회하는데, 여기서 게시물에 맞는 댓글들을 모두 가져와야함
     * - 3. 그래서 for문 {} 안에서 DAO 접근을 한 뒤, "하나의 게시물에 대한 댓글을 모두 가져온다."
     * - 4. 이 부분을 위해서 댓글(annoyVO-게시글)을 파라미터로 넘긴다. annoyVO에 board_id가 있기 때문에, 댓글DAO에서 board_id를 기준으로 조인한다.
     * - 5. 그러면 게시물에 대한 모든 댓글을 출력한다. 그 모든 댓글을 anonyVO.setAnonyReplyList(annoyReplyList)에 set한다.
     */
    public List<AnonyVO> getAnnoyList(AnonyVO searchAnonyVO) {

        List<AnonyVO> anonyList = anonyDAO.selectAnonyList(searchAnonyVO);
        logger.info("anonyList :" + anonyList.toString());

        for(AnonyVO anonyVO : anonyList)
        {
            List<AnonyReplyVO> anonyReplyList = anonyDAO.selectAnonyReplyList(anonyVO.getAnony_Board_Id());
            anonyVO.setAnonyReplyList(anonyReplyList); 

            logger.info("anonyReplyList : " + anonyReplyList.toString());
        }
        return  anonyList;
    }

    public int searchListTotalCount(AnonyVO searchAnonyVO) {
        return anonyDAO.selectAnonyListTotalCount(searchAnonyVO);   
        
    }

    public void regist(AnonyVO anonyVO) {
        anonyDAO.insertAnony(anonyVO);
    }

    public void modify(BoardFormVO boardFormVO) {
        AnonyVO anonyVO = boardFormVO.getannoyVO();
        anonyDAO.updateAnony(anonyVO);
    }

    public void remove(AnonyVO anonyVO) {
        anonyDAO.deleteAnony(anonyVO);
    }

    public AnonyVO getAnony(int queString) {
        /* anonyVO는 사용자로부터 받은 값을 의미. 그 값을 넣음. 
         * anony는 사용자가 파리미터로 넘긴 annoyVO의 결과값을 받음.
         * 댓글도 같이 가져옴(이것도 annoyVO를 넘겨야함(사용자 입력값))
        */
       AnonyVO anony =  anonyDAO.selectAnonyById(queString);
       List<AnonyReplyVO> anonyReplyVOList = anonyDAO.selectAnonyReplyList(queString);
       anony.setAnonyReplyList(anonyReplyVOList);
    
       return anony;
    }

    public void increaseAnonyReadcnt(AnonyVO anonyVO) {
        anonyDAO.increaseAnonyReadcnt(anonyVO);
    }

    public void modifyAnonyReply(AnonyReplyVO anonyReplyVO) {
        anonyDAO.updateAnonyReply(anonyReplyVO);

    }

    public List<Map<String,Object>> getJsonAnnoyList(AnonyVO searchVO) {
        List<Map<String,Object>> pmap= anonyDAO.getJsonAnnoyList(searchVO);
        return pmap;
    }


	
}
