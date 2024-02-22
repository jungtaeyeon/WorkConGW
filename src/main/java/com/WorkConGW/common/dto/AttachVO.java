package com.WorkConGW.common.dto;

import java.util.Date;
import java.util.List;

public class AttachVO  {

	private int attach_id;
	private String attach_path;
	private String attach_name;
	private String attach_type;
	private Date attach_create_dt;
	private Date attach_end_dt;
	private List<? extends AttachVO> attach_list;


	public int getAttach_id() {
		return attach_id;
	}

	public void setAttach_id(int attach_id) {
		this.attach_id = attach_id;
	}

	public String getAttach_path() {
		return attach_path;
	}

	public void setAttach_path(String attach_path) {
		this.attach_path = attach_path;
	}

	public String getAttach_name() {
		return attach_name;
	}

	public void setAttach_name(String attach_name) {
		this.attach_name = attach_name;
	}

	public String getAttach_type() {
		return attach_type;
	}

	public void setAttach_type(String attach_type) {
		this.attach_type = attach_type;
	}

	public Date getAttach_create_dt() {
		return attach_create_dt;
	}

	public void setAttach_create_dt(Date attach_create_dt) {
		this.attach_create_dt = attach_create_dt;
	}

	public Date getAttach_end_dt() {
		return attach_end_dt;
	}

	public void setAttach_end_dt(Date attach_end_dt) {
		this.attach_end_dt = attach_end_dt;
	}

	public List<? extends AttachVO> getAttach_list() {
		return attach_list;
	}

	public void setAttach_list(List<? extends AttachVO> attach_list) {
		this.attach_list = attach_list;
	}


}
