package com.sp.approval;

import java.util.List;
import java.util.Map;

public interface ApprovalService {
	
	public int insertApproval(Approval dto);
	
	public List<Approval> listApproval(Map<String, Object> map);
	
	public int dataCount(Map<String, Object> map);
	
	public Approval readApproval(int approvalNum);

	public int approvalCount(Map<String, Object> map);

	public List<ApprovalSummary> readApprovalSummary(String type, String userId);
	
	public List<ApprovalSummary> readApproval(String type, String userId);
	
	public List<ApprovalProcess> getApprovalProcess(int docuNum);
	
	public int approvalSend(Map<String, Object> map);
	
	public int approvalSign(Map<String, Object> map);
	

}
