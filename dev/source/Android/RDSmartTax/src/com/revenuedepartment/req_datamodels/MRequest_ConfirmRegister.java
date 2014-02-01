package com.revenuedepartment.req_datamodels;

import com.promptnow.network.model.CommonRequestRD;

public class MRequest_ConfirmRegister extends CommonRequestRD {

	public String nid = "";
	public String buildName = "";
	public String roomNo = "";
	public String floorNo = "";
	public String addressNo = "";
	public String village = "";
	public String mooNo = "";
	public String street = "";
	public String tambol = "";
	public String amphur = "";
	public String province = "";
	public String postcode = "";
	public String contractNo  = "";

	public String getNid() {
		return nid;
	}

	public void setNid(String nid) {
		this.nid = nid;
	}

	public String getBuildName() {
		return buildName;
	}

	public void setBuildName(String buildName) {
		this.buildName = buildName;
	}

	public String getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}

	public String getFloorNo() {
		return floorNo;
	}

	public void setFloorNo(String floorNo) {
		this.floorNo = floorNo;
	}

	public String getAddressNo() {
		return addressNo;
	}

	public void setAddressNo(String addressNo) {
		this.addressNo = addressNo;
	}

	public String getVillage() {
		return village;
	}

	public void setVillage(String village) {
		this.village = village;
	}

	public String getMooNo() {
		return mooNo;
	}

	public void setMooNo(String mooNo) {
		this.mooNo = mooNo;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getTambol() {
		return tambol;
	}

	public void setTambol(String tambol) {
		this.tambol = tambol;
	}

	public String getAmphur() {
		return amphur;
	}

	public void setAmphur(String amphur) {
		this.amphur = amphur;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

//	public String getVersion() {
//		return version;
//	}
//
//	public void setVersion(String version) {
//		this.version = version;
//	}

}
