package com.sp.member;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;


@Controller("member.memberController")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;
	
	@Autowired
	private MyUtil util;
	
	// 변경할 시작 부분 ----------------------------------------------------------------------
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginForm(String login_error, HttpSession session, Model model) {
		// 로그인 폼
		if(login_error!=null) {
			model.addAttribute("message","아이디 또는 패스워드가 일치하지 않습니다.");
		}
		
		//SessionInfo info =(SessionInfo) session.getAttribute("member");
		
		return "/member/login";
	}
	
	//최초 로그인 체크
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String firstLoginCheck(Member dto,HttpSession session) {
		
		
		return "";
	}
	// 변경할 끝 부분 ----------------------------------------------------------------------
	
	//멤버 리스트
	@RequestMapping(value="/member/main")
	public String memberList(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception{
			
		
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		if(info==null) {
			return "member/login";
		}
		
		String cp=req.getContextPath();
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = util.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);

        // 멤버 리스트
        List<Member> list = service.ListMember(map);

        // 리스트의 번호
        int listmemberNum, n = 0;
        Iterator<Member> it=list.iterator();
        while(it.hasNext()) {
            Member data = it.next();
            listmemberNum = dataCount - (start + n - 1);
            data.setListmemberNum(listmemberNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/member/main";
        String articleUrl = cp+"/member/memberinfo?page=" + current_page;
        if(searchValue.length()!=0) {
        	query = "searchKey=" +searchKey + 
        	         "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/member/main?" + query;
        	articleUrl = cp+"/member/memberinfo?page=" + current_page + "&"+ query;
        }
        
        String paging = util.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		
		return ".member.main";
	}

	//사원 추가 폼
	@RequestMapping(value="/member/member", method=RequestMethod.GET)
	public String createdForm(Model model,HttpSession session) throws Exception {
		// 사원 추가 폼
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		if(info==null) {
			return "member/login";
		}
		//부서,직급에 대한 정보를 가져와 리스트로 저장
		List<Map<String, Object>> departmentList=service.departmentList();
		List<Map<String, Object>> positionList=service.positionList();
		
		
		model.addAttribute("departmentList",departmentList);
		model.addAttribute("positionList",positionList);
		model.addAttribute("mode", "created");
		return ".member.member";
	}
	
	//사원 추가
	@RequestMapping(value="/member/member", method=RequestMethod.POST)
	public String createdSubmit(Member dto, Model model,HttpSession session) throws Exception {
		// 사원 추가
		
		// 패스워드 암호화
		String encPwd="1111";
		encPwd=bcryptEncoder.encode(encPwd);
		dto.setPwd(encPwd);
		
		//사진 추가 
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"upload"+File.separator+"member";
	
		try {
			service.insertMember(dto, pathname);
		}catch(Exception e) {
			model.addAttribute("message", "회원가입이 실패했습니다. 다시 가입하시기 바랍니다.");
			model.addAttribute("mode", "created");
			return ".member.member";
		}
		
		StringBuffer sb=new StringBuffer();
		sb.append(dto.getName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("로그인화면에서  로그인 하시기 바랍니다.<br>");
		
		model.addAttribute("title", "회원 가입");
		model.addAttribute("message", sb.toString());
		
		return "redirect:/member/main";
	}
	
	@RequestMapping(value="/member/memberNumCheck")
	@ResponseBody
	public Map<String, Object> memberNumCheck(
			@RequestParam(value="memberNum") String memberNum
			) throws Exception {
		// 아이디 중복 검사
		
		Member member = service.readMember(memberNum);
		
		String passed = "true";
		if(member != null)
			passed = "false";
		
		Map<String, Object> map=new HashMap<>();
		map.put("passed", passed);
		return map;
	}
	
	//최초 로그인시 비밀번호 변경
	@RequestMapping(value="/member/changepwd", method=RequestMethod.GET)
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
			return "redirect:/member/login";
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
	
	@RequestMapping(value="/member/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam String memberNum,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(info==null) {
			return "member/login";
		}
		
		List<Map<String, Object>> departmentList=service.departmentList();
		List<Map<String, Object>> positionList=service.positionList();
		
		Member dto = service.readMember(memberNum);
		if(dto==null) {
			return "redirect:/member/main?page="+page;
		}

		if(! info.getUserId().equals(dto.getMemberNum()) && ! info.getUserId().equals("admin")) {
			return "redirect:/member/main?page="+page;
		}
		model.addAttribute("departmentList",departmentList);
		model.addAttribute("positionList",positionList);
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".member.member";
	}

	
	
	// 수정완료
	@RequestMapping(value="/member/update", method=RequestMethod.POST)
	public String updateSubmit(
			Member dto,
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		// 패스워드 암호화
		String encPwd=bcryptEncoder.encode(dto.getPwd());
		dto.setPwd(encPwd);
		
		
		//service.updateMember(dto.getMemberNum());
		
		StringBuffer sb=new StringBuffer();
		sb.append(dto.getName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		model.addAttribute("title", "회원 정보 수정");
		model.addAttribute("message", sb.toString());
		
		return ".member.complete";
	}
	
	@RequestMapping(value="/member/memberinfo")
	public String article( 
			@RequestParam String memberNum,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="name") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model) throws Exception{
		
		searchValue = URLDecoder.decode(searchValue, "utf-8");
		
		String query="page="+page;
		if(searchValue.length()!=0) {
			query+="&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}


		// 해당 레코드 가져 오기
		Member dto = service.readMember(memberNum);
		if(dto==null)
			return "redirect:/member/main?"+query;
	
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("member",dto);
		
		return ".member.memberinfo";
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
