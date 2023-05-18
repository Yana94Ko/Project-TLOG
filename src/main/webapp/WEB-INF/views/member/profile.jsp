<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.profileItem{
	padding:0;
}
.profileLink{
	text-align:center;
	color:white;
	background-color:rgba(122, 140, 226, 60%);
	border-top-left-radius:20px !important;
	border-top-right-radius:20px !important;
	font-size:1.1em;
	font-weight:600;
}
</style>
<script src="/js/member/profile.js"></script>
<link rel="stylesheet" href="/css/member/profile.css" type="text/css">
<div id="profileContainer">
	<!-- 프로필 사진, 닉네임, 회원정보 수정 버튼 -->
	<div id="profile">
		<span ><img src="${userProfile.profileImg}" id="profileImg"></span>&emsp;&emsp;&emsp;
		<span id="profileNick">${userProfile.userNick}</span>
		<c:if test="${loginUser.userNum == userProfile.userNum}">
			<input type="button" id="userEditBtn" value="회원정보수정" onclick="location.href='/member/userEdit'">
		</c:if>
		<c:if test="${loginUser.userNum != userProfile.userNum}">
			<input type="hidden" id="loginUser" value="${loginUserNum}"/>
			<input type="hidden" id="isFollowed" value="${isFollowed }"/>
			<input type="hidden" id="selectedUserNum" value="${userProfile.userNum}"/>
			<c:if test="${isFollowed!=0}">
				<input type="button" id="userEditBtn" value="팔로우취소" onclick="unfollow()">
			</c:if>
			<c:if test="${isFollowed==0}">
				<input type="button" id="userEditBtn" value="팔로우" onclick="follow()">
			</c:if>
		</c:if>
	</div>
	<!-- 게시물, 팔로워, 팔로우 -->
	<div id="followSection">
		<span >게시물 ${myLogCount}개</span>
		<span class="follow" data-toggle="modal" data-target="#follower">팔로워 ${followerCount}명</span>
		<span class="follow" data-toggle="modal" data-target="#follow">팔로우 ${followCount}명</span>
	</div>
	<!-- 일기 탭, 태그된글, 찜한 글 탭 -->
	<div id="mypageTabSection">
		<ul class="nav nav-tabs" id="tab">
			<li class="nav-item col-sm-4 profileItem" id="tab1"><a class="nav-link active profileLink" data-toggle="tab">여행일기</a></li>		
			<li class="nav-item col-sm-4 profileItem" id="tab2"><a class="nav-link profileLink" data-toggle="tab">태그된 글</a></li>		
			<li class="nav-item col-sm-4 profileItem" id="tab3"><a class="nav-link profileLink" data-toggle="tab">좋아요 누른 글</a></li>		
		</ul>
	</div>
	<!-- 마이페이지 컨텐츠 -->
	<div id="mypageContent" class="tabcontent">
		<!-- 로딩중 이미지 -->
		<img src='/img/loading.gif' id='loading' style='height:300px; display:none;'/>
		<!-- 일기 탭, 태그된글, 찜한 글 띄울 div 1개로 통일 -->
		<div id="log_list_div"></div>
	</div>
</div>
<!-- 팔로워 모달 -->
<div class="modal" id="follower">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">팔로워</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
	      <ul id="followerList">
	      	<c:forEach var="vo" items="${followerList }">
				<a href="/member/profile?userNum=${vo.userNum}">
					<li>
						<span ><img src="${vo.profileImg}" id="followerImg"></span>&emsp;
						<span id="followerNick">${vo.userNick }</span>
					</li>
				</a>
	      	</c:forEach>
	      </ul>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn" id="followerBtn" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 팔로우 모달 -->
<div class="modal" id="follow">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">팔로우</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
          <ul id="followerList">
              <c:forEach var="vo" items="${followList}">
				  <a href="/member/profile?userNum=${vo.userNum}">
					  <li>
						  <span ><img src="${vo.profileImg}" id="followImg"></span>&emsp;
						<span id="followNick">${vo.userNick }</span>
					  </li>
				  </a>
           </c:forEach>
          </ul>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn" id="followerBtn" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>