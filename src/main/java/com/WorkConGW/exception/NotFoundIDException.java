package com.WorkConGW.exception;

public class NotFoundIDException extends Exception {

	public NotFoundIDException() {
		super("아이디가 존재하지 않습니다.");
	}
}
