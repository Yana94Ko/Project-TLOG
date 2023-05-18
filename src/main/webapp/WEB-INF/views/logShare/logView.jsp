<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src='/js/logShare/logView.js'></script>
<link rel="stylesheet" href="/css/logShare/logView.css" type="text/css">
<div id="demo" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
	<c:forEach var="vo" items="${detailList}" varStatus="status">		
		<li data-target="#demo" data-slide-to="${status.index+1}"></li>
	</c:forEach>
  </ul>

  <!-- The slideshow -->
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img src='/upload/log/${vo.coverImg}' class='imgs'/>
			<div class="carousel-caption">
			<ul>
				<li>
					<div id='titleDiv'>
						<c:if test="${vo.isPrivate==1}">
							<span><i class='fa-solid fa-lock'></i></span>&emsp;
						</c:if>
						<span class='logTitle'>${vo.tTitle}</span>
					</div>
				</li>
				<li class='profileInfo'>
					<span onclick="location.href='/member/profile?userNum=${vo.userNum}'">
					<img src='${vo.profileImg}' class='logProfileImg'/></span>&emsp;
					<span class='logNick' onclick="location.href='/member/profile?userNum=${vo.userNum}'">${vo.userNick}</span>
					<span class='logLike'>
						<c:if test="${vo.likeType==0 && logStatus=='Y'}">
							<i class='fa-regular fa-thumbs-up' onclick='LikeUp(${vo.tNum})' style='color:rgba(122, 140, 226,100%);'></i> &emsp;${vo.likeNum}
						</c:if>
						<c:if test="${vo.likeType==1 && logStatus=='Y'}">
							<i class='fa-solid fa-thumbs-up' onclick='LikeDown(${vo.tNum})' style='color:rgba(122, 140, 226,100%);'></i> &emsp;${vo.likeNum}
						</c:if>				
					</span>
				</li>
				<hr/>
				<c:if test="${vo.tagUserList.size()>0}">
					<li> with &nbsp;&nbsp;&nbsp;
						<c:forEach var='t' items='${vo.tagUserList}'>				
								<span class='users' onclick="location.href='/member/profile?userNum=${t.userNum}'">
									<img src='${t.profileImg}' class='tagProfileImg'/>
									&nbsp;${t.userNick}
								</span>&nbsp;
						</c:forEach>
					</li>
				</c:if>
				<li><span>${vo.startDate}</span>&nbsp;~&nbsp;<span>${vo.endDate}</span></li>
				<li class="logtag_wrap">
					<c:forEach var='t' items='${vo.tagList}'>				
							<span class='tags' id='tag${t.tagNum}' onclick="location.href='/logShare/logList/searchs?searchKey=tag&searchWord=${t.tagName}'">
								${t.tagName}
							</span>&nbsp;
					</c:forEach>
				</li>
				<c:if test="${sessionStorage.getItem('userNum')==vo.userNum}">
					<li class="del_edit_btn">
						<span class='tags' onclick='logEdit(${vo.tNum}, ${vo.userNum})'>수정</span>
						<span class='tags' onclick='logDel(${vo.tNum}), ${vo.userNum}'>삭제</span>
					</li>
				</c:if>
			</ul>
			</div>
	    </div>
    			<c:forEach var='dvo' items='${detailList}'>		
				    <div class="carousel-item">				
				      <img src='/upload/log/${dvo.tImg}' class='imgs'/>
				      <div class="carousel-caption">				
				        <div id='log_list_div'>
							<div class='log_div'>
								<ul class='log_ul'>
									<li>${dvo.tContent}</li>
									<li> - ${dvo.tPlace} 에서 - </li>		
								</ul>
							</div>
						</div>
				      </div>				
				    </div>
				</c:forEach>
  </div>

  <!-- Left and right controls -->
  	<a class="carousel-control-prev" href="#demo" data-slide="prev" style="background-color: #d7d7d7;
    padding: 2px;
    border-radius: 50px;
    width: 50px;
    height: 50px;
    margin-top: 25%;">
  		<span class="carousel-control-prev-icon" ></span>
	</a>
  	<a class="carousel-control-next" href="#demo" data-slide="next" style="background-color: #d7d7d7;
    padding: 2px;
    border-radius: 50px;
    width: 50px;
    height: 50px;
    margin-top: 25%;">
    	<span class="carousel-control-next-icon"></span>
  	</a>
  
  

</div>
<script>
$('.carousel').carousel({
	  interval: false,
	});
</script>


