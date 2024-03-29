package com.oti.team2.progress.service;

import java.text.ParseException;
import java.util.List;

import com.oti.team2.progress.dto.Prgrs;
import com.oti.team2.progress.dto.PrgrsPlanDto;
import com.oti.team2.progress.dto.Progress;

public interface IProgressService {
	/**
	 * 
	 * @author 여수한
	 * 작성일자 : 2023-02-23
	 * @return sr요청 진척률 조회
	 */
	List<Progress> getProgress(String srNo);
	
	/**
	 * 
	 * @author 여수한
	 * 작성일자 : 2023-02-28
	 * @param prgrsSeNm2 
	 * @param dmndNo 
	 * @param rcvrId 
	 * @return sr요청 진척률 수정
	 */
	void updateProgress(int prgrsRt, String bgngYmd, String endYmd, int prgrsId, String srNo, String prgrsSeNm, String dmndNo, String rcvrId);

	/**
	 * 진척데이터 삽입
	 * @author 신정은
	 */
	void addProgress(String srNo, List<String> pNames);
	/**
	 * 반영요청 진척률 조회
	 * @author 여수한
	 */
	String getPrgrsRt(String dmNo);
	/**
	 * 고객이 반영요청 수락하면 운영반영 넣기
	 * @author 여수한
	 */
	void endProgress(String dmNo);
	/**
	 * 진척목록의 진척률 조회
	 * @author 여수한
	 */
	List<Prgrs> getRrgrs();
	
	/**
	 * [나의할일] 해당 진척의 계획과 현재 진척률 그래프로 표현하기
	 * @author 신정은
	 * @throws ParseException 
	 */
	PrgrsPlanDto showPrgrsChart(String srNo) throws ParseException;
}
