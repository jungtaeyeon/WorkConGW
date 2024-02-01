package com.WorkConGW.common.command;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class FileUploadCommand {
	private String fileUploadPath;
	private List<MultipartFile> uploadFile;
	private int attach_id;
	private int[] deleteFileIds;
	
	public String getFileUploadPath() {
		return fileUploadPath;
	}
	public void setFileUploadPath(String fileUploadPath) {
		this.fileUploadPath = fileUploadPath;
	}
	public List<MultipartFile> getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(List<MultipartFile> uploadFile) {
		this.uploadFile = uploadFile;
	}
	public int getAttach_id() {
		return attach_id;
	}
	public void setAttach_id(int attachId) {
		this.attach_id = attachId;
	}
	public int[] getDeleteFileIds() {
		return deleteFileIds;
	}
	public void setDeleteFileIds(int[] deleteFileIds) {
		this.deleteFileIds = deleteFileIds;
	}
	
	
}
