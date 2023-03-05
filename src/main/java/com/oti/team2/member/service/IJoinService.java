package com.oti.team2.member.service;

import com.oti.team2.member.dto.Join;

public interface IJoinService {
	/**
	 * 
	 * @author 여수한
	 * 작성일자 : 2023-03-01
	 * @return join
	 */
	void getJoin(Join join);
	/**
	 * 
	 * @author 여수한
	 * 작성일자 : 2023-03-02
	 * @return ID 중복확인
	 */
	Integer checkId(String memberId);

}