package com.revenuedepartment.datamodels;

public class M_DepenOnFields {
	String title = "";
	String hidden = "";
	String identify = "";
	String label = "";
	String type = "";
	String keyboardType = "";
	String secure = "";
	String format = "";
	
	M_Summary[] summary = null;

	public M_Summary[] getSummary() {
		return summary;
	}

	public void setSummary(M_Summary[] summary) {
		this.summary = summary;
	}

	
	
	M_Conditions[] conditions = null;

	public M_Conditions[] getConditions() {
		return conditions;
	}

	public void setConditions(M_Conditions[] conditions) {
		this.conditions = conditions;
	}

	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getHidden() {
		return hidden;
	}

	public void setHidden(String hidden) {
		this.hidden = hidden;
	}

	public String getIdentify() {
		return identify;
	}

	public void setIdentify(String identify) {
		this.identify = identify;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getKeyboardType() {
		return keyboardType;
	}

	public void setKeyboardType(String keyboardType) {
		this.keyboardType = keyboardType;
	}

	public String getSecure() {
		return secure;
	}

	public void setSecure(String secure) {
		this.secure = secure;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}
}
