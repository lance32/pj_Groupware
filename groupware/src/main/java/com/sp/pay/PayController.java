package com.sp.pay;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
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
import org.springframework.web.bind.annotation.ResponseBody;

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
			@RequestParam(value="searchKey", defaultValue="all") String searchKey,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info =(SessionInfo) session.getAttribute("member");
		
		if(info==null) {
			return "member/login";
		}
		
		if(info.getUserId().equalsIgnoreCase("admin")) {
			return "redirect:/pay/adminMain";
		}
		
		String memberNum=info.getUserId();
		
		String cp=req.getContextPath();
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("memberNum", memberNum);
        dataCount = service.memberdataCount(map);
       
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
        
        //년도별 리스트
        List<Map<String, Object>> payYearList = service.payYearList(memberNum);
        
        // 급여 리스트
        List<Pay> paymemberlist = service.ListPayMember(map);
        
        // 리스트의 번호
        int listNum, n = 0;
        Iterator<Pay> it=paymemberlist.iterator();
        while(it.hasNext()) {
            Pay data = it.next();
            listNum = dataCount - ((start + n) - 1);
            data.setListNum(listNum);
            n++;
          
        }
        
        String query = "";
        String listUrl = cp+"/pay/main";
        String articleUrl = cp+"/pay/paymemberinfo?page=" + current_page;
        if(searchKey.length()!=0) {
        	query = "searchKey=" +searchKey;
        	         	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/pay/main?" + query;
        	articleUrl = cp+"/pay/paymemberinfo?page=" + current_page + "&"+ query;
        }
        
        String paging = util.paging(current_page, total_page, listUrl);
       
        model.addAttribute("payYearList",payYearList);
        model.addAttribute("paymemberlist", paymemberlist);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		
        if(info.getUserId().equalsIgnoreCase("admin")) {
        	return "redirect:/pay/adminMain";
        }
        
		
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
	
	@RequestMapping(value="/pay/paymemberinfo")
	public String article(@RequestParam String memberNum,
			@RequestParam(value="page") String page,
			@RequestParam(value="searchKey", defaultValue="all") String searchKey,
			@RequestParam int year,
			@RequestParam int month,
			HttpSession session,
			Model model) throws Exception {
		
		System.out.println("============="+year+"=============="+month);
		String query="page="+page+"&searchKey="+searchKey;
		
		Map<String, Object> map=new HashMap<>();
		
		map.put("memberNum", memberNum);
		map.put("year", year);
		map.put("month", month);
		
		// 해당 레코드 가져 오기
		Pay dto = service.readMember(map);
		if(dto==null)
			return "redirect:/pay/main?"+query;
		
		//기본급 출력시 값에 , 추가
		DecimalFormat df= new DecimalFormat("###,###");
		String basicpay=df.format((dto.getBasicpay()));
		int allTax=dto.getHealthTax()+dto.getEmployTax()+dto.getAccidentTax()+dto.getPensionTax()+dto.getIncomeTax();
		int allPay=dto.getBasicpay()+dto.getExtraPay();
		dto.setRealPay(allPay-allTax);
		
		model.addAttribute("allTax",allTax);
		model.addAttribute("allPay",allPay);
		model.addAttribute("basicpay",basicpay);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".workhelper.paymemberinfo";
	}
	
	@RequestMapping(value="/pay/insertpay",method=RequestMethod.GET)
	public String insertPayForm(HttpSession session,
			Model model) throws Exception {
		
		List<Tax> taxList=service.taxList();
		model.addAttribute("taxList",taxList);
		
		return ".workhelper.insertPay";
		
	}
	
	@RequestMapping(value="/pay/insertPay",method=RequestMethod.POST)
	public String insertPaySubmit(Pay dto,Model model,HttpSession session) {
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		if(info==null) {
			return "member/login";
		}
		Map<String, Object> map = new HashMap<>();
		map.put("memberNum", dto.getMemberNum());
		map.put("year", dto.getYear());
		map.put("month",dto.getMonth());
		map.put("day", dto.getDay());
		
		Pay pay=service.readSalary(map);
		
		
		try {
			if(pay==null) {
				service.insertPay(dto);
			}else {
				service.updateMember(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/pay/adminMain";
		
		
	}
	
	public String updatePay()throws Exception{
		return null;
	}
	
	@RequestMapping(value="/pay/mathPay",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> mathPay(
			@RequestParam int basicpay
			)throws Exception{
		
		String passed = "true";
		if(basicpay == 0)
			passed = "false";
		
		Map<String, Object> map=new HashMap<>();
		map.put("passed", passed);
		map.put("basicpay", basicpay);
		return map;
	}
}
