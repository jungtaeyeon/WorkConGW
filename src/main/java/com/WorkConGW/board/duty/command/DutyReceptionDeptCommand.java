package com.WorkConGW.board.duty.command;

public class DutyReceptionDeptCommand {


	private int duty_Board_Id;
	private String dept_Name;
	private String dept_Id;

	public int getDuty_Board_Id() {
		return duty_Board_Id;
	}

	public void setDuty_Board_Id(int duty_Board_Id) {
		this.duty_Board_Id = duty_Board_Id;
	}

	public String getDept_Name() {
		return dept_Name;
	}

	public void setDept_Name(String dept_Name) {
		this.dept_Name = dept_Name;
	}

	public String getDept_Id() {
		return dept_Id;
	}

	public void setDept_Id(String dept_Id) {
		this.dept_Id = dept_Id;
	}
	
}
