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
	private int share_add_book_yn; //공유주소록 판별
					
	// add_book_manage
	private int manage_id;		// PK 주소록관리번호
	private String manage_display_name; // 주소록 표시명
	private String manage_hp; //주소록 번호
	private String manage_email; //주소록 이메일
	private String manage_remark;// 주소록 비고란
	private String manage_company_name; //주소록 회사
	private String manage_official_name; //주소록 직급
	private String manage_dept_name; //부서명
	private int manage_starred; //중요 주소록
	private String manage_add_book_id;
	
	
	private int share_add_book_id;	
	private int share_manage_id;	
	private String emp_id;
	private String share_emp_id;
	private String manage_emp_id;
	private String selectSerch; //주소록 필터
	private int addBookCount; // 주소록에 속한 주소 개수
	private String[] manageIdArr; // 체크한 주소록 개수
	
	private int message_id;
	private String message_content;
	private String message_start_dt;
	private int message_delete;
	private int receiver_delete;
	private int receiver_read;
	private String message_title;

	private String emp_name;
}
