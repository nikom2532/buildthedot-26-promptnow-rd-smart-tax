package com.revenuedepartment.datamodels;

public class M_MessagePlaceholder {
	private String placeholder_name;
	private String placeholder_th;
	private String placeholder_en;

	public String getPlaceholder_field() {
		return placeholder_name;
	}

	public void setPlaceholder_field(String placeholder_name) {
		this.placeholder_name = placeholder_name;
	}

	public String getMessage_th() {
		return placeholder_th;
	}

	public void setMessage_th(String placeholder_th) {
		this.placeholder_th = placeholder_th;
	}

	public String getMessage_en() {
		return placeholder_en;
	}

	public void setMessage_en(String message_en) {
		this.placeholder_en = placeholder_en;
	}

}
