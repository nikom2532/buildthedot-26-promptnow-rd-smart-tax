package com.revenuedepartment.datamodels;

public class M_DependOn {

	M_DepenOnFields[] fields;
	String identify;
	String operate;

	public String getIdentify() {
		return identify;
	}

	public void setIdentify(String identify) {
		this.identify = identify;
	}

	public String getOperate() {
		return operate;
	}

	public void setOperate(String operate) {
		this.operate = operate;
	}

	public M_DepenOnFields[] getFields() {
		return fields;
	}

	public void setFields(M_DepenOnFields[] fields) {
		this.fields = fields;
	}

}
