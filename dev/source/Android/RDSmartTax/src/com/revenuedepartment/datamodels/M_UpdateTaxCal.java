package com.revenuedepartment.datamodels;

public class M_UpdateTaxCal {
	String header;
	String sysRefNo;
	String fillRefNo;
	String controlCode;
	String paidAmt;
	String taxYear;
	String printURL;
	M_Bank[] fields;

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getSysRefNo() {
		return sysRefNo;
	}

	public void setSysRefNo(String sysRefNo) {
		this.sysRefNo = sysRefNo;
	}

	public String getFillRefNo() {
		return fillRefNo;
	}

	public void setFillRefNo(String fillRefNo) {
		this.fillRefNo = fillRefNo;
	}

	public String getControlCode() {
		return controlCode;
	}

	public void setControlCode(String controlCode) {
		this.controlCode = controlCode;
	}

	public String getPaidAmt() {
		return paidAmt;
	}

	public void setPaidAmt(String paidAmt) {
		this.paidAmt = paidAmt;
	}

	public String getTaxYear() {
		return taxYear;
	}

	public void setTaxYear(String taxYear) {
		this.taxYear = taxYear;
	}

	public String getPrintURL() {
		return printURL;
	}

	public void setPrintURL(String printURL) {
		this.printURL = printURL;
	}

	public M_Bank[] getFields() {
		return fields;
	}

	public void setFields(M_Bank[] fields) {
		this.fields = fields;
	}

}
