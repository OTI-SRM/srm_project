package com.oti.team2.member.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class LoginController {
	
	@GetMapping("/loginForm")
	public String getLogin() {
		return "member/login";
	}

	@ResponseBody
	@GetMapping("/auth")
	public Authentication postLogin(Authentication auth) {
		//Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		//Id 알아오는 법
		//Authentication auth 매개변수로 가져오고 getName();
		String memberId=auth.getName();	
		log.info("getName: "+ memberId);

		return auth;
	}
}