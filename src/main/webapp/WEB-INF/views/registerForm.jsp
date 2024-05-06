<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <style>
        * { box-sizing:border-box; }

        form {
            width:400px;
            height:600px;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid rgb(89,117,196);
            border-radius: 10px;
        }

        .input-field {
            width: 300px;
            height: 40px;
            border : 1px solid rgb(89,117,196);
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
        label {
            width:300px;
            height:30px;
            margin-top :4px;
        }

        button {
            background-color: rgb(89,117,196);
            color : white;
            width:300px;
            height:50px;
            font-size: 17px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
        }

        .title {
            font-size : 50px;
            margin: 40px 0 30px 0;
        }

        .msg {
            height: 30px;
            text-align:center;
            font-size:16px;
            color:red;
            margin-bottom: 20px;
        }
        .sns-chk {
            margin-top : 5px;
        }
    </style>
    <title>Register</title>
</head>
<body>
<div id="menu">
    <ul>
        <li id="logo">web</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
        <li><a href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>
<script>
    <c:if test="${not empty msgs}">
    let msgs = "${msgs}";
    if (msgs == "DUP_ERR") {
        alert("이미 아이디가 존재합니다.");
    } else if (msgs == "FAIL_ERR") {
        alert("회원가입에 실패하였습니다.");
    } else if (msgs == "ERROR") {
        alert("오류가 발생했습니다.");
    }
    </c:if>
</script>

<form action="<c:url value="/register/save"/>" method="post" onsubmit="return formCheck(this)">
    <div class="title">Register</div>
    <div id="msg" class="msg">
        <c:if test="${not empty param.msg}">
            <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
        </c:if>
    </div>
    <label>아이디</label>
    <input class="input-field" type="text" name="id" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label>비밀번호</label>
    <input class="input-field" type="password" name="pwd" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label>이름</label>
    <input class="input-field" type="text" name="name" placeholder="홍길동">
    <label>이메일</label>
    <input class="input-field" type="text" name="email" placeholder="example@abc.com">
    <label>생일</label>
    <input class="input-field" type="text" name="birth" placeholder="yyyy/mm/dd">
    <div class="sns-chk">
        <label><input type="checkbox" name="sns" value="facebook"/>facebook</label>
        <label><input type="checkbox" name="sns" value="kakaotalk"/>kakao</label>
    </div>
    <button>회원 가입</button>
</form>
<script>
    function formCheck(frm) {
        let msg = '';
        if (frm.id.value.length < 3) {
            setMessage('id의 길이는 3이상이어야 합니다.', frm.id);
            return false;
        }
        if (frm.pwd.value.length < 3) {
            setMessage('pwd의 길이는 3이상이어야 합니다.', frm.pwd);
            return false;
        }
        if (frm.name.value.trim() === '') {
            setMessage('이름을 입력해 주세요.', frm.name);
            return false;
        }
        if (frm.email.value.trim() === '') {
            setMessage('이메일을 입력해 주세요.', frm.email);
            return false;
        }
        if (frm.birth.value.trim() === '') {
            setMessage('생일을 입력해 주세요.', frm.birth);
            return false;
        } else if (!isValidDate(frm.birth.value)) {
            setMessage('잘못된 날짜 형식입니다. 올바른 형식은 yyyy/mm/dd 입니다.', frm.birth);
            return false;
        }
        return true;
    }

    function setMessage(msg, element) {
        const msgDiv = document.getElementById("msg");
        msgDiv.innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
        msgDiv.style.display = 'block'; // 메시지를 보이게 설정
        element.focus(); // 해당 입력 필드에 포커스 설정
    }

    function isValidDate(dateStr) {
        const dateRegex = /^\d{4}\/\d{2}\/\d{2}$/;
        if (!dateRegex.test(dateStr)) {
            return false;
        }
        const dateParts = dateStr.split('/');
        const year = parseInt(dateParts[0], 10);
        const month = parseInt(dateParts[1], 10) - 1;
        const day = parseInt(dateParts[2], 10);
        const dateObj = new Date(year, month, day);
        return dateObj.getFullYear() === year && dateObj.getMonth() === month && dateObj.getDate() === day;
    }
</script>
</body>
</html>