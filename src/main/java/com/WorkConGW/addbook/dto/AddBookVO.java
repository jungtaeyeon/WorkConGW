package com.WorkConGW.addbook.dto;

import org.apache.ibatis.type.Alias;

import com.WorkConGW.common.dto.BaseVO;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Alias("AddBookVO")
public class AddBookVO extends BaseVO{
  // add_book
	private int add_book_id;		// PK 주소록 코드. 시퀀스로 계속 올리는 숫자 (자리수 제한X)
	private String add_book_title;	// 주소록 그룹명
	private String code_add_id;		// 주소록 코드 아이디( A + 숫자 2자리 : 코드그룹 참고.. )
					
	// add_book_manage
	private int manage_id;		// PK 주소록관리번호
	private String manage_display_name; // 주소록 표시명
	private String manage_hp; //주소록 번호
	private String manage_email; //주소록 이메일
	private String manage_remark;// 주소록 비고란
	private String manage_official_name; //주소록 직급
	private String manage_dept_name; //부서명
	
	
	private String emp_id;
	private String selectSerch; //주소록 필터
	private int addBookCount; // 주소록에 속한 주소 개수
	private String[] manageIdArr; // 체크한 주소록 개수
	
}
