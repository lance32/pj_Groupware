package com.sp.approval;

import java.util.List;
import java.util.Map;

public interface ApprovalService {
	
	public int insertApproval(Approval dto);
	
	public List<Approval> listApproval(Map<String, Object> map);
	
	public int dataCount(Map<String, Object> map);
	
	public Approval readApproval(int approvalNum);

	public int approvalCount(Map<String, Object> map);

}
