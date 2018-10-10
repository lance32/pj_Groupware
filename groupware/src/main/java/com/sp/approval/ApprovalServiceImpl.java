package com.sp.approval;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("approval.approvalService")
public class ApprovalServiceImpl implements ApprovalService{
	
	@Autowired
	private CommonDAO dao;

	@Override
	public int insertApproval(Approval dto) {
		int result=0;
		try {
			result=dao.insertData("approval.insertApproval", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	@Override
	public int approvalSend(Map<String, Object> map) {
		int retVal = -1;
		try {
			retVal = dao.insertData("approvalSend", map);
		}catch(Exception e) {
			retVal = 0;
		}
		return retVal;
	}

	@Override
	public int approvalSign(Map<String, Object> map) {
		int retVal = -1;
		try {
			retVal = dao.insertData("approvalSign", map);
		}catch(Exception e) {
			retVal = 0;
		}
		return retVal;
	}
	
	@Override
	public List<Approval> listApproval(Map<String, Object> map) {
		List<Approval> list=null;
		
		try {
			list=dao.selectList("approval.approval_list", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Approval readApproval(int docuNum) {
		Approval dto = null;
		
		try {
			dto = dao.selectOne("approval.approval", docuNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	@Override
	public List<ApprovalProcess> getApprovalProcess(int docuNum) {
		List<ApprovalProcess> dto = null;
		
		try {
			dto = dao.selectList("approval.approvalProcess", docuNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	@Override
	public List<ApprovalSummary> readApprovalSummary(String type, String userId) {
		switch(type) {
		case "1" : return this.tomeApprovalSummary(userId);
		case "2" : return this.myApprovalProgressSummary(userId);
		case "3" : return this.myApprovalCompletedSummary(userId);
		case "4" : return this.myApprovalRejectSummary(userId);
		}
		return null;
	}
	
	/**
	 * 내가 결재할 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> tomeApprovalSummary(String memberNum) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.tomeApprovalListSummary", memberNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	/**
	 * 내가 기안한 진행중인 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> myApprovalProgressSummary(Object param) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.myApprovalProgressSummary", param);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	/**
	 * 내가 기안한 완료된 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> myApprovalCompletedSummary(String param) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.myApprovalCompletedSummary", param);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	/**
	 * 내가 기안한 반려된 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> myApprovalRejectSummary(String param) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.myApprovalRejectSummary", param);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	
	@Override
	public List<ApprovalSummary> readApproval(String type, String userId) {
		switch(type) {
		case "1" : return this.tomeApproval(userId);
		case "2" : return this.myApprovalProgress(userId);
		case "3" : return this.myApprovalCompleted(userId);
		case "4" : return this.myApprovalReject(userId);
		}
		return null;
	}
	
	/**
	 * 내가 결재할 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> tomeApproval(String memberNum) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.tomeApprovalList", memberNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	/**
	 * 내가 기안한 진행중인 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> myApprovalProgress(Object param) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.myApprovalProgress", param);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	/**
	 * 내가 기안한 완료된 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> myApprovalCompleted(String param) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.myApprovalCompleted", param);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	/**
	 * 내가 기안한 반려된 문서 요약 가져오기
	 * @param param
	 * @return
	 */
	public List<ApprovalSummary> myApprovalReject(String param) {
		List<ApprovalSummary> dto = null;
		
		try {
			dto = dao.selectList("approval.myApprovalReject", param);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	
	@Override
	public int approvalCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("approval.approvalCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
