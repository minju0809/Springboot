<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:import url="${path}/WEB-INF/view/include/top.jsp" />

<section>
  <br><br>
  <div align=center>
    <h2>회원가입</h2>
    <br>
    <form name="f1" id="registrationForm" action="/memberInsert.do">
      <table class="another-table">
        <tr>
          <th>아이디</th> 
          <td>
            <input type="text" id="username" name="username" value="${nickname}">
            <input type="button" id="usernameBtn" value="중복체크">
            <span class="warning">필수입력</span>
          </td>
        </tr>
        <tr>
          <th>암호</th>
          <td><input type="text" id="password" name="password"><span class="warning">필수입력</span></td>
        </tr>
        <tr>
          <th>이름</th>
          <td><input type="text" id="name" name="name"><span class="warning">필수입력</span></td>
        </tr>
        <tr>
          <th>번호</th>
          <td><input type="text" name="phone"></td>
        </tr>
        <tr>
          <th>메일</th>
          <td><input type="text" name="email"></td>
        </tr>
        <tr>
          <th>우편번호 </th>
          <td>
            <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" name="address" id="sample6_address" placeholder="주소" size=50><br>
            <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
            <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
          </td>
        </tr>
        <tr>
          <th>메모</th>
          <td><textarea cols="30" rows="5" name="etc"></textarea></td>
        </tr>
        <tr>
          <td align="center" colspan="2"><input type="submit" value="저장하기"></td>
        </tr>
      </table>
    </form>
  </div>
  <br>
</section>

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script>
    $(document).ready(function(){
        $("#usernameBtn").click(function(){
            var usernameVal = $("#username").val();
            var data = { username: usernameVal };

            $.ajax({
                type: "GET",
                url: "/usernameCk.do",
                data: data,
                success: function(data){
                    if (usernameVal == "") {
                      alert("아이디를 입력해주세요!!!");
                    } else if (usernameVal.length <= 2) {
                      alert("아이디를 3자리 이상 입력해주세요!!!");
                    } else if (data === "T"){
                      alert("사용 가능한 아이디입니다.");
                    } else {
                      alert("이미 등록되어 있는 아이디입니다.");
                      $("#username").val("");
                      $("#username").focus();
                    }
                }
            });
        });

        $("#registrationForm").submit(function(event) {
          var usernameVal = $("#username").val();
          var passwordVal = $("#password").val();
          var nameVal = $("#name").val();

          if(usernameVal == "" || passwordVal == "" || nameVal == "") {
            alert("아이디, 비밀번호, 이름은 필수 입력 항목입니다!");
            $("username").focus();
            event.preventDefault();
          }
        });
    });
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<c:import url="${path}/WEB-INF/view/include/bottom.jsp" />