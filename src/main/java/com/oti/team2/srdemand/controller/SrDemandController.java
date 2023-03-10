package com.oti.team2.srdemand.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.team2.institution.service.IInstitutionService;
import com.oti.team2.member.service.IMemberService;
import com.oti.team2.progress.service.IProgressService;
import com.oti.team2.srdemand.dto.SrDemand;
import com.oti.team2.srdemand.dto.SrFilterDto;
import com.oti.team2.srdemand.dto.SrRequestDto;
import com.oti.team2.srdemand.dto.SrdemandDetail;
import com.oti.team2.srdemand.dto.SrdemandPrgrsrt;
import com.oti.team2.srdemand.dto.WriteSdBaseDto;
import com.oti.team2.srdemand.dto.WriterDto;
import com.oti.team2.srdemand.service.ISrDemandService;
import com.oti.team2.srinformation.service.ISrinformationService;
import com.oti.team2.system.dto.SrSystem;
import com.oti.team2.system.service.ISystemService;
import com.oti.team2.task.dto.SystemTask;
import com.oti.team2.task.service.ITaskService;
import com.oti.team2.util.Auth;
import com.oti.team2.util.pager.Pager;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/srdemand")
public class SrDemandController {

	@Autowired
	private IInstitutionService institutionService;

	@Autowired
	private ISrDemandService srdemandService;

	@Autowired
	private IMemberService memberService;
	
	@Autowired
	private ISystemService systemService;
	
	@Autowired
	private ITaskService taskService;
	
	@Autowired
	private IProgressService progressService;
	
	@Autowired
	private ISrinformationService srinformationService;

	/**
	 * sr?????? ?????? ??? , ???????????? ?????????, ??????, ???????????? ????????? ???????????? ??????
	 * 
	 * @author ?????????
	 * 
	 */
	@ResponseBody
	@GetMapping("/add")
	public WriteSdBaseDto addSrDemand(Authentication auth) {
		log.info("???????????? ??????" + auth.getName());
		// ???????????? ???????????? ????????? ???????????? ???.
		String memberId = auth.getName();
		String flnm = memberService.getFlnm(memberId);
		
		// ????????? ????????? ??? ????????????, ?????? ???????????? ???????????? ???????????? ??????????????? ????????????.
		SrSystem system = systemService.getFirstSystem();
		log.info("system" + system);
		List<SystemTask> taskList = taskService.getTaskList(system.getSysCd());
		log.info("taskList" + taskList);
		
		String instName = institutionService.getInst(memberId).getInstNm();
		WriterDto writerDto = new WriterDto(memberId, flnm, instName);
		WriteSdBaseDto wbDto = new WriteSdBaseDto(writerDto, system, taskList);
		log.info(wbDto);
		return wbDto;
	}

	/**
	 * sr?????? ??????
	 * 
	 * @author ?????????
	 */
	@PostMapping("/add")
	public String postSrDemand(SrRequestDto srRequest) throws IllegalStateException, IOException {
		log.info(srRequest);
		srdemandService.addSrDemand(srRequest);
		return "redirect:/srdemand/list";
	}

	/**
	 * ???????????? ?????? ?????? ?????? **
	 * 
	 * @author ?????????
	 */
	@GetMapping("/list")
	public String getSrDemandList(Authentication auth, Model model,
			@RequestParam(required = false, name = "dmndno") String dmndno,
			@RequestParam(required = true, name = "page", defaultValue = "1") String page,
			@RequestParam(required = true, name = "sort", defaultValue = "DESC")String sort,
			@RequestParam(required = false, name = "dmndYmdStart" )  Date dmndYmdStart,
			@RequestParam(required = false, name = "dmndYmdEnd") Date dmndYmdEnd,
			@RequestParam(required = false, name = "sttsCd")Integer sttsCd,
			@RequestParam(required = false, name = "sysCd")String sysCd,
			@RequestParam(required = false, name = "taskSeCd")String taskSeCd,
			@RequestParam(required = false, name = "keyWord")String keyWord) {
		log.info("sort : " + sort);
		String memberId = auth.getName();
		SrFilterDto srFilterDto = new SrFilterDto();
		if(dmndYmdStart==null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.MONTH, -1);
			String stringDate = sdf.format(calendar.getTime());
			dmndYmdStart = Date.valueOf(stringDate);//????????? ?????????
		}
		srFilterDto.setDmndYmdStart(dmndYmdStart);
		srFilterDto.setDmndYmdEnd(dmndYmdEnd);
		srFilterDto.setSttsCd(sttsCd);
		srFilterDto.setKeyWord(keyWord);
		srFilterDto.setSysCd(sysCd);
		srFilterDto.setTaskSeCd(taskSeCd);
		model.addAttribute("srFilterDto",srFilterDto);
		log.info(srFilterDto);
		// ??????
		int totalRows = srdemandService.getCountClientSr(memberId, srFilterDto);
		Pager pager = new Pager(totalRows, Integer.parseInt(page));
		log.info(pager);
		List<SrDemand> list = null;
		list = srdemandService.getSrDemandList(memberId, pager,sort,srFilterDto);
		model.addAttribute("mySrDemandList", list);

