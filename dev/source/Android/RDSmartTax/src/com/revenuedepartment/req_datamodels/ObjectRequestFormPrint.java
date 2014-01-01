package com.revenuedepartment.req_datamodels;

public class ObjectRequestFormPrint {
	String nid;
	String authenKey;
	String formCode;
	String formType;
	String taxYear;

	public String getNid() {
		return nid;
	}

	public void setNid(String nid) {
		this.nid = nid;
	}

	public String getAuthenKey() {
		return authenKey;
	}

	public void setAuthenKey(String authenKey) {
		this.authenKey = authenKey;
	}

	public String getFormCode() {
		return formCode;
	}

	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	public String getFormType() {
		return formType;
	}

	public void setFormType(String formType) {
		this.formType = formType;
	}

	public String getTaxYear() {
		return taxYear;
	}

	public void setTaxYear(String taxYear) {
		this.taxYear = taxYear;
	}

}
