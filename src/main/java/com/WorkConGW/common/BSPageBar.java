package com.WorkConGW.common;


public class BSPageBar {
    //전체레코드 갯수
    private int totalRecord;//list.size():47row
    //페이지당 레코드 수
    private int numPerPage;// 10개씩이다
    //블럭당 디폴트 페이지 수 - 여기서는 일단 2개로 정함.
    private int pagePerBlock=3;
    //총페이지 수
    private int totalPage;
    //총블럭 수
    private int totalBlock;
    //현재 내가 바라보는 페이지 수
    private int nowPage;
    //현재 내가 바라보는 블럭 수
    private int nowBlock;
    //적용할 페이지 이름
    private String pagePath;

    private String pagination;
    //페이지 네비게이션 초기화
    /*
     * 화면에서 받아와야 하는 정보에는 어떤 것들이 있을까?
     * 페이지에 뿌려질 로우의 수 numberPerPage
     * 전체 레코드 수 totalRecord
     * 현재 내가 바라보는 페이지 번호 nowPage
     * 내가 처리해야할 페이지 이름 pagePath
     *
     * 공식을 세우는데 필요한 인자는 누구?
     *
     * 세워진 공식들은 어디에서 적용하면 되는 거지?
     *
     * 화면에 내보내 져야 하는 언어는 html 아님 자바 중에서 ?????
     * html
     * 내보내지는 정보는 어디에 담으면 될까?
     *
     */
    public BSPageBar(int numPerPage, int totalRecord, int nowPage, String pagePath) {//공지사항 페이징처리인가 아님 게시판에 페이징 처리인가?
        this.numPerPage = numPerPage;
        this.totalRecord = totalRecord;
        this.nowPage = nowPage;
        this.pagePath = pagePath;

        this.totalPage =
                (int)Math.ceil((double)this.totalRecord/this.numPerPage);// 47.0/10=> 4.7 4.1->5page 4.2->5page
        this.totalBlock=
                (int)Math.ceil((double)this.totalPage/this.pagePerBlock);//5.0/2=> 2.5-> 3장
        //현재 내가바라보는 페이지 : (int)((double)4-1/2)
        this.nowBlock = (int)((double)this.nowPage/this.pagePerBlock);
    }
    //setter메소드 선언
    public void setPageBar() {
        StringBuilder pageLink = new StringBuilder();
        //전체 레코드 수가 0보다 클때 처리하기
        if(totalRecord>0) {
            //nowBlock이 0보다 클때 처리
            //이전 페이지로 이동 해야 하므로 페이지 번호에 a태그를 붙여야 하고
            //pagePath뒤에 이동할 페이지 번호를 붙여서 호출 해야함.
            if(nowBlock > 0 ) {                                    //(1-1)*2+(2-1)=1
                pageLink.append("<li class='page-item'>");
                pageLink.append("<a class='page-link' href='"+pagePath+"?nowPage="+((nowBlock-1)*pagePerBlock+(pagePerBlock-1))+"'>");
                pageLink.append("<span aria-hidden='true'>&laquo;</span>");
                pageLink.append("</a>");
                pageLink.append("</li>");
            }
            for(int i=0;i<pagePerBlock;i++) {
                //현재 내가 보고 있는 페이지 블록 일때와
                if(nowBlock*pagePerBlock+i==nowPage) {
                    pageLink.append("<a class='page-link'>"+(nowBlock*pagePerBlock+i+1)+"</a>");
                }
                //그렇지 않을 때를 나누어 처리해야 함.
                else {
                    pageLink.append("<a class='page-link' href='"+pagePath+"?nowPage="+((nowBlock*pagePerBlock)+i)+"'>"+((nowBlock*pagePerBlock)+i+1)+"</a>");

                }
                //모든 경우에 pagePerBlock만큼 반복되지 않으므로 break처리해야 함.
                //주의할 것.
                if((nowBlock*pagePerBlock)+i+1==totalPage) break;
            }
            //현재 블록에서 다음 블록이 존재할 경우 이미지 추가하고 페이지 이동할 수 있도록
            //a태그 활용하여 링크 처리하기
            if(totalBlock > nowBlock+1) {
                pageLink.append("<li class='page-item'>");
                pageLink.append("<a class='page-link' aria-label='Next' href='"+pagePath+"?nowPage="+((nowBlock+1)*pagePerBlock)+"'>");
                pageLink.append("<span aria-hidden=\"true\">&raquo;</span>");
                pageLink.append("</a>");
                pageLink.append("</li>");
            }
        }
        pagination = pageLink.toString();
    }
    //getter메소드 선언
    public String getPageBar() {
        this.setPageBar();
        return pagination;
    }
}