		// ?????? ????????? ?????? or ????????? ??????
		SrdemandDetail sd = null;
		String prgrsRt = null;
		if (dmndno != null||totalRows==0) {
			prgrsRt = progressService.getPrgrsRt(dmndno);
			sd = srdemandService.getSrDemandDetail(dmndno);
		} else {
			prgrsRt = progressService.getPrgrsRt(list.get(0).getDmndNo());
			sd = srdemandService.getSrDemandDetail(list.get(0).getDmndNo());
		}
		log.info(sd);
		
		//????????? ??????
		model.addAttribute("systemList",systemService.getSystemList());
		//?????? ??????
		if(sysCd!=null) {
			model.addAttribute("taskList",taskService.getTaskList(sysCd));
		}
		model.addAttribute("sd", sd);
		model.addAttribute("prgrsRt", prgrsRt);
		model.addAttribute("pager", pager);		
		model.addAttribute("role", auth.getAuthorities().stream().findFirst().get().toString());
		return "srDemand/userSrDemandList";
	}

	/**
	 * SR?????? ????????????
	 * 
	 * @author ?????????
	 */
	@GetMapping("/detail/{dmNo}")
	public String getSrDemandDetail(@PathVariable String dmNo, Model model, Authentication auth) {
		String prgrsRt = progressService.getPrgrsRt(dmNo);
		SrdemandDetail sd = srdemandService.getSrDemandDetail(dmNo);
		log.info(sd);
		SrdemandPrgrsrt sdpr = new SrdemandPrgrsrt(sd,prgrsRt);
		log.info(sdpr);
		model.addAttribute("sd", sd);
		model.addAttribute("prgrsRt", prgrsRt);
		if(auth.getAuthorities().stream().findFirst().get().toString().equals(Auth.ROLE_CLIENT.toString())) {
			return "srDemand/user/srDetail";
		}
		return "srDemand/admin/adSrDetail";
	}

	/**
	 * SR?????? ????????????
	 * 
	 * @author ?????????
	 */
	@GetMapping("/modify/{dmndNo}")
	public String updateSrDemandForm(@PathVariable String dmndNo, Model model) {
		// ?????? ??????
		log.info(dmndNo);
		SrdemandDetail sd = srdemandService.getSrDemandDetail(dmndNo);
		model.addAttribute("sd", sd);
		return "srDemand/user/srUpdate";
	}
	
	/**
	 * SR?????? ????????????
	 * 
	 * @author ?????????
	 */
	@PostMapping("/modify")
	public String updateSrDemand(SrRequestDto srRequestDto) {
		// ?????? ??????
		log.info(srRequestDto);
		srdemandService.updateSrDemand(srRequestDto);
		return "redirect:/srdemand/list?dmndno=" + srRequestDto.getDmndNo();
	}
	
	/**
	 * SR?????? ????????????
	 * 
	 * @author ?????????
	 */
	@GetMapping("/delete/{dmndNo}") 
	public String deleteSrDemand(@PathVariable("dmndNo")String dmndNo) {
		log.info(dmndNo);
		srdemandService.deleteSrdemand(dmndNo);
		return "redirect:/srdemand/list";
	}
	/**
	 * ???????????? ????????????
	 * 
	 * @author ?????????
	 */
	@PostMapping("/end")
	public String endSr(String dmndNo) {
		log.info("???????????? - controller: "+dmndNo);
		
		srdemandService.endSr(dmndNo); // SR?????? ???????????? ????????????
		log.info("SR?????? ???????????? ???????????? ??????");
		progressService.endProgress(dmndNo); // ????????? ???????????? ?????????, ????????? ??????
		log.info("????????? ???????????? ?????????, ????????? ?????? ??????");
		srinformationService.endYmd(dmndNo); // SR?????? ?????? ?????????
		log.info("SR?????? ?????? ????????? ??????");
		return "redirect:/srdemand/list";
	}
}