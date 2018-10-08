package com.sp.pay;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("pay.payController")
public class PayController {
	
	@Autowired
	private PayService service;
	
	@Autowired
	private MyUtil util;
	
	//급여 조회 리스트(유저)
	@RequestMapping(value="/pay/main")
	public String ListPayMember(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="name") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info =(SessionInfo) session.getAttribute("member");
		
		if(info==null) {
			return "member/login";
		}
		
		String cp=req.getContextPath();
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);

        dataCount = service.dataCount(map);
        
        if(dataCount != 0)
            total_page = util.pageCount(rows, dataCount);

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
        	current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);
        
        // 급여 리스트
        List<Pay> paylist = service.ListPayMemberAdmin(map);
        
        // 리스트의 번호
        int listNum, n = 0;
        Iterator<Pay> it=paylist.iterator();
        while(it.hasNext()) {
            Pay data = it.next();
            listNum = dataCount - ((start + n) - 1);
            data.setListNum(listNum);
            n++;
          
        }
        
        String query = "";
        String listUrl = cp+"/pay/adminMain";
        String articleUrl = cp+"/pay/paymemberinfo?page=" + current_page;
        if(searchValue.length()!=0) {
        	query = "searchKey=" +searchKey + 
        	         "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/pay/adminMain?" + query;
        	articleUrl = cp+"/pay/paymemberinfo?page=" + current_page + "&"+ query;
        }
        
        String paging = util.paging(current_page, total_page, listUrl);

        model.addAttribute("paylist", paylist);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		
		
		return ".workhelper.paymain";
	}
	
	//급여 조회 리스트(관리자)
	@RequestMapping(value="/pay/adminMain")
	public String adminPayList(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="name") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception{
	
		SessionInfo info =(SessionInfo) session.getAttribute("member");
		
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
            total_page = util.pageCount(rows, dataCount);

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
        	current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);
        
        // 급여 리스트
        List<Pay> paylist = service.ListPayMemberAdmin(map);
        
        // 리스트의 번호
        int listNum, n = 0;
        Iterator<Pay> it=paylist.iterator();
        while(it.hasNext()) {
            Pay data = it.next();
            listNum = dataCount - ((start + n) - 1);
            data.setListNum(listNum);
            n++;
          
        }
        
        String query = "";
        String listUrl = cp+"/pay/adminMain";
        String articleUrl = cp+"/pay/paymemberinfo?page=" + current_page;
        if(searchValue.length()!=0) {
        	query = "searchKey=" +searchKey + 
        	         "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/pay/adminMain?" + query;
        	articleUrl = cp+"/pay/paymemberinfo?page=" + current_page + "&"+ query;
        }
        
        String paging = util.paging(current_page, total_page, listUrl);

        model.addAttribute("paylist", paylist);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);

		return ".workhelper.adminMain";
	
	}
	
	@RequestMapping(value="/pay/insertpay",method=RequestMethod.GET)
	public String insertPayForm(HttpSession session) {
		
		
		
		
		return ".workhelper.insertPay";
		
	}
	
	@RequestMapping(value="/pay/insertPay",method=RequestMethod.POST)
	public String insertPaySubmit() {
		return ".workhelper.main";
		
		
	}
	
	public String updatePay() {
		return null;
	}
	
	
}
