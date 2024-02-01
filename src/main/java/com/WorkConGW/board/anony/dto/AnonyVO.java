package com.WorkConGW.board.anony.dto;



import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import com.WorkConGW.common.dto.BaseVO;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.ToString;



@JsonIgnoreProperties(ignoreUnknown = true)
@Alias("anonyVO")
public class AnonyVO extends BaseVO{

    private int anony_Board_Id;
    private String anony_Board_Title;
    private String anony_Board_Content;
    private int anony_Board_ReadCnt;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date anony_Board_Create_Dt;
    private Date anony_Board_Update_Dt;
    private String emp_Writer_Id;
    private List<AnonyReplyVO> anonyReplyList;
    private int replyCount;
    private String anony_board_update_id;
 
    

    public String getAnony_board_update_id() {
        return this.anony_board_update_id;
    }

    public void setAnony_board_update_id(String anony_board_update_id) {
        this.anony_board_update_id = anony_board_update_id;
    };

    public int getAnony_Board_Id() {
        return this.anony_Board_Id;
    }

    public void setAnony_Board_Id(int anony_Board_Id) {
        this.anony_Board_Id = anony_Board_Id;
    }

    public String getAnony_Board_Title() {
        return this.anony_Board_Title;
    }

    public void setAnony_Board_Title(String anony_Board_Title) {
        this.anony_Board_Title = anony_Board_Title;
    }

    public String getAnony_Board_Content() {
        return this.anony_Board_Content;
    }

    public void setAnony_Board_Content(String anony_Board_Content) {
        this.anony_Board_Content = anony_Board_Content;
    }

    public int getAnony_Board_ReadCnt() {
        return this.anony_Board_ReadCnt;
    }

    public void setAnony_Board_ReadCnt(int anony_Board_ReadCnt) {
        this.anony_Board_ReadCnt = anony_Board_ReadCnt;
    }


    public Date getAnony_Board_Create_Dt() {
        return this.anony_Board_Create_Dt;
    }

    public void setAnony_Board_Create_Dt(Date anony_Board_Create_Dt) {
        this.anony_Board_Create_Dt = anony_Board_Create_Dt;
    }

    public Date getAnony_Board_Update_Dt() {
        return this.anony_Board_Update_Dt;
    }

    public void setAnony_Board_Update_Dt(Date anony_Board_Update_Dt) {
        this.anony_Board_Update_Dt = anony_Board_Update_Dt;
    }

    public String getEmp_Writer_Id() {
        return this.emp_Writer_Id;
    }

    public void setEmp_Writer_Id(String emp_Writer_Id) {
        this.emp_Writer_Id = emp_Writer_Id;
    }

    public List<AnonyReplyVO> getAnonyReplyList() {
        return this.anonyReplyList;
    }

    public void setAnonyReplyList(List<AnonyReplyVO> anonyReplyList) {
        this.anonyReplyList = anonyReplyList;
    }

    public int getReplyCount() {
        return this.replyCount;
    }

    public void setReplyCount(int replyCount) {
        this.replyCount = replyCount;
    }


    public AnonyVO(){}


    public AnonyVO(String anony_board_update_id,int annoy_Board_Id, String annoy_Board_Title, String annoy_Board_Content, int annoy_Board_ReadCnt, Date annoy_Board_Create_Dt, Date annoy_Board_Update_Dt, String emp_Writer_Id, List<AnonyReplyVO> anonyReplyList, int replyCount)
    {
        super();
        this.anony_Board_Id = annoy_Board_Id;
        this.anony_Board_Title = annoy_Board_Title;
        this.anony_Board_Content=annoy_Board_Content;
        this.anony_Board_ReadCnt=annoy_Board_ReadCnt;
        this.anony_Board_Create_Dt=annoy_Board_Create_Dt;
        this.anony_Board_Update_Dt=annoy_Board_Update_Dt;
        this.anony_board_update_id=anony_board_update_id;
        this.emp_Writer_Id=emp_Writer_Id;
        this.anonyReplyList=anonyReplyList;
        this.replyCount=replyCount;
    }

    //////////////////////////////////////////////////////////////////////

     /* 각 페이지에 표시할 항목 수를 선택하는 데 사용 */
        public static final String[] PAGE_UNITS= {"10","5","25","50"};
            
        /** 검색조건 */
        private String searchCondition = "";
    
    
        /** 검색사용여부 */
        private String searchUseYn = "";
    
