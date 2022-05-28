<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
//클릭이벤트: 일기 상세 리스트
function logDetail(tNum){
	var param={"tNum" : tNum};	
	$.ajax({
		data:param,
		url:'/home/logDetail',
		type:'GET',
		success:function(data){
			var tag="";
			for(var i=0; i<data.length; i++){
				tag += "<ul><li>"+data[i].tDetailNum+"</li>";
				tag += "<li>"+data[i].tNum+"</li>";
				tag += "<li>"+data[i].tImg+"</li>";
				tag += "<li>"+data[i].tContent+"</li>";
				tag += "<li>"+data[i].tPlace+"</li>";
				tag += "<li>"+data[i].isCoverImg+"</li></ul>";
			}
			$("#detail_div").html(tag);
		}
	})
}
</script>
	<div class="container">
		<!-- 본문 내용 작성하기 -->
		홈페이지
		<div id='detail_div'>
			글 내용 div(임시)
		</div>
		=========================================================
		<!-- 로그인 안했을때 좋아요많은글, 로그인했을때 팔로워 최신글 -->
		<div>
			<c:forEach var="vo" items="${logList}">
				<ul id='log_ul' onclick="logDetail(${vo.tNum})">
					<li>${vo.coverImg}</li>
					<li>${vo.tTitle}</li>
					<li>${vo.startDate}</li>
					<li>${vo.endDate}</li>
					<li>${vo.likeNum}</li>
					<li>${vo.profileImg}</li>
					<li>${vo.userNick}</li>
					<li>
						<c:forEach var="tag" items="${vo.tagList}">
							${tag}&nbsp;
						</c:forEach>
					</li>
				</ul>
			</c:forEach>
		</div>
		=========================================================
		<!-- 팔로워 많은 유저 리스트 -->
		<div>
			<c:forEach var="vo" items="${followedUser}">
				<ul>
					<li>${vo.userNum}</li>
					<li>${vo.profileImg}</li>
					<li>${vo.userNick}</li>
					<li>${vo.followerNum}</li>
					<li>
						<c:forEach var="tag" items="${vo.tagList}" end="2"><!-- 태그3개(임시) -->
							${tag}&nbsp;
						</c:forEach>
					</li>
				</ul>
			</c:forEach>
		</div>
		
	</div>
