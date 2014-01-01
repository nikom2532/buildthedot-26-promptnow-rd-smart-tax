package com.revenuedepartment.datamodels;

public class M_FormData {
	private String receiptNo;
	private String refNo;
	private String sysRefNo;
	private String payDate;
	private String taxMonth;
	private String taxAmount;
	private String printURL;

	public String getSysRefNo() {
		return sysRefNo;
	}

	public void setSysRefNo(String sysRefNo) {
		this.sysRefNo = sysRefNo;
	}

	public String getReceiptNo() {
		return receiptNo;
	}

	public void setReceiptNo(String receiptNo) {
		this.receiptNo = receiptNo;
	}

	public String getRefNo() {
		return refNo;
	}

	public void setRefNo(String refNo) {
		this.refNo = refNo;
	}

	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	public String getTaxMonth() {
		return taxMonth;
	}

	public void setTaxMonth(String taxMonth) {
		this.taxMonth = taxMonth;
	}

	public String getTaxAmount() {
		return taxAmount;
	}

	public void setTaxAmount(String taxAmount) {
		this.taxAmount = taxAmount;
	}

	public String getPrintURL() {
		return printURL;
	}

	public void setPrintURL(String printURL) {
		this.printURL = printURL;
	}

}
