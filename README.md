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
    - 공유주소록 기능 구현
    - 근태관리 기능 구현
    - 전반적인 UI 구현
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