        ////////////////////////////////검색 매개 변수 캡슐화///////////
    
        /** 현재페이지 */
        private int pageIndex = 1;
    
        /** 페이지갯수 */
        private int pageUnit = 4;
    
        /** 페이지사이즈 */
        private int pageSize = 3;
    
        /** firstIndex */
        private int firstIndex = 1;
    
        /** lastIndex */
        private int lastIndex = 1;
    
        /** recordCountPerPage */
        private int recordCountPerPage = 10;
    
        //////////////////////////////////////////
        
        /** 목록 개수 값 */
        private String pageUnitValue;
        
        /** 목록 개수 라벨 */
        private String pageUnitLabel;
        
        /** 목록 개수 셀렉트 박스 item */
        private List<BaseVO> pageUnitSelector;
        
    /////////////////////////////사용자가 각 페이지에 표시할 항목 수를 선택할 수 있도록 하는데 사용

        private int totCnt = 0;				      	
        private int startDate = 0;			    	
        private int endDate = 0;				  
        private int realEnd = 0;	
            
        private boolean prev;
        private boolean next;
        

         /** 검색Keyword */
         private String searchKeyword = "";





    public boolean isPrev() {
            return this.prev;
        }

    public void setPrev(boolean prev) {
            this.prev = prev;
        }

    public boolean isNext() {
            return this.next;
        }

    public void setNext(boolean next) {
            this.next = next;
        } 
        



	public int getTotCnt() {
		return this.totCnt;
	}

	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}

	public int getStartDate() {
		return this.startDate;
	}

	public void setStartDate(int startDate) {
		this.startDate = startDate;
	}

	public int getEndDate() {
		return this.endDate;
	}

	public void setEndDate(int endDate) {
		this.endDate = endDate;
	}

	public int getRealEnd() {
		return this.realEnd;
	}

	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}


  			
    
    
        /** 중복등록방지용 토큰 */
        private String saveToken;
    
        public int getFirstIndex() {
            return firstIndex;
        }
    
        public void setFirstIndex(int firstIndex) {
            this.firstIndex = firstIndex;
        }
    
        public int getLastIndex() {
            return lastIndex;
        }
    
        public void setLastIndex(int lastIndex) {
            this.lastIndex = lastIndex;
        }
    
        public int getRecordCountPerPage() {
            return recordCountPerPage;
        }
    
        public void setRecordCountPerPage(int recordCountPerPage) {
            this.recordCountPerPage = recordCountPerPage;
        }
    
        public String getSearchCondition() {
            return searchCondition;
        }
    
        public void setSearchCondition(String searchCondition) {
            this.searchCondition = searchCondition;
        }
    
        public String getSearchKeyword() {
            return searchKeyword;
        }
    
        public void setSearchKeyword(String searchKeyword) {
            this.searchKeyword = searchKeyword;
        }
    
        public String getSearchUseYn() {
            return searchUseYn;
        }
    
        public void setSearchUseYn(String searchUseYn) {
            this.searchUseYn = searchUseYn;
        }
    
        public int getPageIndex() {
            return pageIndex;
        }
    
        public void setPageIndex(int pageIndex) {
            this.pageIndex = pageIndex;
        }
    
        public int getPageUnit() {
            return pageUnit;
        }
    
        public void setPageUnit(int pageUnit) {
            this.pageUnit = pageUnit;
        }
    
        public int getPageSize() {
            return pageSize;
        }
    
        public void setPageSize(int pageSize) {
            this.pageSize = pageSize;
        }
    
        public String getPageUnitValue() {
            return pageUnitValue;
        }
    
        public void setPageUnitValue(String pageUnitValue) {
            this.pageUnitValue = pageUnitValue;
        }
    
        public String getPageUnitLabel() {
            return pageUnitLabel;
        }
    
        public void setPageUnitLabel(String pageUnitLabel) {
            this.pageUnitLabel = pageUnitLabel;
        }
        
        public List<BaseVO> getPageUnitSelector() {
            return pageUnitSelector;
        }
    
        public void setPageUnitSelector(List<BaseVO> pageUnitSelector) {
            this.pageUnitSelector = pageUnitSelector;
        }
        
        public String getSaveToken() {
            return saveToken;
        }
    
        public void setSaveToken(String saveToken) {
            this.saveToken = saveToken;
        }
    
        @Override
        public String toString() {
            return ToStringBuilder.reflectionToString(this);
        }
    
    

    

}
