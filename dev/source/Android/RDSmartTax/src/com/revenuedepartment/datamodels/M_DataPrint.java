package com.revenuedepartment.datamodels;

import java.util.ArrayList;

public class M_DataPrint {
	String nid;
	String formCode;
	String formType;
	String taxYear;
	ArrayList<M_FormData> formData;

	public String getNid() {
		return nid;
	}

	public void setNid(String nid) {
		this.nid = nid;
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

	public ArrayList<M_FormData> getFormData() {
		return formData;
	}

	public void setFormData(ArrayList<M_FormData> formData) {
		this.formData = formData;
	}

}
