package com.sp.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("member.memberController")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;
	
	// 변경할 시작 부분 ----------------------------------------------------------------------
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String loginForm(String login_error, Model model) {
		// 로그인 폼
		if(login_error!=null) {
			model.addAttribute("message","아이디 패스워드가 일치하지 않습니다.");
		}
		
		return "/member/login";
	}
	// 변경할 끝 부분 ----------------------------------------------------------------------

	// 이 아래로는 그냥 붙여놓은 부분이라 필요한 부분 수정해서 써야합니다.
	@RequestMapping(value="/member/member", method=RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		// 회원 가입 폼
		model.addAttribute("mode", "created");
		return ".member.member";
	}

	@RequestMapping(value="/member/member", method=RequestMethod.POST)
	public String createdSubmit(Member member, Model model) throws Exception {
		// 회원 가입
		
		// 패스워드 암호화
		String encPwd=bcryptEncoder.encode(member.getPwd());
		member.setPwd(encPwd);
		
		try {
			//service.insertMember(member);
		}catch(Exception e) {
			model.addAttribute("message", "회원가입이 실패했습니다. 다른 아이디로 다시 가입하시기 바랍니다.");
			model.addAttribute("mode", "created");
			return ".member.member";
		}
		
		StringBuffer sb=new StringBuffer();
		sb.append(member.getName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
		
		model.addAttribute("title", "회원 가입");
		model.addAttribute("message", sb.toString());
		
		return ".member.complete";
	}
	
	@RequestMapping(value="/member/userIdCheck")
	@ResponseBody
	public Map<String, Object> userIdCheck(
			@RequestParam(value="userId") String userId
			) throws Exception {
		// 아이디 중복 검사
		
		Member member = service.readMember(userId);
		
		String passed = "true";
		if(member != null)
			passed = "false";
		
		Map<String, Object> map=new HashMap<>();
		map.put("passed", passed);
		return map;
	}
	
	@RequestMapping(value="/member/pwd", method=RequestMethod.GET)
	public String pwdForm(
			String dropout,
			Model model,
			HttpSession session
			) {
		// 패스워드 확인 폼
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		if(dropout==null) {
			model.addAttribute("title", "정보수정");
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("title", "회원탈퇴");
			model.addAttribute("mode", "dropout");
		}
		return ".member.pwd";
	}
	
	@RequestMapping(value="/member/pwd", method=RequestMethod.POST)
	public String pwdSubmit(
			@RequestParam(value="userPwd") String userPwd,
			@RequestParam(value="mode") String mode,
			Model model,
			HttpSession session
	     ) {
		// 패스워드 검사
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		Member dto=service.readMember(info.getUserId());
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		
		// 패스워드 비교 (userpwd를 암호화 해서 dto.getUserPwd()와 비교하면 안된다.)
		//			userPwd를 암호화하면 가입할 때의 암호화 값과 다름. 암호화 할때 마다 다른 값.
		boolean bPwd = bcryptEncoder.matches(userPwd, dto.getPwd());
		
		if(bPwd) {
			if(mode.equals("update")) {
				model.addAttribute("dto", dto);
				model.addAttribute("mode", "update");
				model.addAttribute("title", "회원 정보 수정");
				return ".member.member";
			} else if(mode.equals("dropout")) {
				// 회원 탈퇴
				
				if(! info.getUserId().equals("admin"))
					//service.deleteMember(info.getUserId());
				
				session.removeAttribute("member");
				session.invalidate();

				model.addAttribute("title", "회원 탈퇴");
				
				StringBuffer sb=new StringBuffer();
				sb.append(dto.getName()+ "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
				sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
				model.addAttribute("message", sb.toString());
				
				return ".member.complete";
			}
		}
		
		model.addAttribute("message", "패스워드가 일치하지 않습니다.");
		if(mode.equals("update")) {
			model.addAttribute("title", "정보 수정");
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("title", "회원 탈퇴");
			model.addAttribute("mode", "dropout");
		}
		return ".member.pwd";
	}
	
	// 수정완료
	@RequestMapping(value="/member/update", 
			method=RequestMethod.POST)
	public String updateSubmit(
			Member member,
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/member/login";
		}
		
		// 패스워드 암호화
		String encPwd=bcryptEncoder.encode(member.getPwd());
		member.setPwd(encPwd);
		
		
		//service.updateMember(member);
		
		StringBuffer sb=new StringBuffer();
		sb.append(member.getName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		model.addAttribute("title", "회원 정보 수정");
		model.addAttribute("message", sb.toString());
		
		return ".member.complete";
	}
	
	@RequestMapping(value="/member/noAuthorized")
	public String noAuth() throws Exception{
		return ".member.noAuthorized";
	}
	
	@RequestMapping(value="/member/expired")
	public String expired() throws Exception{
		return ".member.expired";
	}
	
	
}
