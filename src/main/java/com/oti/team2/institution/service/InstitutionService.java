package com.oti.team2.institution.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.team2.institution.dao.IInstitutionDao;
import com.oti.team2.institution.dto.Institution;

import lombok.extern.log4j.Log4j2;
@Service
@Log4j2
public class InstitutionService implements IInstitutionService{

	@Autowired
	IInstitutionDao institutionDao;
	
	/** 
	 * 기관 정보 조회
	 * @author 신정은
	 * @return
	 */
	@Override
	public Institution getInstitution(String instCd) {
		return institutionDao.selectByInstCd(instCd);
	}
	
	/**
	 * 내 기관 관리(조회
	 * @author 여수한
	 * @param session
	 * @param model
	 * @return
	 */
	@Override
	public Institution getInst(String memberId) {
		log.info(memberId);
		return institutionDao.selectByInst(memberId);		
	}
	/**
	 * 내 기관 등록
	 * @author 여수한
	 * @param session
	 * @param model
	 * @return
	 */
	@Override
	public void addInst(Institution institution) {
		log.info("서비스 들어옴");
		int row = institutionDao.insertByInst(institution);
		log.info(row);
	}

	/**
	 * 내 기관 수정
	 * @author 여수한
	 * @param session
	 * @param model
	 * @return
	 */
	@Override
	public void updateInst(Institution institution) {
		institutionDao.updateByInst(institution);
	}
	/**
	 * 내 기관 수정
	 * @author 여수한
	 * @return 회원가입 - 모든 기관 목록 조회
	 */
	@Override
	public List<Institution> getAllInst() {
		List<Institution> instList = institutionDao.selectAllInst();
		return instList;
	}
}
