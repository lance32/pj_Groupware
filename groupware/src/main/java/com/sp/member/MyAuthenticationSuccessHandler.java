package com.sp.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

//로그인 성공 후 세션 및  쿠기 동의 처리
public class MyAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	
	@Autowired
	private MemberService service;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		
		//System.out.println(authentication.getName());//로그인 아이디
		
		String memberNum=authentication.getName();// userId는 authentication에서는 userName으로 저장된다.
											   // 유저의 아이디를 가저오려면 userName으로 값을 가져와야 한다.
		
		//로그인 날짜 변경
		//service.updateLastLogin(memberNum);
		
		//세션에 로그인 정보 저장.
		HttpSession session = request.getSession();
		Member dto=service.readMember(memberNum);
		SessionInfo info = new SessionInfo();
		info.setUserId(memberNum);
		info.setUserName(dto.getName());
		
		session.setAttribute("member", info);
				
		super.onAuthenticationSuccess(request, response, authentication);
	}
}
