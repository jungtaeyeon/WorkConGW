package com.WorkConGW.approval.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApprovalFormVO {
	private ApprovalVO approvalVO;
    private ApprovalVO searchApprovalVO;

    public ApprovalFormVO()
    {
        this.approvalVO = new ApprovalVO();
        this.searchApprovalVO = new ApprovalVO();
    }

}
