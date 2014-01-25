package com.revenuedepartment.datamodels;

public class P_MessagePlaceHolder {
	private String message_version;
	private M_MessagePlaceholder[] placeholder;

	public String getMessage_version() {
		return message_version;
	}

	public void setMessage_version(String message_version) {
		this.message_version = message_version;
	}

	public M_MessagePlaceholder[] getMessage_error() {
		return placeholder;
	}

	public void setMessage_error(M_MessagePlaceholder[] placeholder) {
		this.placeholder = placeholder;
	}

}
