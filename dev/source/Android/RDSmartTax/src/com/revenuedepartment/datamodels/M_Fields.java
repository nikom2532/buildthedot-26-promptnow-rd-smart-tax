package com.revenuedepartment.datamodels;

public class M_Fields {
	String hidden = "";
	String identify = "";
	String label = "";
	String type = "";
	String secure = "";
	String placeholder = "";
	String format = "";
	String keyboardType = "";

	M_Conditions[] condition = null;

	public M_Conditions[] getCondition() {
		return condition;
	}

	public void setCondition(M_Conditions[] condition) {
		this.condition = condition;
	}

	M_DependOn[] dependOn = null;

	M_Validate[] validate = null;

	public M_Validate[] getValidate() {
		return validate;
	}

	public void setValidate(M_Validate[] validate) {
		this.validate = validate;
	}

	public M_DependOn[] getDependOn() {
		return dependOn;
	}

	public void setDependOn(M_DependOn[] dependOn) {
		this.dependOn = dependOn;
	}

	M_Summary[] summary = null;

	public M_Summary[] getSummary() {
		return summary;
	}

	public void setSummary(M_Summary[] summary) {
		this.summary = summary;
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

	public String getSecure() {
		return secure;
	}

	public void setSecure(String secure) {
		this.secure = secure;
	}

	public String getPlaceholder() {
		return placeholder;
	}

	public void setPlaceholder(String placeholder) {
		this.placeholder = placeholder;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public String getKeyboardType() {
		return keyboardType;
	}

	public void setKeyboardType(String keyboardType) {
		this.keyboardType = keyboardType;
	}

}
