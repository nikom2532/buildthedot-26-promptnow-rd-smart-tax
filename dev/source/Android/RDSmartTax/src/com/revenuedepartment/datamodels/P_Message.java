package com.revenuedepartment.datamodels;

public class P_Message {
	private String message_version;
	private M_Message[] message_error;

	public String getMessage_version() {
		return message_version;
	}

	public void setMessage_version(String message_version) {
		this.message_version = message_version;
	}

	public M_Message[] getMessage_error() {
		return message_error;
	}

	public void setMessage_error(M_Message[] message_error) {
		this.message_error = message_error;
	}

}
