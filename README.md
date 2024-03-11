# WorkConGW

<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/a6e1cc2b-fe86-4ac0-973e-0e148a2c1b3b" width="500"/>

<a href="https://hits.seeyoufarm.com"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FOhsaam%2FChatJava&count_bg=%23697361&title_bg=%23555555&icon=&icon_color=%23816C6C&title=visit&edge_flat=false"/></a>


## 프로젝트 소개 : 
 #### WorkConGW(신 그룹웨어)
기업에 필요한 기능을 제공하는 웹기반 그룹웨어를 목표로 진행했습니다.  

실제 상용화되고 있는 그룹웨어 프로젝트를 참고하여 제작했습니다. 

추가적으로 깃허브 프로젝트, 이슈관리, 마일스톤 기능을 착안하여 제작했습니다.


## 개발 기간 및 작업 관리

### 개발 기간
- 전체 개발 기간 : 2024-01-01 ~ 2024-03-12
- 문서 작업 및 설계기간 : 2024.01.01 ~ 2024.02.01
- UI 구현 : 2024-02-02 ~ 2024-02-10
- 기능 구현 : 2022-02-11 ~ 2022-02-29

### 작업 관리

- GitHub Projects와 Issues를 사용하여 진행 상황을 공유했습니다.
- 주간회의를 진행하며 작업 순서와 방향성에 대한 고민을 나누고 슬랙를 통해 회의 내용을 기록 했습니다.




---

</div>




## 팀원 구성

<div align="center">

