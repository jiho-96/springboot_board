<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID=' += loginId}"/>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>board</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }

        .container {
            width: 50%;
            margin: auto;
        }

        .writing-header {
            position: relative;
            margin: 20px 0 0 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
        }

        input {
            width: 100%;
            height: 35px;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }

        textarea {
            width: 100%;
            background: #f8f8f8;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }

        .btn {
            background-color: rgb(236, 236, 236);
            border: none;
            color: black;
            padding: 6px 12px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn:hover {
            text-decoration: underline;
        }

        .custom-comment-list {
            width: 50%;
            margin: 20px auto;
            font-family: "Noto Sans KR", sans-serif;
        }

        .custom-comment-item {
            background-color: #f9f9fa;
            list-style-type: none;
            border-bottom: 1px solid rgb(235,236,239);
            padding: 8px;
            position: relative;
            margin-bottom: 5px;
        }

        .custom-comment-content {
            overflow-wrap: break-word;
        }

        .custom-comment-bottom {
            font-size: 9pt;
            color: rgb(97,97,97);
            padding: 8px 0;
        }

        .custom-comment-bottom a {
            color: rgb(97,97,97);
            text-decoration: none;
            margin-right: 6px;
        }

        .custom-comment-area {
            padding-left: 46px;
        }

        .custom-commenter {
            font-size: 12pt;
            font-weight: bold;
        }

        .custom-comment-img {
            font-size: 36px;
            position: absolute;
        }


        .custom-comment-writebox {
            width: 50%;
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        .custom-comment-writebox textarea {
            width: 100%;
            height: 100px;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            resize: none;
        }

        .custom-comment-writebox button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

    </style>
</head>
<body>
<div id="menu">
    <ul>
        <li id="logo">web</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
        <li><a href=""><i class="fas fa-search small"></i></a></li>
    </ul>
</div>
<script>
    let msg = "${msg}";
    if(msg=="WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.");
    if(msg=="MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>
<div class="container">
    <h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="bno" value="${boardDto.bno}">
        <input type="hidden" name="page" value="${param.page}">
        <input type="hidden" name="pageSize" value="${param.pageSize}">
        <input type="hidden" name="page" value="${param.option}">
        <input type="hidden" name="pageSize" value="${param.keyword}">

        <input name="title" type="text" value="<c:out value='${boardDto.title}'/>" placeholder="  제목을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}><br>
        <textarea name="content" rows="15" placeholder=" 내용을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}><c:out value='${boardDto.content}'/></textarea><br>

        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
        </c:if>
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 글쓰기</button>
        </c:if>
        <c:if test="${boardDto.writer eq loginId}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> 수정</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> 삭제</button>
        </c:if>
        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록</button>
    </form>
</div>
<c:if test="${not empty boardDto.title}">
<div class="custom-comment-list" id="custom-comment-list">

</div>
<div class="custom-comment-writebox">
    <textarea placeholder="댓글을 입력해주세요." name="commentText"></textarea>
    <button class="btn" id="commentSend">등록</button>
</div>

    <div id="replyForm" style="display: none">
        <input type="text" name="replyComment">
        <button id="wrtRepBtn" type="button">등록</button>
    </div>
</c:if>

<script>
    $(document).ready(function(){
        let bno = $("input[name='bno']").val();
        showList(bno);

        let formCheck = function() {
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }

            if(form.content.value=="") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }

        $("#writeNewBtn").on("click", function(){
            location.href="<c:url value='/board/write'/>";
        });

        $("#writeBtn").on("click", function(){
            let form = $("#form");
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");

            if(formCheck())
                form.submit();
        });

        $("#modifyBtn").on("click", function(){
            let form = $("#form");
            let isReadonly = $("input[name=title]").attr('readonly');

            // 1. 읽기 상태이면, 수정 상태로 변경
            if(isReadonly=='readonly') {
                $(".writing-header").html("게시판 수정");
                $("input[name=title]").attr('readonly', false);
                $("textarea").attr('readonly', false);
                $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
                return;
            }

            // 2. 수정 상태이면, 수정된 내용을 서버로 전송
            form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if(formCheck())
                form.submit();
        });

        $("#removeBtn").on("click", function(){
            if(!confirm("정말로 삭제하시겠습니까?")) return;

            let form = $("#form");
            form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
            form.attr("method", "post");
            form.submit();
        });

        $("#listBtn").on("click", function(){
            location.href="<c:url value='/board/list${searchCondition.queryString}'/>";
        });


        $("#custom-comment-list").on("click", ".btn-modify", function() {
            let commentDiv = $(this).closest(".custom-comment-item").find(".custom-comment-content");
            let commentText = commentDiv.text();
            let inputHtml = '<input type="text" class="edit-comment-input" value="' + escapeHtml(commentText) + '">';

            commentDiv.html(inputHtml);
            let inputField = commentDiv.find("input");
            inputField[0].defaultValue = commentText; // defaultValue 설정
            inputField.focus();

            $(this).text("OK").removeClass("btn-modify").addClass("btn-confirm");
        });

        $("#custom-comment-list").on("click", ".btn-confirm", function() {
            let inputField = $(this).closest(".custom-comment-item").find(".edit-comment-input");
            let comment = inputField.val();
            let cno = $(this).closest(".custom-comment-area").data("cno");
            let self = this; // this를 self 변수에 저장
            console.log("cno:", cno);
            if (comment.trim() === "") {
                alert("댓글 내용을 입력해주세요.");
                inputField.focus();
                return;
            }

            $.ajax({
                type: 'PATCH',
                url: '/comments/' + cno,
                headers:{"content-type" : "application/json"},
                data: JSON.stringify({cno: cno, comment: comment}),
                success: function(response) {
                    alert('댓글이 수정되었습니다.');
                    inputField.parent().html(escapeHtml(comment));
                    $(self).text("Edit").removeClass("btn-confirm").addClass("btn-modify");
                },
                error: function() {
                    alert('댓글 수정 실패.');
                    inputField.parent().html(escapeHtml(inputField[0].defaultValue));
                    $(self).text("Edit").removeClass("btn-confirm").addClass("btn-modify");
                }
            });

    });


        $("#wrtRepBtn").click(function (){
            let comment = $("input[name=replyComment]").val();
            let pcno = $(this).closest(".custom-comment-area").data("pcno");
            if (comment.trim()==''){
                alert("답글을 입력해주세요.");
                $("input[name=replyComment]").focus()
                return;
            }

            $.ajax({
                type:'POST',
                url:'/comments?bno='+bno,
                headers:{"content-type" : "application/json"},
                data:JSON.stringify({pcno:pcno, bno:bno, comment: comment}),
                success:function (result){
                    alert(result);
                    showList(bno);
                },
                error: function (){ alert("error") }
            });

            $("#replyForm").css("display", "none");
            $("input[name=replyComment]").val('');
            $("#replyForm").appendTo("body");
        });

        $("#custom-comment-list").on("click", ".btn-write", function (){
            // replyForm을 옮김
            $("#replyForm").appendTo($(this).parent());

            // 답글을 입력할 폼을 보여줌
            $("#replyForm").css("display", "block")
        });




        $("#commentSend").click(function (){
            let comment = $("textarea[name=commentText]").val();
            if (comment.trim()==''){
                alert("댓글을 입력해주세요.");
                $("textarea[name=commentText]").focus()
                return;
            }

            $.ajax({
                type:'POST',
                url:'/comments?bno='+bno,
                headers:{"content-type" : "application/json"},
                data:JSON.stringify({bno:bno, comment: comment}),
                success:function (result){
                    alert(result);
                    showList(bno);
                    $("textarea[name='commentText']").val('');
                },
                error: function (){ alert("error") }
            });
        });


        $("#custom-comment-list").on("click", ".btn-delete", function() {
            let cno = $(this).closest(".custom-comment-area").data("cno");
            let bno = $(this).closest(".custom-comment-area").data("bno");

            if (!confirm("정말로 삭제하시겠습니까?")) {
                return false;
            }

            $.ajax({
                type: 'DELETE',
                url: '/comments/' + cno + '?bno=' + bno,
                success: function(response) {
                    alert('댓글이 삭제되었습니다.');
                    showList(bno);
                },
                error: function() {
                    alert("댓글 삭제에 실패했습니다.");
                }
            });
        });
    });




    let showList = function (bno){
        $.ajax({
            type:'GET',
            url: '/comments?bno='+bno,
            success: function (result){
                $("#custom-comment-list").html(toHTML(result))
            },
            error: function (){ alert("error") }
        });
    }

    function escapeHtml(text) {
        if (text == null) return "";
        return text
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    };


    function formatDate(dateStr) {
        var date = new Date(dateStr);
        var year = date.getFullYear();
        var month = ("0" + (date.getMonth() + 1)).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        var hour = ("0" + date.getHours()).slice(-2);
        var minute = ("0" + date.getMinutes()).slice(-2);
        return year + '/' + month + '/' + day + ' ' + hour + ':' + minute;
    };

    let toHTML = function (comments) {
        let tmp = '';

        comments.forEach(function (comment) {
            let formattedDate = formatDate(comment.upDate);
            tmp += '<div class="custom-comment-item">';
            if(comment.cno!=comment.pcno)
            tmp += 'ㄴ'
            tmp += '<span class="custom-comment-img"><i class="fa fa-user-circle" aria-hidden="true"></i></span>';
            tmp += '<div class="custom-comment-area" data-cno="' + comment.cno + '" data-bno="' + comment.bno + '" data-pcno="' + comment.pcno + '">';
            tmp += '<div class="custom-commenter" contenteditable="false">' + '&nbsp;&nbsp;' + comment.commenter + '</div>';
            tmp += '<div class="custom-comment-content" >' + comment.comment + '</div>';
            tmp += '<div class="custom-comment-bottom">';
            tmp += '<span class="up_date">' + formattedDate + '&nbsp;' + '</span>';
            tmp += '<button class="btn-write" style="background: none; border: none; color: black; padding: 5px; cursor: pointer; text-decoration: underline;">Reply</button>' + '&nbsp;';
            tmp += '<button class="btn-modify" style="background: none; border: none; color: black; padding: 5px; cursor: pointer; text-decoration: underline;">Edit</button>' + '&nbsp;';
            tmp += '<button class="btn-delete" style="background: none; border: none; color: black; padding: 5px; cursor: pointer; text-decoration: underline;">Delete</button>';
            tmp += '</div>';
            tmp += '</div>';
            tmp += '</div>';
        });

        return tmp;
    }

</script>
</body>
</html>