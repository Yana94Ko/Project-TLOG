<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    var index = 1;
    // 페이지 번호
    var link_page = document.getElementsByClassName("link_page");

    $(function () {
        // 캐러셀
        const leftBtn = document.querySelector('#leftBtn');
        const rightBtn = document.querySelector('#rightBtn');
        const carousel = document.querySelector('.list_slide');
        link_page[1].classList.add("clicked");
        leftBtn.addEventListener('click', () => {
            console.log("왼쪽 클릭",index);
            if (index !== 0) {
                link_page[index].classList.remove("clicked");
                link_page[--index].classList.add("clicked");
                //console.log("왼쪽 클릭 index", index);
            } else {
                link_page[index].classList.remove("clicked");
                index = ${cntLogListPage} -1;
                link_page[index].classList.add("clicked");
            }
            carousel.style.transform = 'translate(' + (-70 * index) + 'vw, 0)';
            carousel.style.transitionDuration = '500ms';
        });
        rightBtn.addEventListener('click', () => {
            console.log("오른쪽 클릭",index);
            if (index !== ${cntLogListPage} -1) {
                link_page[index].classList.remove("clicked");
                link_page[++index].classList.add("clicked");
                //console.log("오른쪽 클릭 index", index);
            } else {
                link_page[index].classList.remove("clicked");
                index = 0;
                link_page[index].classList.add("clicked");
            }
            carousel.style.transform = 'translate(' + (-70 * index) + 'vw, 0)';
            carousel.style.transitionDuration = '500ms';
        });
        init();
    });

    function handleClick(event) {
        //console.log(event.target);
        //console.log("ㄹㄹㄹㄹㄹㄹㄹ");
        // 콘솔창을 보면 둘다 동일한 값이 나온다
        //console.log(event.target.classList[1].substr(8, 8));
        const carousel = document.querySelector('.list_slide');
        if (event.target.classList[1] === "clicked") {
            event.target.classList.remove("clicked");
            //console.log("바뀌냐..?");
        } else {
            for (var i = 0; i < link_page.length; i++) {
                link_page[i].classList.remove("clicked");
            }
            //console.log("클릭");
            event.target.classList.add("clicked");
            index = event.target.classList[1].substr(8, 8) - 1;
            carousel.style.transform = 'translate(' + (-960 * index) + 'px, 0)';
        }
    }

    function init() {
        for (var i = 0; i < link_page.length; i++) {
            link_page[i].addEventListener("click", handleClick);
            //console.log("클릭클릭");
        }
    }
</script>
<!-- ============================ HTML ========================================================================== -->
<div class="introduce_wrap">
    <div class="introduce_b">
        <div class="introduce_img">
            <img src="/img/home/09.gif">
        </div>
        <div class="introduce_info">
            <h3>&#128747;기억하고 싶은 여행&#128747;</h3>
            <p>당신의 여행을 기록해보세요</p>
            <a href="/logShare/logWrite" class="main-write">
                <button type="button" class="btn btn-outline-light" )>기록하기</button>
            </a>
        </div>
        <div class="introduce_bg"></div>
        <i class="bi bi-chevron-compact-down"></i>
    </div>