| **오지환** | **정태연** | **강우형** | **이휘재** |
| :------: |  :------: | :------: | :------: |
| <img src="https://github.com/Ohsaam.png" height=150 width=150> [<br/> @Ohsaam](https://github.com/Ohsaam)  |   <img src="https://github.com/jungtaeyeon.png" height=150 width=150> [<br/> @jungtaeyeon](https://github.com/jungtaeyeon) | <img src="https://github.com/woohyungkang.png" height=150 width=150> [ <br/> @woohyungkang](https://github.com/woohyungkang) | <img src="https://github.com/ihwijae.png" height=150 width=150> [ <br/> @ihwijae](https://github.com/ihwijae) |

</div>


## 4. 역할 분담

### 🍊오지환(팀장)

- **문서**
    - 요구사항정의서
    - 화면정의서
    - 기능명세서
    - WBS(일정관리)
    - ERD 설계
    - ERD 설명서
    - 상관모델링

     
- **기능**
    - 로그인 기능 구현(비크립트를 사용한 암호화 진행)
    - 아이디 찾기/비밀번호 찾기 기능 구현(임시비밀번호 전송)
    - 마이페이지 구현(이미지 등록 / 및 사인 등록)
    - 대시보드를 사용할 수 있고, 사원에 대한 권한을 갖고 있는 관리자 기능 구현
    - 디비에 작성자가 저장되지 않는 "완전한 익명게시판" 기능 구현
    - 사용자가 등록한 사인을 사용하여 전자결재를 진행할 수 있는 기능 구현
    - paginationinfo를 이용한 페이징 처리 VO제작 및 공통코드 제작 

<br>
    
### 👻정태연(깃 담당)

- **문서**
    - 요구사항정의서
    - 화면정의서
    - 기능명세서
    - WBS(일정관리)
    - 테스트 시나리오
    - 깃 가이드
    - 풀테스트 진행 후 발표 전 시나리오 테스트 진행
      
- **기능**
    - 사내공지게시판 기능 구현 (MultipartFile을 사용한 파일 업로드)
    - 프로젝트 기능 구현 (프로젝트에 속한 이슈 상태 변경)
    - 이슈 기능 구현 (댓글을 통한 이슈 이력관리)
    - 마일스톤 기능 구현 (개인이 원하는 이슈 모아서 관리)
    - SummerNote 에디터 라이브러리를 통한 공통 코드 제작 (이미지 업로드, 삭제 구현)
    - Treeview 라이브러리를 통한 공통 코드 제작


<br>

### 😎강우형

- **문서**
    - 요구사항정의서
    - 화면정의서
    - 기능명세서
    - WBS(일정관리)
    - 풀테스트 진행 후 발표 전 시나리오 테스트 진행
      
- **기능**
    - 홈대시보드 각 리스트 노출 구현 및 대시보드 수정 기능 구현(대시보드 각 컨텐츠 on/off 기능)
    - 주소록 등록 기능 구현(외부/내부 주소록)
    - 주소록 공유 기능 구현(A->B로 주소록 공유)
    - 주소록 그룹 기능 구현(태그형태로 각 주소록에 그룹 기능)
    - 메세지 기능 (A->B로 메시지 전송)
    - 출근/퇴근 기능(버튼 클릭시 디비로 전송)
    - 각 출근/퇴근시간에 맞는 상태 표시 기능(상태로는 정상출근/퇴근/지각/야근/연차 구현)
    - 이달의 근태 통계 (해당달에 평일 일수에서 정상출근/퇴근/야근으로 비율 통계)
    - 부서근태조회(조직도 TREEVIEW를 통해 부서/팀/개인 근태 조회 가능)
    - 전체 그룹웨어 CSS 수정(공통 코드 작업 및 디자인 변경)
<br>

### 🐬이휘재

- **문서**
    - 요구사항정의서
    - 화면정의서
    - 기능명세서
    - 테이블 정의서
    - WBS(일정관리)
    - PPT 작성
      
- **기능**
  
  - 일정관리 기능 구현
    - 일정의 종류에는 부서,팀,개인이 존재하고,
    - 부서일정 등록은 부서장의 권한을 가진 사용자만 가능하다 일반 권한을 가진 사용자는 속한 팀의 일정만 등록가능 
    - 일정 조회는 부서장은 속한 부서와 하위 모든 팀의 일정조회가 가능, 일반 권한은 속한 부서의 일정과, 자신이 속한 팀의 일정만 조회 가능
    - 일정 삭제는 일정을 등록한 사람만 가능
    - 일정 수정도 등록한 사람만 가능
 
  - 시설예약 기능 구현
    - 회의실 등록(관리자 권한만 가능),
    - 조회도 관리자만 가능 (수정, 삭제도 위와 동일)
    - 위의 기능은 관리자만 볼 수 있는 관리 메뉴가 따로 존재
  - 시설공지 기능 구현
    - 공지사항 등록(관리자만 가능)
    - 조회 (모든 권한 가능)
    - 삭제 (관리자만 가능)
      
 - 시설민원 기능 구현
    - 민원 등록(모든권한 가능) ,조회(관리자는 모든 민원을 볼 수 있고, 일반권한은 자신이 등록한 민원만 조회 가능
     
    - 삭제(민원을 등록한 사람만 가능)


<br>




## 주요 문서

🎯 요구사항 정의서 [링크](https://docs.google.com/spreadsheets/d/1t9sCLtStfEMNKuizDF3dDLgz1X0qXi81/edit#gid=1407741134) 

🎯 기능 정의서: [링크](https://docs.google.com/spreadsheets/d/1t9sCLtStfEMNKuizDF3dDLgz1X0qXi81/edit?rtpof=true&sd=true#gid=1407741134)

🎯 테이블 정의서: [링크](https://docs.google.com/spreadsheets/d/1pY1IP5v8_gybodaf7DKnVunPz3uuKo3y/edit?rtpof=true&sd=true#gid=1005822265)

🎯 화면정의서: [링크](https://drive.google.com/file/d/1cKeWUpvTD8EjLoB5c0bL1biyGofqAQZ1/view?usp=drive_link)

🎯 깃가이드: [링크](https://drive.google.com/file/d/1rGDMJYlF2u-pF5uoDLwvY60jcaqz_HLm/view?usp=drive_link)

🎯 개발표준 정의서: [링크](https://drive.google.com/file/d/1RwOCXNiztO3RVaGKxmyQvaHM2BfOfq_k/view?usp=drive_link)




🎯 시나리오 테스트: [링크](https://docs.google.com/spreadsheets/d/1PHrXVvg8TP9mZmxk2nB1vjP4XR8Di0oMY5H7lgmpUBo/edit#gid=2087633204)

🎯 ERD: [링크](https://drive.google.com/file/d/1F9ejhVSKxGMEjze_PAxq0eRFpRHVzGfT/view?usp=drive_link)








## 논 외 </br>
🎆 ERD 설명서: [링크](https://docs.google.com/document/d/1I6B-KR6E1cbvvs06qihpd0k8c3JOK3uv6tsXh5Z9KSs/edit) </br>

🎆 상관 모델링 [링크](https://docs.google.com/spreadsheets/d/1t9sCLtStfEMNKuizDF3dDLgz1X0qXi81/edit#gid=1407741134) 

🎆 발표ppt: [링크](https://docs.google.com/presentation/d/1ciRaEeT5yMoAPDZOGimFv_wGwzw3qEn27fElPa5FCFw/edit?usp=sharing)

## 시작 가이드

### Installation
``` bash
$ git clone [https://github.com/Ohsaam/bookSideProject.git](https://github.com/jungtaeyeon/WorkConGW.git)
$ cd WorkConGW
```
## Group
- ![SLACK](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white)
- ![GOOGLE](https://img.shields.io/badge/Google-4285F4?logo=google&logoColor=fff&style=for-the-badge)


## Stacks 🐈

### Environment
 
- ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-007ACC?style=for-the-badge&logo=Visual%20Studio%20Code&logoColor=white)
- ![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=Git&logoColor=white)
- ![Github](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white)             
- ![INTELLIJ IDEA](https://img.shields.io/badge/IntelliJ_IDEA-000000.svg?style=for-the-badge&logo=intellij-idea&logoColor=white)


### Development
- ![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
- <img src="https://img.shields.io/badge/HTML-F80000?style=for-the-badge&logo=HTML&logoColor=white">
- <img src="https://img.shields.io/badge/Javascript-782A90?style=for-the-badge&logo=Javascript&logoColor=white">
- ![Spring](https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
- ![BootStrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)
- ![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=Oracle&logoColor=white) 
- ![J](https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white)







## 프로젝트 구조 :  [링크](https://docs.google.com/document/d/1h0YNF-S4b2GdLgn36jO7TruVyd0vD_gTZsrT__wteFw/edit?usp=sharing)(클릭 시 자세한 프로젝트 디렉토리가 노출됩니다.)


<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/1d6393a9-6689-4443-99d2-ee39aa4bde2c" width="500"/>



## 페이지별 핵심 기능


#### 로그인

<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/d346ffef-ff65-4e9c-b904-3dea474e72d1" alt="로그인 처리(깃)" width="500"/>


- 로그인은 권한별 기능  (시스템/일반유저) 총 2가지로 구성

- 인터셉터를 통한 txt 파일 저장


 
#### 관리자 

<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/5bbb4962-a87c-48ff-9e56-34a1322d7d4a" alt="관리자 처리(깃)" width="500"/>

- 현재 접속중인 접속자 리스트 : 부서 및 팀별로 접속인원을 카운트 및 현재 접속중인 사용자 표시
- 이번주 신규 입사자 수 : 사원/대리/차장/과장/부장/합계 순서대로 노출(새로고침 시 막대그래프 색깔이 변경된다.)
- 사내공지글 등록 : 관리자는 사내공지 작성 가능 / 필독 및 일반공지 작성 가능
- 민원함 리스트 : 시설 예약 관련된 민원 확인 가능


#### 사원 등록 및 이메일 인증

클라이언트로부터 “회원가입 기능이 따로 존재하지 않고, 관리자가 회원등록을 하는 요구사항를” 받았다는 컨셉으로 진행

<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/de209823-e564-4f22-9743-8070b0c5afd2" alt="관리자 처리(깃)" width="500"/>

</br>

<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/a4a874a9-2486-4854-a075-3ceffba111c7" alt="관리자 처리(깃)" width="500"/>


- 다음 우편주소 api를 사용
- 조직도 TreeView라이브러리 사용
- 이메일로(인증/인가)처리
- 정규식을 이용하여 “영문자 / 숫자 / 특수문자 1개를 포함”
- 인증 시 로그인 페이지로 이동


#### 부서등록
<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/d16dc47f-7a6e-44b1-a21d-70841e06355f" alt="관리자 처리(깃)" width="500"/>

- 부서 및 팀명칭을 입력,중복확인을 진행
- 상위부서 선택
- 등록한 회원을 지금 추가한 팀에 옮김
- 사원 수정 팀 반영


#### 로그인 기록 & 업무시간설정
만약에 워크샵을 간다고 가정하면, 출/퇴근 시간이 변경 + 그 때 업무시간 설정을 해야 되기 때문에 해당 기능 추가


<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/4040e2d8-529e-4374-a52e-2693a71ff06d" alt="관리자 처리(깃)" width="500"/>

- 업무시간 설정 가능
- 관리자는 6시 이후로 시간 변경이 가능(금일 적용이 아닌 6시로부터 8시간 뒤 반영되어 출/퇴근 시간이 변경)



---

#### 홈화면(대시보드/출,퇴근 버튼)
<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/f8be8a94-33dd-46c5-8746-7f9dfd858548" alt="관리자 처리(깃)" width="500"/>

- 사원에 맞는 사진 / 부서 노출

- 출근시간을 누르게 되면, 다시 롤백 안됨

- 퇴근시간을 누르게 되면, 다시 로그인 페이지로 이동

- 다시 로그인 하고 퇴근시간을 누르게 되면 다시 update 되어 최근시간으로 진행

- 대시보드는 on/off로 원하는 기능 노출


#### 일정관리

<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/ee61d679-603d-418e-b0c5-e255ee3637d7" alt="관리자 처리(깃)" width="500"/>


- 일정 등록 시 “부서장이라면” 부서일정 및 팀 일정 등록 가능(부서일정과 하위 팀 일정 모두 확인 가능 / 부서일정 등록은 부서장만 가능)
- 중요일정은 빨간색으로 표시
- 일반일정은 하늘색으로 표시
- 드래그 앤 드랍 가능



#### 시설예약
<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/f8e15256-0bde-412c-bfc2-211a8d607bd6" alt="관리자 처리(깃)" width="500"/>

- 예약하고 싶은 일정 선택 시작시간/종료시간을 정하고  회의실 조회 + 조건에 맞는 회의실 조회
- 회의실 조회 시 시간이 겹치는 회의실 제외
- 나의예약 과 팀 예약 조회 가능
- 관리자는 회의실 생성 가능
- 사용중인 회의실/ 미사용 회의실 조회 가능
- 공지사항 / 예약리스트 / 회의실 민원 조회 가능


#### 게시판

사내공지 게시판
</br>
<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/4b996708-ab38-4027-bb41-ac45010c7b97" alt="관리자 처리(깃)" width="500"/>



- 일반 사용자는 사내공지 글을 쓰지 못함
- 관리자일 경우에는 사내공지 작성 가능
- 썸머노트 에디터 사용
- 이미지 및 파일 다운로드 가능



</br>
익명게시판
</br>
<img src="https://github.com/jungtaeyeon/WorkConGW/assets/96507825/0199adbb-3982-4de4-b532-3a0aa6778fef" alt="관리자 처리(깃)" width="500"/>

- 사용자를 디비에 저장 하지 않기 때문에 “완전한 익명성”이 완전히 보장
- 관리자와 일반 사용자로 사용 가능
- 관리자는 삭제 권한을 갖고 있음
- 일반 사용자일 경우 삭제가 불가능하고, 관리자일 경우에만 삭제가 가능
- 댓글 등록 가능 


