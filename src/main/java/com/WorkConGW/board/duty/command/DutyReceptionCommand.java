package com.WorkConGW.board.duty.command;

public class DutyReceptionCommand {

	private int duty_Board_Id;
	private String emp_Id;
	private String emp_Name;

	public int getDuty_Board_Id() {
		return duty_Board_Id;
	}

	public void setDuty_Board_Id(int duty_Board_Id) {
		this.duty_Board_Id = duty_Board_Id;
	}

	public String getEmp_Id() {
		return emp_Id;
	}

	public void setEmp_Id(String emp_Id) {
		this.emp_Id = emp_Id;
	}

	public String getEmp_Name() {
		return emp_Name;
	}

	public void setEmp_Name(String emp_Name) {
		this.emp_Name = emp_Name;
	}
	
}
