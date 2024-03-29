package com.fa.plus.pluszone.service;

import java.util.Map;

import com.fa.plus.pluszone.domain.MemberPlus;

public interface MemberPlusService {
	public void insertPlus(MemberPlus dto) throws Exception;
	public void updateLastLogin(String userId) throws Exception;
	
	public void updateMemberPlus(MemberPlus dto) throws Exception;
	
	public MemberPlus findById(String userId);
	public MemberPlus findByMemberIdx(long memberIdx);
	
	public MemberPlus loginPlusMember(String userId);
	
	//public void generatePwd(MemberPlus dto) throws Exception;
	
	public boolean isPasswordCheck(String userId, String userPwd);
	public void updatePwd(MemberPlus dto) throws Exception;
	public int checkFailureCount(String userId);
	public void updateFailureCount(String userId) throws Exception;
	public void updateFailureCountReset(String userId) throws Exception;
	public void updateMemberEnabled(Map<String, Object> map) throws Exception;
	public void insertMemberState(MemberPlus dto) throws Exception;
	
	// 관리자 메인 페이지
	// 미승인 플러스 수
	public int noApprovedPlus();
	
	// 요청 플러스 수
	public int requestPlus();
	
	// 승인된 플러스 수
	public int approvedPlus();

}
