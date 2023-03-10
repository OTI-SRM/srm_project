<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- 작성자 : 여수한 / 작성 날짜 : 2023-02-17 --%>

<html>
<head>
<%@include file="/WEB-INF/views/fragments/header.jsp"%>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/srDemandList.js"></script>

<script>
	</head>
	<script>
<%-- 모달 실행 --%>
	$(document).on('click', '#addbtn', function(e) {
		console.log("click event");
		$('#addmodal').addClass('show');
		document.body.style = `overflow: hidden`;
	});
	$(document).on('click', '#closebtn', function(e) {
		console.log("click event");
		$('#addmodal').removeClass('show');
		document.body.style = `overflow: scroll`;
	});
</script>
<style>
#startDatepicker, #endDatepicker, #addDatepicker {
	width: 90px;
}

#requestDatepicker, #endRequestDatepicker, #firStartDatepicker,
	#firEndDatepicker, #secStartDatepicker, #secEndDatepicker,
	#thrStartDatepicker, #thrEndDatepicker, #fiveStartDatepicker,
	#fiveEndDatepicker, #fourStartDatepicker, #fourEndDatepicker,
	#sixStartDatepicker, #sixEndDatepicker, #startDatepicker,
	#endDatepicker {
	width: 70px;
	padding-right: 0px;
}

div.left {
	width: 65%;
	float: left;
	box-sizing: border-box;
}

div.right {
	width: 35%;
	float: right;
	box-sizing: border-box;
	border-left: 1px solid black;
}

div .right .form-control {
	height: 20px;
}

th {
	text-align: center;
}

.col-sm-4 {
	padding: 0px;
}
/* 
.table td, .table th {
	padding: 0.75rem;
} */
.card .card-block {
	padding: 0px 5px !important;
}

.col-xl-1 {
	padding-top: 8px;
	padding-right: 0px;
	padding-left: 10px;
}

.modal {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background: rgba(0, 0, 0, 0.4);
}

.m.body {
	height: 50vh;
	overflow-y: auto;
}

#srDemandDetail {
	font-size: 12px;
	padding-left: 0px;
}

