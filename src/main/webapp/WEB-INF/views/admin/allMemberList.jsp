<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- Custom fonts for this template-->
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">
<link href="/admintemplate/css/sb-admin-2.min.css" rel="stylesheet"/>
<link href="/css/admin/main.css" rel="stylesheet"/>
<script src="/js/admin/allMemberList.js"></script>


<div id="page-top"><!-- end div tag xx -->
	<!-- Page Wrapper -->
	<div id="wrapper"><!-- end div tag xx -->
	    <!-- Sidebar -->
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
			<!-- Sidebar T-LOG -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
			    <span class="sidebar-brand-icon rotate-n-15">
			        <i class="fas fa-laugh-wink"></i>
			    </span>
			    <span class="sidebar-brand-text mx-3">T-LOG</span>
			</a>
			
			<!-- Divider -->
			<div>
				<hr class="sidebar-divider">
				<!-- Heading -->
				<span class="sidebar-heading">게시판 및 멤버</span>
			</div>
		
			<!-- Nav Item 전체 게시판-->
			<li class="nav-item">
			    <a class="nav-link" href="/admin/main">
			        <i class="fas fa-fw fa-cog"></i>
			        <span>전체 게시판</span>
			    </a>
			</li>
		
			<!-- Nav Item 회원 게시판-->
			<li class="nav-item">
			    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
			        aria-expanded="true" aria-controls="collapseUtilities">
			        <i class="fas fa-fw fa-wrench"></i>
			        <span>회원 게시판</span>
			    </a>
			    <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
			        data-parent="#accordionSidebar">
			        <div class="bg-white py-2 collapse-inner rounded">
			            <a class="collapse-item" href="/admin/allMemberList">전체 회원</a>
			        </div>
			    </div>
			</li>
			<!-- Divider -->
		    <hr class="sidebar-divider d-none d-md-block">
		</ul>
		<!-- End of Sidebar -->
	
		<!-- Content Wrapper-->
		<div id="content-wrapper" class="d-flex flex-column"><!-- end div tag xx -->
			<!-- Topbar -->
			<div class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
		
				 <!-- Topbar Navbar -->
				 <ul class="navbar-nav ml-auto">
			     <!-- Nav Item - Search Dropdown (Visible Only XS) -->
					 <li class="nav-item dropdown no-arrow d-sm-none">
					         <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
					             data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					             <i class="fas fa-search fa-fw"></i>
					         </a>
					 </li>
					 <!-- 관리자 이름 옆에 작대기 -->
				     <span class="topbar-divider d-none d-sm-block"></span>
					     <!-- Nav Item - 관리자 이름 -->
					 <li class="nav-item dropdown no-arrow">
				         <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
				             data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				             <span class="mr-2 d-none d-lg-inline text-gray-600 small">${userInfo.userNick}</span>
				         </a>
			         	<!-- Dropdown : logout -->
			            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
			                aria-labelledby="userDropdown">
			                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
			                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
			                    Logout
			                </a>
			            </div>
				     </li>
				 </ul><!-- End of Topbar Navbar -->
			</div>
			<!-- End of Topbar -->
			
			<!-- main page Content -->
			<main class="container-fluid">
				<!-- Page Heading -->
				<div class="d-sm-flex align-items-center justify-content-between mb-4">
					<h1 class="h3 mb-0 text-gray-800">전체 회원</h1>
				</div>
			
				<!-- Dash board 내용 -->
				<div class="row">
					<!-- 회원 게시판  -->
                    <div class="card shadow mb-4 col-xl-12">
                        <div class="card-body table-responsive">
                        	<br/>
                            <table class="table table-bordered dataTable" id="memberTable">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>닉네임</th>
                                        <th>가입일</th>
                                        <th>여행일기 수</th>
                                        <th>자유일기 수</th>
                                        <th>총 일기 수</th>
                                        <th>관리자 권한 부여 및 회원 정지 </th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach var="m" items="${mList}">
	                                	<tr>
	                                        <td>${m.userNum}</td>
	                                        <td>${m.userNick}</td>
	                                        <td>${m.registerDate}</td>
	                                        <td>${m.tNumCount}</td>
	                                        <td>${m.bCount}</td>
	                                        <td>${m.sum}</td>
	                                        <c:if test="${m.status==0}">
												<td>
	                                        		<input type="button" class="btn delBtn memberEdit" data-toggle="modal" data-target="#editModal"
	                                        		onclick="memberAdmin(${m.userNum})" value="관리자"><hr/>
	                                        		<input type="button" class="btn delBtn memberEdit" data-toggle="modal" data-target="#blockModal"
	                                        		onclick="memberBlock(${m.userNum})" value="회원정지">
	                                        	</td>	                                        
	                                        </c:if>
	                                        <c:if test="${m.status==1}">
	                                        	<td>
	                                        		<span>관리자 입니다.</span><hr/>
	                                        		<input type="button" class="btn delBtn memberEdit" data-toggle="modal" data-target="#editModal"
	                                        		onclick="memberAdmin(${m.userNum})" value="관리자">
	                                        	</td>
	                                        </c:if>
	                                        <c:if test="${m.status==9}">
	                                        	<td>
	                                        		<span>현재 정지된 회원입니다.</span><hr/>
	                                        		<input type="button" class="btn delBtn memberEdit" data-toggle="modal" data-target="#blockModal"
	                                        		onclick="memberBlock(${m.userNum})" value="회원정지">
	                                        	</td>
	                                        </c:if>
                                    	</tr>
                                	</c:forEach>
                                </tbody>
                            </table>
                             <div class="dataTables_info" id="memberTable_info" role="status" aria-live="polite">
						  	 	<ul class="pagination justify-content-center">
						  	 		<c:if test="${paging.currentPage>1}">
						  	 			<li class="page-item page" value="${paging.currentPage-1}">
							  	 			<a class="page-link" href="javascript:void(0);" onclick="move(${paging.currentPage-1})">
							  	 				<i class="fa fa-angle-left"></i>
							  	 			</a>
						  	 			</li>
						  	 		</c:if>
						  	 		<c:forEach var="p" begin="${paging.startPage}" end="${paging.totalPages}">
										<c:if test="${p<=paging.totalPages}">
											<c:choose>
												<c:when test="${p==paging.currentPage}">
													<li class="page-item disabled"><a class="page-link">${p}</a></li>
												</c:when>
												<c:when test="${p!=paging.currentPage}">
													<li class="page-item page"><a class="page-link" href="javascript:void(0);"
														onclick="move(${p})">${p}</a></li>
												</c:when>
											</c:choose>
										</c:if>
									</c:forEach>
									<c:if test="${paging.currentPage<paging.totalPages}">
										<li class="page-item page" value="${paging.currentPage+1}">
							  	 			<a class="page-link" href="javascript:void(0);" onclick="move(${paging.currentPage+1})">
							  	 				<i class="fa fa-angle-right"></i>
							  	 			</a>
						  	 			</li>
						  	 		</c:if>
						  	 	</ul>
						  	 </div>
                        </div><!-- end of 테이블 -->
                    </div><!-- end of 회원 게시판 -->
                    <div id="memberContent" class="col-12">
<!--                     	<div class="card shadow mb-4 col-xl-12">
	                        <div class="card-body table-responsive">
	                    	</div>
                   		</div> -->
                    </div>
                    
                    
				</div><!-- end of row -->
			</main><!-- end of container-fluid -->
		</div><!-- End of content-wrapper(top nav포함) -->
	</div><!-- End of wrapper(side bar포함) -->
</div><!-- End of page-top -->

<%@ include file="/WEB-INF/views/admin/modal.jsp" %>
