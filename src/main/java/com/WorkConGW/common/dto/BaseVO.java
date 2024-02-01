package com.WorkConGW.common.dto;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;


public class BaseVO{

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
        
        //QueryString
        private String queryString = "";
         /** 검색Keyword */
         private String searchKeyword = "";

        public String getQueryString() {
            return this.queryString;
        }

        public void setQueryString() throws UnsupportedEncodingException {
            String qs = "";
            qs += "&searchKeyword="+URLEncoder.encode(this.searchKeyword, "UTF-8");
            qs += "&pageIndex="+this.pageIndex;
            
            this.queryString = qs;
            
        }



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
    