<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script src="${pageContext.request.contextPath}/resources/js/srDemand.js"></script>
<div class="card_body" style="font-size: 12px; padding-top: 20px;">
	<div class="form-group row">
		<div class="col col-sm-2 font-weight-bold  px-0">SR번호</div>
		<div class="col col-sm-9">
			<div class="form-control dmndNo"
				style="font-size: 12px; width: 325px;">${sd.dmndNo}</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col col-sm-2 font-weight-bold px-0">SR 제목</div>
		<div class="col col-sm-9">
			<div type="text" class="form-control ttl" style="width: 325px;">${sd.ttl}</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-2 font-weight-bold px-0">관련 근거</div>
		<div class="col-sm-9">
			<div type="text" class="form-control relGrund" style="width: 325px;">${sd.relGrund}</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">시스템구분</div>
			<div class="col col-sm-6 sysNm">${sd.sysNm}</div>
		</div>
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">업무구분</div>
			<div class="col col-sm-8 taskSeNm">${sd.taskSeNm}</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">요청기관</div>
			<div class="col col-sm-6 instNm">${sd.instNm}</div>
		</div>
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">요청자</div>
			<div class="col col-sm-6 dropdown dropdown open clientNm">${sd.clientNm}</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">요청일</div>
			<div class="col col-sm-8 dmndYmd">${sd.dmndYmd}</div>
		</div>
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">완료요청일</div>
			<div class="col col-sm-8 cmptnDmndYmd">${sd.cmptnDmndYmd}</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">개발 담당자</div>
			<div class="col col-sm-6">
				<div type="text" class="form-control picNm">${sd.picNm}</div>
			</div>
		</div>
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold px-0">개발 부서</div>
			<div class="col col-sm-8">
				<div type="text" class="form-control deptNm" style="width: 90%;">${sd.deptNm}</div>
			</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">진행 상태</div>
			<div class="col col-sm-6">
				<div type="text" class="form-control sttsNm">${sd.sttsNm}</div>
			</div>
		</div>
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">완료(예정)일</div>
			<div class="col col-sm-6 endYmd">${sd.endYmd}</div>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-6 px-0">
			<div class="col col-sm-4 font-weight-bold">검토자 이름</div>
			<div class="col col-sm-6">
				<div type="text" class="form-control rvwrNm">${sd.rvwrNm}</div>
			</div>
		</div>
	</div>
	<c:if test="${sd.sttsCd == 1}">
		<div class="form-group row">
			<label id="companion"
				class="col-sm-2 col-form-label px-0 font-weight-bold"
				style="line-height: 100px; font-size: 12px;">반려사유</label>
			<div class="col-sm-9">
				<input class="form-control rjctRsn"
					style="height: 100px; width: 325px;" value="${sd.rjctRsn}"></input>
			</div>
		</div>
	</c:if>
	<div class="form-group row">
		<label class="col-sm-2 col-form-label px-0 font-weight-bold"
			style="line-height: 100px; font-size: 12px;">SR 내용</label>
		<div class="col-sm-9">
			<input class="form-control cn" style="height: 100px; width: 325px;"
				value="${sd.cn}" readonly></input>
		</div>
	</div>
	<div class="form-group row">
		<p class="col-sm-2 font-weight-bold">첨부파일</p>
		<div class="col-sm-5">
			<c:forEach var="f" items="${sd.attachFile}">
				<div>
					<a href="<c:url value='/file/download/${f.fileSn}' />"> <span
						class="glyphicon glyphicon-save" aria-hidden="true"></span> <span>
							${f.orgnlFileNm} </span>
					</a> <span> Size : ${f.fileSz} Bytes</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="row" id="userButtonDiv">
		<c:if test="${sd.sttsCd == 0}">
			<div class="col" style="text-align: right">
				<button id="modbtn" style="float: right;"
					class="btn btn-sm btn-oti center" onclick="updateSr('${sd.dmndNo}')">수정</button>
				<div class="btn btn-sm btn-oti btn-round danger cancle"
					style="float: right; margin-right: 5px;" onclick="deleteSr('${sd.dmndNo}')">삭제</div>
			</div>
		</c:if>
		<c:if test="${sd.sttsCd > 1 && sd.sttsCd < 5 && prgrsRt eq '90'}">
			<div class="col" style="text-align: right">
				<div class='btn btn-sm btn-oti cancle' onclick='endSr()' style='float:right;'>반영요청</div> 
			</div>
		</c:if>
	</div>
</div>