package com.WorkConGW.board;

import com.WorkConGW.board.anony.dto.AnonyReplyVO;
import com.WorkConGW.board.anony.dto.AnonyVO;
import com.WorkConGW.emp.dto.EmpVO;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.ToString;
@ToString
public class BoardFormVO {
	

	private EmpVO empVO;
	private EmpVO searchEmpVO;


	private AnonyVO annoyVO;
	private AnonyReplyVO annoyReplyVO;
	private AnonyVO searchAnonyVO;

	
	public BoardFormVO() {


		this.annoyVO = new AnonyVO();
		this.searchAnonyVO = new AnonyVO();
		this.annoyReplyVO= new AnonyReplyVO();


		this.empVO = new EmpVO();
		
	}
	
	public AnonyReplyVO getAnnoyReplyVO() {
		return this.annoyReplyVO;
	}

	public void setAnnoyReplyVO(AnonyReplyVO annoyReplyVO) {
		this.annoyReplyVO = annoyReplyVO;
	}

	public int getAnonyBoardId(){
		return this.annoyVO.getAnony_Board_Id();
	}
	public void setAnonyBoardId(int anonyBoardId){
		this.annoyVO.setAnony_Board_Id(anonyBoardId);

	}

	public AnonyVO getannoyVO() {
		return annoyVO;
	}

	public void setannoyVO(AnonyVO annoyVO) {
		this.annoyVO = annoyVO;
	}

	public AnonyVO getSearchAnonyVO()
	{
		return searchAnonyVO;
	}

	public void setSearchAnonyVO(AnonyVO searchAnonyVO)
	{
		this.searchAnonyVO=searchAnonyVO;
	}


	
	//회원(직원)내정보
	public EmpVO getEmpVO() {
		return empVO;
	}
	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}
	public EmpVO getSearchEmpVO() {
		return searchEmpVO;
	}
	public void setSearchEmpVO(EmpVO searchEmpVO) {
		this.searchEmpVO = searchEmpVO;
	}
	






}
