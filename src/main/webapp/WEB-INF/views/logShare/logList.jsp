<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/logShare/logList.css" type="text/css">
<!-- ===================================== CSS ================================================================== -->
<style>
/* ===== 태그 ===== */
.tags{
	border-radius: 5px;
	padding: 5px;
	font-size:11px;
}
/* ===== 태그 색상(변경해야됨!) ===== */
#tag1, #tag2{
	background-color: rgba(42, 76, 211, 30%);
}
#tag3, #tag4, #tag5, #tag6, #tag7{
	background-color: rgba(166, 198, 252, 50%);
}
#tag8, #tag9, #tag10, #tag11, #tag12, #tag13, #tag14{
	background-color: rgba(122, 140, 226, 30%);
}
#tag15, #tag16, #tag17, #tag18, #tag19, #tag20{
	background-color: rgba(195, 226, 221, 50%);
}
#tag21, #tag22, #tag23, #tag24, #tag25{
	background-color: #FEF5D4;
}
#tag26, #tag27, #tag28, #tag29{
	background-color: rgba(234, 202, 203, 50%);
}
</style>
<!--====================================== HTML ===================================================================-->
<div id="logListContainer">
<!-- 검색 -->
<section id="logListTop">
<div id="btnArea">
<button class="logListBtn" id='view_new'>New</button>&nbsp;
<button class="logListBtn" id='view_like'>Like</button>
</div>
<div id="searchFrm">
	<form action="/logShare/logList/searchs" id="searchFrm">
        <select name="searchKey" id='searchKey'>
            <option value="title">제목</option>
            <option value="tag">태그</option>
            <option value="userNick">작성자</option>
        </select>&nbsp;
        <input type="text" name="searchWord" id="searchWord"/>&nbsp;
        <input class="logListBtn" type="submit" value="검색"/>
        <button class="logListBtn" id='view_all' onclick="location.href='/logShare/logList'">전체 글 보기</button>&nbsp;
    </form>
    
</div>
</section>
<br/>
<br/>
<br/>
<!-- log리스트 -->
<div id='log_list_div'></div>
<!-- 탑으로 가는 버튼 -->
<button class="logListBtn" id='top_btn' onclick='goTop()'><i class="fa-solid fa-angles-up"></i></button>
<!-- 로딩중 이미지 -->
<img src='/img/loading.gif' id='loading' style='height:300px; display:none;'/>



<!-- 상세페이지 -->
<div id='detail_div'></div>
</div>
<script src="/js/logShare/logList.js"></script>