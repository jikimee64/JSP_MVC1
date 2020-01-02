# JSP MVC1 패턴을 이용한 스트리밍 웹 서비스 

## Environment
- OS : Window
- Editor : Intellij
- Language : Html5, css, javascript, JSP 
- DB : MySQL
- Server : Apache Tomcat(local)


## 구현 목표
- 회원가입 시 이메일 인증 
- 로그인, 로그아웃, 회원수정, 회원탈퇴 
- 게시물 등록, 조회, 수정, 삭제, 목록 
- 파일 업로드, 다운로드
- 댓글 작성, 댓글 목록, 댓글 삭제
- 게시판 검색 엔진
- 게시물 신고 
- 게시물 추천


## 스트리밍 방법
<img src="https://user-images.githubusercontent.com/52563841/71667917-61663580-2daa-11ea-949e-9c76d8a74577.JPG" width="60%"></img>  
1. 플라스크 스트리밍 코드를 동작 시 http://127.0.0.1:5000/ 같은IP 주소 실행
  

<img src="https://user-images.githubusercontent.com/52563841/71667919-62976280-2daa-11ea-9e0b-af5b59fe2099.JPG" width="60%"></img>  
2. main.jsp의 173row의 아래를 기준으로 iframe 태그에 IP 주소를 넣어주면 됨
