/*작성자: 최은종*/
function getInfoHstryDetail(historyId) {
	console.log("historyId: " + historyId);

	$
			.ajax({
				url : '/history/detail/' + historyId,
				type : 'GET',
				success : function(result) {
					console.log(result);

					var AhstryType = result.hstryType;
					var AhstryStts = result.hstryStts;
					var ArqstrId = result.rqstrId;
					var AhstryId = result.hstryId;
					var auth = result.auth;
					var autuId = result.authId;
					console.log(auth);
					console.log("autuId: "+autuId);
					console.log(AhstryType);
					console.log(AhstryStts);
					console.log(ArqstrId);
					console.log(AhstryId);

					$('.AsrNo').val(result.srNo);
					$('.AinstNm').val(result.instNm);
					$('.AsysNm').val(result.sysNm);
					$('.AdeptNm').val(result.deptNm);
					$('.AwrtYmd').val(result.wrtYmd);
					$('.AcmptnDmndYmd').val(result.cmptnDmndYmd);
					// 이거 + empty 왜 안먹히는지 모르겠음
					if (AhstryType != 'C') {
						$('.AchgEndYmd').val(result.chgEndYmd);
					} else {
						$('.AhstryType1').hide();
						$('.AhstryType2').hide();
					}
					$('.AhstryTtl').val(result.hstryTtl);
					$('.AhstryCn').val(result.hstryCn);

					if (auth == 'ROLE_ADMIN' && AhstryType == 'A') {
						if (ArqstrId != autuId && AhstryStts == 'I') {
							console.log("1");
							$('#HstrySttsDiv2')
									.html(
											'<label class="mr-3"><input id="AHstryStts1" type="radio" name="hstryStts" value="Y">승인</label>'
													+ '<label><input id="AHstryStts2" type="radio" name="hstryStts" value="N">반려</label>'
													+ '<input type="hidden" class="AhstryId" name="hstryId" value="">');
							$('.AhstryId').val(AhstryId);
							$('#footDiv')
									.html(
											'<button type="submit" form="historyDetailForm" formmethod="post" class="btn btn-oti center">등록</button>');

							$(document)
									.ready(
											function() {
												$("input[name='hstryStts']")
														.change(
																function() {
																	var hstatus = $(
																			"input[name='hstryStts']:checked")
																			.val();
																	console
																			.log("~~~~~~~~~~~~~");
																	if (hstatus == 'Y') {
																		$(
																				'.bHstryType')
																				.val(
																						'B');
																	} else if (hstatus == 'N') {
																		$(
																				'.bHstryType')
																				.val(
																						'A');
																	}
																});
											});
						} else if (ArqstrId == autuId && AhstryStts == 'I') {
							console.log("2");
							$('#HstrySttsDiv2')
									.html(
											'<label class="mr-3"><input id="AHstryStts1" type="radio" name="hstryStts" value="Y" onclick="return(false);">승인</label>'
													+ '<label><input id="AHstryStts2" type="radio" name="hstryStts" value="N" onclick="return(false);">반려</label>');
							$('#footDiv').text("결재 권한이 없습니다.");
						} else if (ArqstrId != autuId && AhstryStts == 'Y') {
							console.log("3");
							$('#HstrySttsDiv2')
									.html(
											'<input id="BHstryStts" type="text" value="승인" readonly>');
							$('#footDiv').text("결재 처리 된 요청입니다.");
						} else if (ArqstrId != autuId && AhstryStts == 'N') {
							console.log("4");
							$('#HstrySttsDiv2')
									.html(
											'<input id="CHstryStts" type="text" value="반려" readonly>');
							$('#footDiv').text("결재 처리 된 요청입니다.");
						}
					} else if (auth == 'ROLE_ADMIN' && AhstryType != 'A') {
						console.log(ArqstrId);
						console.log(autuId);
						console.log(auth);
						if (ArqstrId == autuId && AhstryStts == 'I') {
							console.log("5");
							$('.AhstryId').val(AhstryId);
							$('.mheadDiv')
									.html(
											'<input type="button" class="btn btn-oti btn-sm" style="line-height: 8px" value="수정" data-toggle="modal" data-target="#modifyHistoryModal">'
													+ '<input type="hidden" class="AhstryId" name="hstryId" value="">');
							$('#HstrySttsDiv2')
									.html(
											'<label class="mr-3"><input id="AHstryStts1" type="radio" name="hstryStts" value="Y" onclick="return(false);">승인</label>'
													+ '<label><input id="AHstryStts2" type="radio" name="hstryStts" value="N" onclick="return(false);">반려</label>');
							$('#footDiv').text("결재 권한이 없습니다.");
						} else if (AhstryStts == 'Y') {
							console.log("6");
							$('#HstrySttsDiv2')
									.html(
											'<input id="BHstryStts" type="text" value="승인" readonly>');
							$('#footDiv').text("결재 권한이 없습니다.");
						} else if (AhstryStts == 'N') {
							console.log("7");
							$('#HstrySttsDiv2')
									.html(
											'<input id="CHstryStts" type="text" value="반려" readonly>');
							$('#footDiv').text("결재 권한이 없습니다.");
						}
					} else if (auth == 'ROLE_DEVELOPER') {
						console.log("8");
						if (AhstryStts == 'I') {
							console.log("8");
							$('.AhstryId').val(AhstryId);
							$('.mheadDiv')
									.html(
											'<input type="button" class="btn btn-oti btn-sm" style="line-height: 8px" value="수정" data-toggle="modal" data-target="#modifyHistoryModal">'
													+ '<input type="hidden" class="AhstryId" name="hstryId" value="">');
							$('#HstrySttsDiv2')
									.html(
											'<label class="mr-3"><input id="AHstryStts1" type="radio" name="hstryStts" value="Y" onclick="return(false);">승인</label>'
													+ '<label><input id="AHstryStts2" type="radio" name="hstryStts" value="N" onclick="return(false);">반려</label>');
							$('#footDiv').text("결재 권한이 없습니다.");
						} else if (AhstryStts == 'Y') {
							console.log("9");
							$('#HstrySttsDiv2')
									.html(
											'<input id="BHstryStts" type="text" value="승인" readonly>');
							$('#footDiv').text("결재 처리 된 요청입니다.");
						} else if (AhstryStts == 'N') {
							console.log("10");
							$('#HstrySttsDiv2')
									.html(
											'<input id="CHstryStts" type="text" value="반려" readonly>');
							$('#footDiv').text("결재 처리 된 요청입니다.");
						}
					}


				}
			});
}

// 수정 모달 오픈 시 부모 모달 닫히게 설정
$(document).ready(function() {
	$('#modifyHistoryModal').on('show.bs.modal', function() {
		$('#approvalInfoHistoryModal').modal('hide')
	});

});