</div>
<div class="homeContainer">
    <!-- 본문 내용 작성하기 -->
    <!-- 로그인 안했을때 좋아요 많은글, 로그인했을때 팔로워 최신글 -->
    <div class="editor_pic">
        <h3 class="txt_tlog txt_title">T L O G &nbsp; P O S T</h3>
        <p class="txt_desc">
            <c:if test="${userInfo.userNum == null}">
                <span class="txt_tlog">좋아요가 많은 글을 확인해보세요!</span>
            </c:if>
            <c:if test="${userInfo.userNum != null }">
                <span class="txt_tlog">팔로워 최신 글을 확인해보세요!</span>
            </c:if>
        </p>
        <div class="wrap_slide">
            <c:if test="${logList}.size()==0">
                <div class="not_follower">
                    <div class="not_follower_wrap">
                        <i class="bi bi-patch-exclamation" style="font-size:60px;"></i>
                        <p>팔로워 최신글이 아직 없습니다!</p>
                    </div>
                </div>
            </c:if>
            <c:forEach items="${logList}" var="vo" varStatus="status">
                <!--<c:out value="${status.index}"/> /<c:out value="${status.end}"/>-->
                <c:if test="${status.index == 0 }">
                    <ul class="list_slide">
                    <li class="testClass">
                    <div class="wrap_pic wrap_pic_type1">
                    <div class="item_pic item_pic_type1"
                         onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                        ${vo.userNick}
                                    </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 1 }">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                        ${vo.userNick}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 2 }">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                        ${vo.userNick}
                                </span>
                            </div>
                        </div>
                    </div>
                    </div>
                    </li>
                </c:if>
                <c:if test="${status.index == 3 }">
                    <li class="testClass">
                    <div class="wrap_pic wrap_pic_type2">
                    <div class="item_pic item_pic_type1" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                        ${vo.userNick}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 4 }">
                    <div class="item_pic item_pic_type1" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                    ${vo.userNick}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 5 }">
                    <div class="item_pic item_pic_type1" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                    ${vo.userNick}
                                </span>
                            </div>
                        </div>
                    </div>
                    </div>
                    </li>
                </c:if>
                <c:if test="${status.index == 6 }">
                    <li class="testClass">
                    <div class="wrap_pic wrap_pic_type3">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                    ${vo.userNick}
                                </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 7 }">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                            <span class="ico_by">by</span>
                            ${vo.userNick}
                        </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 8 }">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                            <span class="ico_by">by</span>
                            ${vo.userNick}
                        </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 9 }">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                            <span class="ico_by">by</span>
                            ${vo.userNick}
                        </span>
                            </div>
                        </div>
                    </div>
                    </div>
                    </li>
                </c:if>
                <c:if test="${status.index == 10 }">
                    <li class="testClass">
                    <div class="wrap_pic wrap_pic_type1">
                    <div class="item_pic item_pic_type1" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                <span class="ico_by">by</span>
                                ${vo.userNick}
                            </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 11 }">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                        <span class="ico_by">by</span>
                        ${vo.userNick}
                    </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 12 }">
                    <div class="item_pic item_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                        <span class="ico_by">by</span>
                        ${vo.userNick}
                    </span>
                            </div>
                        </div>
                    </div>
                    </div>
                    </li>
                </c:if>
                <c:if test="${status.index == 13 }">
                    <li class="testClass">
                    <div class="wrap_pic wrap_pic_type2" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                    <div class="item_pic item_pic_type1">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                <span class="ico_by">by</span>
                                ${vo.userNick}
                            </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 14 }">
                    <div class="item_pic item_pic_type1" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                        <span class="ico_by">by</span>
                        ${vo.userNick}
                    </span>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${status.index == 15 }">
                    <div class="item_pic item_pic_type1" onclick="window.open('/logShare/logView?tNum=${vo.tNum}')">
                        <div class="link_item">
                            <img src="/upload/log/${vo.coverImg}">
                            <div class="link_item_g">
                            </div>
                        </div>
                        <a href="location.href='/member/profile?userNum=${vo.userNum}'"></a>
                        <div class="append_info">
                            <div class="info_g">
                                <strong class="info_tit">
                                        ${vo.tTitle}
                                </strong>
                                <span class="info_by">
                                    <span class="ico_by">by</span>
                                    ${vo.userNick}
                                </span>
                            </div>
                        </div>
                    </div>
                    </div>
                    </li>
                    </ul>
                </c:if>
            </c:forEach>
        </div>
    <div class="wrap_btn">
        <!-- <i class="fa-solid fa-chevron-left" style="font-size: 100px; "></i>
                <a href="/"><i class="fa-solid fa-chevron-right" style="font-size: 50px; color:white;"></i></a>-->
        <button class="slide_btn btn_left" id="leftBtn"><i class="bi bi-arrow-left-circle-fill"
                                                           style="font-size: 65px; "></i></button>
        <button class="slide_btn btn_right" id="rightBtn"><i class="bi bi-arrow-right-circle-fill"
                                                             style="font-size: 65px;"></i></button>
    </div>
    <div class="wrap_paging">
        <ul class="paging_list">
            <!-- [Yana] 로드되는 게시글에 맞춰 페이징 항목 나타나도록 설정-->
            <c:forEach var="pgNum" begin="1" end="${cntLogListPage}" step="1">
                <li><a href="javascript:;" class="link_page txt_page${pgNum}" data-page="${pgNum}">0${pgNum}</a></li>
            </c:forEach>
        </ul>
    </div>
    <!-- 팔로워 많은 유저 리스트 -->
    <div class="best_follow">
        <h3 class="txt_tlog txt_title">B E S T &nbsp; F O L L O W E R</h3>
        <p class="txt_desc">
            <span class="txt_tlog">인기있는 유저에게 팔로우해보세요!</span>
        </p>
        <div class="wrap_follow">
            <c:forEach var="vo" items="${followedUser}">
                <ul class="list_wirters list_writers_group">
                    <li>
                        <div onclick="location.href='/member/profile?userNum=${vo.userNum}'" class="link_follow">
                            <img src='${vo.profileImg}' width="80" height="80" class="img_witer">
                            <strong class="tit_wirter">${vo.userNick}</strong>
                        </div>
                        <p class="follow_count"><i class="bi bi-person-heart"
                                                   style="font-size:15px;"></i>&nbsp;${vo.followerNum}</p>
                        <div class="follow_tag_wrap">
                            <c:forEach var="t" items="${vo.tagList}" end="2">
                                <!-- 태그3개(임시)-->
                                <span class='tags' id='tag${t.tagNum}'
                                      onclick="location.href='/logShare/logList/searchs?searchKey=tag&searchWord=${t.tagName}'">
                                        ${t.tagName}
                                </span>&nbsp;
                            </c:forEach>
                        </div>
                    </li>
                </ul>
            </c:forEach>
        </div>
    </div>
    <!-- 태그 리스트 -->
    <div class="tag_wrap">
        <h3 class="txt_tlog txt_title">T L O G &nbsp; K E Y W O R D</h3>
        <p class="txt_desc">
            <span class="txt_tlog">태그로 분류된 다양한 글 모음</span>
        </p>
        <ul class="tag_list">
            <c:forEach var="t" items="${tagList}">
                <li class="tag_item" id='tag${t.tagNum}'
                    onclick="location.href='/logShare/logList/searchs?searchKey=tag&searchWord=${t.tagName}'">
                    <p>${t.tagName}</p>
                </li>
            </c:forEach>
            <li class="tag_item_end"></li>
        </ul>
    </div>
</div>
</div>