<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/style/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/style/css/sb-admin-2.min.css" rel="stylesheet">
    
    <script
  			src="https://code.jquery.com/jquery-3.4.1.js"
  			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  			crossorigin="anonymous">
    </script>
    <!--다음주소API  -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회 원 가 입</h1>
                            </div>
                            <form id="join_form" method="post">
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="email" name="email"
                                        placeholder="Email" >
                                        		<span class="id_input_re_1">사용 가능한 이메일입니다.</span>
                                        		<span class="mail_input_box_warn"></span>
												<span class="id_input_re_2">가입된 이메일 입니다.</span>
												<span class="final_mail_ck">이메일을 입력해주세요.</span>
									<div class="mail_check_input_box" id="mail_check_input_box_false">
										<input class ="mail_check_input" disabled="disabled" >
									</div>
									<div class="mailChk">
										<span>인증번호 발송</span>
									</div>
									<div class="clearfix"></div>
	                			    <span id="mail_check_input_box_warn"></span>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user" name="pass"
                                            id="pass" placeholder="Password">
                                    </div>
                                    <span class="final_pw_ck">비밀번호를 입력해주세요.</span>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user"
                                            id="passchk" placeholder="Repeat Password">
                                    </div>
                                    <span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
					                <span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
					                <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
                                </div>
                           		<div class="form-group">
                               <input class="form-control form-control-user" id="address1" name="address"
                                        placeholder="우편번호" readonly="readonly">
                                 </div>
                                 <div>
                                   <input class="form-control form-control-user" id="address2" name="address"
                                        placeholder="기본주소" readonly="readonly">
                                 </div><br>
                                 <div>
                                  <input class="form-control form-control-user" id="address3" name="address"
                                        placeholder="상세주소" readonly="readonly">
                                </div>
                                <span class="final_addr_ck">상세주소를 입력해주세요.</span>
                                <br>
                                <div class ="address-btn" onclick="execution_daum_address()">
                                		<span>주소찾기</span>
                                		<br><br>
                                </div>
                                <button class="btn btn-primary btn-user btn-block" id="join_button">
                                    회원가입
                                 </button>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgot-password.html">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="/member/login">로그인</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    
    <script>
    
    /* 유효성 검사 통과유무 변수 */

    var pwCheck = false;            // 비번
    var pwckCheck = false;            // 비번 확인
    var pwckcorCheck = false;        // 비번 확인 일치 확인
    var mailCheck = false;            // 이메일
    var mailnumCheck = false;        // 이메일 인증번호 확인
    var addressCheck = false         // 주소
    
    
    var code = "";                //이메일전송 인증번호 저장위한 코드
    
    
			$(document).ready(function(){
				//회원가입 버튼(회원가입 기능 작동)
					$("#join_button").click(function(){
				        /* 입력값 변수 */
				        var pw = $('#pass').val();                // 비밀번호 입력란
				        var pwck = $('#passchk').val();            // 비밀번호 확인 입력란
				        var mail = $('#email').val();            // 이메일 입력란
				        var addr = $('#address3').val();        // 주소 입력란
				        
				        /* 비밀번호 유효성 검사 */
				        if(pw == ""){
				            $('.final_pw_ck').css('display','block');
				            pwCheck = false;
				        }else{
				            $('.final_pw_ck').css('display', 'none');
				            pwCheck = true;
				        }
				        /* 비밀번호 확인 유효성 검사 */
				        if(pwck == ""){
				            $('.final_pwck_ck').css('display','block');
				            pwckCheck = false;
				        }else{
				            $('.final_pwck_ck').css('display', 'none');
				            pwckCheck = true;
				        }
				        /* 이메일 유효성 검사 */
				        if(mail == ""){
				            $('.final_mail_ck').css('display','block');
				            mailCheck = false;
				        }else{
				            $('.final_mail_ck').css('display', 'none');
				            mailCheck = true;
				        }
				        /* 주소 유효성 검사 */
				        if(addr == ""){
				            $('.final_addr_ck').css('display','block');
				            addressCheck = false;
				        }else{
				            $('.final_addr_ck').css('display', 'none');
				            addressCheck = true;
				        }
				        /* 최종 유효성 검사 */
				        if(pwCheck&&pwckCheck&&pwckcorCheck&&mailCheck&&mailnumCheck&&addressCheck ){
							$("#join_form").attr("action", "/member/join");
							alert("회원가입이 완료되었습니다.메인화면으로 이동합니다");
							$("#join_form").submit(); 
				        }  
				        return false;  
					});
				});
			
			//아이디 중복검사
			$('#email').on("propertychange change keyup paste input", function(){
				var email = $('#email').val();			// .id_input에 입력되는 값
				var data = {email : email}				// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'	
				var EmailRegex = /^([a-zA-Z0-9_.+-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/; // 정규 표현식
				var warnMsg = $(".mail_input_box_warn");    // 이메일 입력 경고글
					$.ajax({
						type : "post",
						url : "/member/emailChk",
						data : data,
						success : function(result){
							if(result != 'fail'){
								$('.id_input_re_1').css("display","inline-block");
								$('.id_input_re_2').css("display", "none");
								 if (!EmailRegex.test(email)) { // 이메일 형식이 맞지 않으면
									 $('.id_input_re_1').css("display", "none");
									    warnMsg.html("올바르지 못한 이메일 형식입니다.");   // 경고문 출력
									    warnMsg.css("display", "inline-block");
									  }else{
										  $('.id_input_re_1').css("display","inline-block");
										  warnMsg.css("display", "none")
									  }					
							} else {
								$('.id_input_re_2').css("display","inline-block");
								$('.id_input_re_1').css("display", "none");		
							}
						}// success 종료
					}); // ajax 종료
				});// function 종료
				
				/* 인증번호 이메일 전송 */
				$(".mailChk").click(function(){
					alert("인증번호를 전송합니다.")
				    var email = $("#email").val();        // 입력한 이메일   
				    var cehckBox = $(".mail_check_input");        // 인증번호 입력란
				    var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스

				    $.ajax({       
				        type:"GET",
				        url:"mailCheck?email=" + email,	     
				        success:function(data){
				        	alert("인증번호 전송 완료");
				            cehckBox.attr("disabled",false);	     
				            boxWrap.attr("id", "mail_check_input_box_true");
				            console.log("data"+ data);
				            code = data;
				        }
				    });
				});			
				
				/* 인증번호 비교 */
				$(".mail_check_input").blur(function(){
				    
				    var inputCode = $(".mail_check_input").val();        // 입력코드    
				    console.log("inputCode" +inputCode );
				    console.log("code" + code);
				    var checkResult = $("#mail_check_input_box_warn");    // 비교 결과     
				    
				    if(inputCode == code){                            // 일치할 경우
				        checkResult.html("인증번호가 일치합니다.");
				        checkResult.attr("class", "correct");        
				        mailnumCheck = true;     // 일치할 경우
				    } else {                                            // 일치하지 않을 경우
				        checkResult.html("인증번호를 다시 확인해주세요.");
				        checkResult.attr("class", "incorrect");
				        mailnumCheck = false;    // 일치하지 않을 경우
				    }    
				    
				});
				
				/* 다음 주소 연동 */
				function execution_daum_address(){
					
				    new daum.Postcode({
				    	
				        oncomplete: function(data) {
				            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
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
			                    // 주소변수 문자열과 참고항목 문자열 합치기
			                    addr += extraAddr;
			                } else {
			                    addr += ' ';
			                }
			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
							            $("#address1").val(data.zonecode);
							            $("#address2").val(addr);
			                // 커서를 상세주소 필드로 이동한다.
							            $("#address3").attr("readonly",false);
							            $("#address3").focus();
				        
				        } //end oncomplete
				    }).open();  //end Postcode
				}//end execution_daum_address
				
				/* 비밀번호 확인 일치 유효성 검사 */
				 
				$('#passchk').on("propertychange change keyup paste input", function(){
				    var pw = $('#pass').val();
				    var pwck = $('#passchk').val();
				    $('.final_pwck_ck').css('display', 'none');
				    if(pw == pwck){
				        $('.pwck_input_re_1').css('display','block');
				        $('.pwck_input_re_2').css('display','none');
				        pwckcorCheck = true;
				    }else{
				        $('.pwck_input_re_1').css('display','none');
				        $('.pwck_input_re_2').css('display','block');
				        pwckcorCheck = false;
				    }    
				}); 

</script>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/style/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/style/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/style/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/style/js/sb-admin-2.min.js"></script>

</body>

</html>