<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- paging 처리 함수 --%>
<div class="pagination-container">
	<div class="pagination">
		<c:if test="${nPager.startPageNo -1 > 0 }">
			<a class="pagination-newer" href="#" onclick="getNextNoticeList(${nPager.startPageNo - 1})">PREV</a>
		</c:if>
		<c:if test="${nPager.startPageNo -1 <= 0 }">
			<a style="visibility: hidden" class="pagination-newer" href="#">PREV</a>
		</c:if>
		<span class="pagination-inner"> <c:forEach var="num"
				begin="${nPager.startPageNo}" end="${nPager.endPageNo}" step="1">
				<c:if test="${nPager.pageNo == num }">
					<a class="pagination-active"  href="#" onclick="getNextNoticeList(${num})">${num}</a>
				</c:if>
				<c:if test="${nPager.pageNo != num }">
					<a href="#" onclick="getNextNoticeList(${num})">${num}</a>
				</c:if>
			</c:forEach>
		</span>
		<c:if test="${nPager.endPageNo < nPager.totalPageNo }">
			<a class="pagination-older"  href="#" onclick="getNextNoticeList(${nPager.endPageNo + 1})">NEXT</a>
		</c:if>
		<c:if test="${nPager.endPageNo >= nPager.totalPageNo }">
			<a style="visibility: hidden" class="pagination-older" href="#">NEXT</a>
		</c:if>
	</div>
</div>