#card_body, .form-control {
	font-size: 12px;
}
</style>
<body>
	<%@include file="/WEB-INF/views/fragments/top.jsp"%>
	<%@include file="/WEB-INF/views/fragments/sidebar.jsp"%>
	<!-- Page-body start -->
	<div class="page-body text">
		<div class="row">
			<%-- *********************************** [SR 요청 관리 ] ***********************************--%>
			<div class="col-xl-12">
				<div class="card">
					<div class="card-header">
						<div class="row">
							<div class="col-10">
								<h5>SR 요청 관리</h5>
							</div>
						</div>
						<hr />
						<form id="srSearchForm">
							<div class="row">
								<div class="col col-3 pr-0">
									<label for="dmndYmdStart" style="margin-right: 10px;">조회
										기간</label> <input type="date" name="dmndYmdStart" id="dmndYmdStart">
									~ <input type="date" name="dmndYmdEnd" id="dmndYmdEnd">
								</div>
								<div class="col col-2 pr-0">
									<label for="sttsCd" style="margin-right: 10px;">진행 상태</label> <select
										id="sttsCd" name="sttsCd">
										<option value="0">요청</option>
										<option value="1">반려</option>
									</select>
								</div>
								<div class="col col-3 px-0">
									<label for="sysCd" style="margin-right: 10px;">관련 시스템</label> <select
										id="sysCd" name="sysCd">
										<option value="0">워크넷</option>
										<option value="1">고용정보원</option>
									</select> <select id="taskSeCd" name="taskSeCd">
										<option value="0">내부망</option>
										<option value="1">외부망</option>
									</select>
								</div>
								<div class="col col-4 px-0">
									<label for="keyWord" style="margin-right: 10px;">키워드</label> <input
										type="text" name="keyWord" id="keyWord">
									<button type="submit" class="btn btn-sm btn-oti"
										style="margin-right: 10px; height: 30px;">
										<i class="ti-search"></i>
									</button>
									<button class="btn btn-sm btn-oti" style="height: 30px;">엑셀
										다운로드</button>
								</div>

							</div>
						</form>
					</div>
				</div>
			</div>

			<%-- *********************************** [SR 요청 목록 ] ***********************************--%>
			<div class="col-xl-8 col-md-12">
				<div class="card">
					<div class="card-header">
						<h5>관리자 !!SR 요청 목록</h5>
						<div class="card-header-right">
							<ul class="list-unstyled card-option">
								<li><i class="fa fa fa-wrench open-card-option"></i></li>
								<li><i class="fa fa-window-maximize full-card"></i></li>
								<li><i class="fa fa-minus minimize-card"></i></li>
								<li><i class="fa fa-refresh reload-card"></i></li>
								<li><i class="fa fa-trash close-card"></i></li>
							</ul>
						</div>
					</div>
					<div class="card-block" id="list">
						<div id="sales-analytics">
							<div class="card-block table-border-style">
								<div class="table-responsive">
									<table class="table table-hover text-center"
										style="font-size: 12;">
										<thead>
											<tr>
												<th style="width: 1px;"></th>
												<th>요청 번호 <a
													href="${pageContext.request.contextPath}/admin/srdemand/list?sort=ASC"><i
														class="ti-arrow-up" style="color: black;"></i></a> <a
													href="${pageContext.request.contextPath}/admin/srdemand/list?sort=DESC"><i
														class="ti-arrow-down" style="color: black;"></i></a>
												</th>
												<th>제목</th>
												<th>관련시스템</th>
												<th style="width: 200px;">등록자</th>
												<th>소속</th>
												<th>진행상태</th>
												<th>등록일</th>
												<th>완료예정일</th>
											</tr>

										</thead>
										<tbody>
											<c:forEach var="srDemand" items="${srDemandList}"
												varStatus="status">
												<tr onclick="getSrDemandDetail('${srDemand.dmndNo}')">
													<th scope="row">${pager.startRowNo + status.index}</th>
													<td>${srDemand.dmndNo}</td>
													<c:choose>
														<c:when test="${fn:length(srDemand.ttl) > 10}">
															<td id="ttl" class="text-center"><c:out
																	value="${fn:substring(srDemand.ttl,0,9)}" />...</td>
														</c:when>
														<c:otherwise>
															<td id="ttl" class="text-center"><c:out
																	value="${srDemand.ttl}" /></td>
														</c:otherwise>
													</c:choose>
													<td>${srDemand.sysNm}</td>
													<td>${srDemand.custNm}</td>
													<td>${srDemand.instNm}</td>
													<td><c:if test="${(srDemand.sttsNm) eq '요청'}">
															<label class="badge badge-warning">${srDemand.sttsNm}</label>
														</c:if> <c:if test="${(srDemand.sttsNm) eq '반려'}">
															<label class="badge badge-danger">${srDemand.sttsNm}</label>
														</c:if> <c:if test="${(srDemand.sttsNm) eq '접수'}">
															<label class="badge badge-inverse-success">${srDemand.sttsNm}</label>
														</c:if> <c:if test="${(srDemand.sttsNm) eq '개발중'}">
															<label class="badge badge-success">${srDemand.sttsNm}</label>
														</c:if> <c:if test="${(srDemand.sttsNm) eq '개발완료'}">
															<label class="badge badge-primary">${srDemand.sttsNm}</label>
														</c:if> <c:if test="${(srDemand.sttsNm) eq '개발취소'}">
															<label class="badge badge-danger">${srDemand.sttsNm}</label>
														</c:if> <c:if test="${(srDemand.sttsNm) eq '테스트'}">
															<label class="badge badge-inverse-primary">${srDemand.sttsNm}</label>
														</c:if></td>
													<td>${srDemand.dmndYmd}</td>
													<td>${srDemand.endYmd}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!-- 페이징 처리 -->
									<div class="d-flex justify-content-center">
										<%@ include file="/WEB-INF/views/fragments/pagination.jsp"%>
									</div>

								</div>
							</div>

						</div>
					</div>
				</div>
			</div>

			<%-- *********************************** [SR요청 처리정보 ] ***********************************--%>
			<div class="col-xl-4 col-md-12">
				<div class="card">
					<div class="card-header">
						<h5>SR요청 상세</h5>
						<div class="card-header-right">
							<ul class="list-unstyled card-option">
								<li><i class="fa fa fa-wrench open-card-option"></i></li>
								<li><i class="fa fa-window-maximize full-card"></i></li>
								<li><i class="fa fa-minus minimize-card"></i></li>
								<li><i class="fa fa-refresh reload-card"></i></li>
								<li><i class="fa fa-trash close-card"></i></li>
							</ul>
						</div>
					</div>
					<ul class="nav nav-tabs  md-tabs" role="tablist">
						<li class="nav-item"><a class="nav-link active"
							data-toggle="tab" href="#srDemandDetail" role="tab">SR요청 상세정보</a>
							<div class="slide"></div></li>

					</ul>
					<div class="tab-content tabs card-block"
						style="padding: 0px; padding-top: 20px;">
						<div class="tab-pane active" id="srDemandDetail" role="tabpanel">
							<div class="card-block">
								<jsp:include page="/WEB-INF/views/srDemand/admin/adSrDetail.jsp" />
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- *********** -->
	</div>
	<!-- Page-body end -->
	<%@include file="/WEB-INF/views/fragments/bottom.jsp"%>

	<%-- 상세, 등록, 수정 --%>
	<script
		src="${pageContext.request.contextPath}/resources/js/srDemand.js"></script>
	<!-- 모달 -->
	<jsp:include page="/WEB-INF/views/srDemand/srDemandDetail.jsp" />
	<jsp:include page="/WEB-INF/views/srDemand/modal.jsp" />
</body>
</html>