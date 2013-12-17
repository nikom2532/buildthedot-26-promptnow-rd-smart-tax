package com.revenuedepartment.service;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.revenuedepartment.datamodels.M_Login;
import com.revenuedepartment.datamodels.M_MarryHash;
import com.revenuedepartment.datamodels.M_SpouseHash;
import com.revenuedepartment.datamodels.M_TaxPayerHash;
import com.revenuedepartment.datapackages.P_Login;

public class GetAuthen {
	public P_Login getAuthen(String responseText) {
		P_Login pLogin = new P_Login();
		try {
			JSONObject obj = new JSONObject(responseText);
			pLogin.setResponseStatus(ConnectApi.getJsonString(obj, JSONElement.responseStatus));
			JSONObject objData = obj.getJSONObject(JSONElement.responseData);
			M_Login mLogin = new M_Login();
			mLogin.setPassportNo(ConnectApi.getJsonString(objData, JSONElement.passportNo));
			mLogin.setCountryCode(ConnectApi.getJsonString(objData, JSONElement.countryCode));
			mLogin.setEmail(ConnectApi.getJsonString(objData, JSONElement.email));
			mLogin.setTitleName(ConnectApi.getJsonString(objData, JSONElement.titleName));
			mLogin.setBirthDate(ConnectApi.getJsonString(objData, JSONElement.birthDate));
			mLogin.setContractNo(ConnectApi.getJsonString(objData, JSONElement.contractNo));
			mLogin.setIndcForm(ConnectApi.getJsonString(objData, JSONElement.indcForm));
			mLogin.setSpouseBirthDate(ConnectApi.getJsonString(objData, JSONElement.spouseBirthDate));
			mLogin.setPassportNo(ConnectApi.getJsonString(objData, JSONElement.passportNo));
			mLogin.setSpousePassportNo(ConnectApi.getJsonString(objData, JSONElement.spousePassportNo));
			mLogin.setSpouseCountryCode(ConnectApi.getJsonString(objData, JSONElement.spouseCountryCode));
			mLogin.setNid(ConnectApi.getJsonString(objData, JSONElement.nid));
			mLogin.setName(ConnectApi.getJsonString(objData, JSONElement.name));
			mLogin.setSurname(ConnectApi.getJsonString(objData, JSONElement.surname));
			mLogin.setBuildName(ConnectApi.getJsonString(objData, JSONElement.buildName));
			mLogin.setRoomNo(ConnectApi.getJsonString(objData, JSONElement.roomNo));
			mLogin.setPassportNo(ConnectApi.getJsonString(objData, JSONElement.passportNo));
			mLogin.setFloorNo(ConnectApi.getJsonString(objData, JSONElement.floorNo));
			mLogin.setAddressNo(ConnectApi.getJsonString(objData, JSONElement.addressNo));
			mLogin.setSoi(ConnectApi.getJsonString(objData, JSONElement.soi));
			mLogin.setVillage(ConnectApi.getJsonString(objData, JSONElement.village));
			mLogin.setMooNo(ConnectApi.getJsonString(objData, JSONElement.mooNo));
			mLogin.setStreet(ConnectApi.getJsonString(objData, JSONElement.street));
			mLogin.setTambol(ConnectApi.getJsonString(objData, JSONElement.tambol));
			mLogin.setAmphur(ConnectApi.getJsonString(objData, JSONElement.amphur));
			mLogin.setProvince(ConnectApi.getJsonString(objData, JSONElement.province));
			mLogin.setPostcode(ConnectApi.getJsonString(objData, JSONElement.postcode));
			mLogin.setTaxpayerStatus(ConnectApi.getJsonString(objData, JSONElement.taxpayerStatus));
			mLogin.setSpouseStatus(ConnectApi.getJsonString(objData, JSONElement.spouseStatus));
			mLogin.setMarryStatus(ConnectApi.getJsonString(objData, JSONElement.marryStatus));
			mLogin.setSpouseNid(ConnectApi.getJsonString(objData, JSONElement.spouseNid));
			mLogin.setSpouseName(ConnectApi.getJsonString(objData, JSONElement.spouseName));
			mLogin.setSpouseSurname(ConnectApi.getJsonString(objData, JSONElement.spouseSurname));
			mLogin.setChildNoStudy(ConnectApi.getJsonString(objData, JSONElement.childNoStudy));
			mLogin.setChildStudy(ConnectApi.getJsonString(objData, JSONElement.childStudy));
			mLogin.setTxpFatherPin(ConnectApi.getJsonString(objData, JSONElement.txpFatherPin));
			mLogin.setTxpMotherPin(ConnectApi.getJsonString(objData, JSONElement.txpMotherPin));
			mLogin.setSpouseFatherPin(ConnectApi.getJsonString(objData, JSONElement.spouseFatherPin));
			mLogin.setSpouseMotherPin(ConnectApi.getJsonString(objData, JSONElement.spouseMotherPin));
			mLogin.setAuthenKey(ConnectApi.getJsonString(objData, JSONElement.authenKey));
			mLogin.setThaiNation(ConnectApi.getJsonString(objData, JSONElement.thaiNation));

			JSONObject objTaxpayerHash = objData.getJSONObject(JSONElement.taxpayerHash);
			M_TaxPayerHash mTaxpayer = new M_TaxPayerHash();
			mTaxpayer.setT0(ConnectApi.getJsonString(objTaxpayerHash, "0"));
			mTaxpayer.setT1(ConnectApi.getJsonString(objTaxpayerHash, "1"));
			mTaxpayer.setT2(ConnectApi.getJsonString(objTaxpayerHash, "2"));
			mTaxpayer.setT3(ConnectApi.getJsonString(objTaxpayerHash, "3"));
			mLogin.setTaxpayerHash(mTaxpayer);

			JSONObject objSpouseHash = objData.getJSONObject(JSONElement.spouseHash);
			M_SpouseHash mSpouseHash = new M_SpouseHash();
			mSpouseHash.setT0(ConnectApi.getJsonString(objSpouseHash, "0"));
			mSpouseHash.setT1(ConnectApi.getJsonString(objSpouseHash, "1"));
			mLogin.setSpouseHash(mSpouseHash);

			JSONObject objMarryHash = objData.getJSONObject(JSONElement.marryHash);
			M_MarryHash mMarryHash = new M_MarryHash();
			mMarryHash.setT0(ConnectApi.getJsonString(objMarryHash, "0"));
			mMarryHash.setT1(ConnectApi.getJsonString(objMarryHash, "1"));
			mMarryHash.setT1(ConnectApi.getJsonString(objMarryHash, "2"));
			mMarryHash.setT1(ConnectApi.getJsonString(objMarryHash, "3"));
			mLogin.setMarryHash(mMarryHash);
			
			pLogin.setResponseData(mLogin);
			return pLogin;
		} catch (JSONException e) {
			e.printStackTrace();
		}

		return null;
	}
}
