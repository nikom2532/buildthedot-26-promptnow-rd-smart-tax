package com.revenuedepartment.service;

import org.json.JSONException;
import org.json.JSONObject;

import android.os.Bundle;
import android.util.Log;

import com.promptnow.network.model.CommonResponseRD;
import com.promptnow.network.model.lgauthen.AuthenData;
import com.promptnow.network.model.lgauthen.AuthenResponse;
import com.revenuedepartment.datamodels.M_MarryHash;
import com.revenuedepartment.datamodels.M_SpouseHash;
import com.revenuedepartment.datamodels.M_TaxPayerHash;
import com.revenuedepartment.function.writeLog;

public class GetAuthen {
	public AuthenResponse getAuthen(String responseText) {
		AuthenResponse pLogin = new AuthenResponse();
		try {
			JSONObject obj = new JSONObject(responseText);
			pLogin.setResponseStatus(ConnectApi.getJsonString(obj, JSONElement.responseStatus));

			pLogin.responseCode = ConnectApi.getJsonString(obj, JSONElement.responseCode);
			pLogin.responseMessage = ConnectApi.getJsonString(obj, JSONElement.responseMessage);
			pLogin.responseError = ConnectApi.getJsonString(obj, JSONElement.responseError);

			if (pLogin.responseCode.equals("ERROR")) {
				pLogin.responseCode = "0";
			}

			if (pLogin.responseCode.equals(CommonResponseRD.CODE_2)) {

			} else {
				JSONObject objData = obj.getJSONObject(JSONElement.responseData);
//				pLogin.setTemp_json_data(obj.toString());
				pLogin.setResponseData(getResponseData(objData.toString()));
			}
			return pLogin;
		} catch (JSONException e) {
			pLogin.responseMessage = responseText;
			e.printStackTrace();

		}

		return null;
	}

	public static AuthenData getTempAuthen(String responseText) {
		try {
			JSONObject obj = new JSONObject(responseText);
			JSONObject objData = obj.getJSONObject(JSONElement.responseData);
			AuthenData mLogin = getResponseData(objData.toString());
			return mLogin;
		} catch (JSONException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static AuthenData getResponseData(String jsonObject) {
		AuthenData mLogin = null;
		
		try {
			Log.i("GetAuthen", "get authen : "+jsonObject);
			JSONObject objData = new JSONObject(jsonObject);
			mLogin = new AuthenData();

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
			mLogin.lastAccessed = ConnectApi.getJsonString(objData, JSONElement.lastAccessed);

			JSONObject objTaxpayerHash = objData.getJSONObject(JSONElement.taxpayerHash);
			M_TaxPayerHash mTaxpayer = new M_TaxPayerHash();
			mTaxpayer.setT0(ConnectApi.getJsonString(objTaxpayerHash, "0"));
			mTaxpayer.setT0Value("0");
			mTaxpayer.setT1(ConnectApi.getJsonString(objTaxpayerHash, "1"));
			mTaxpayer.setT1Value("1");
			mTaxpayer.setT2(ConnectApi.getJsonString(objTaxpayerHash, "2"));
			mTaxpayer.setT2Value("2");
			mTaxpayer.setT3(ConnectApi.getJsonString(objTaxpayerHash, "3"));
			mTaxpayer.setT3Value("3");
			mLogin.setTaxpayerHash(mTaxpayer);

			JSONObject objSpouseHash = objData.getJSONObject(JSONElement.spouseHash);
			M_SpouseHash mSpouseHash = new M_SpouseHash();
			mSpouseHash.setT0(ConnectApi.getJsonString(objSpouseHash, "0"));
			mSpouseHash.setT0Value("0");
			mSpouseHash.setT1(ConnectApi.getJsonString(objSpouseHash, "1"));
			mSpouseHash.setT1Value("1");
			mLogin.setSpouseHash(mSpouseHash);

			JSONObject objMarryHash = objData.getJSONObject(JSONElement.marryHash);
			M_MarryHash mMarryHash = new M_MarryHash();
			mMarryHash.setT0(ConnectApi.getJsonString(objMarryHash, "0"));
			mMarryHash.setT0Value("0");
			mMarryHash.setT1(ConnectApi.getJsonString(objMarryHash, "1"));
			mMarryHash.setT1Value("1");
			mMarryHash.setT2(ConnectApi.getJsonString(objMarryHash, "2"));
			mMarryHash.setT2Value("2");
			mMarryHash.setT3(ConnectApi.getJsonString(objMarryHash, "3"));
			mMarryHash.setT3Value("3");
			mLogin.setMarryHash(mMarryHash);

		} catch (JSONException e) {
			writeLog.LogE("getResponseData authen", e.toString());
			e.printStackTrace();
		}

		return mLogin;

	}

	public static Bundle dataCenter(String jsonCenter) {
		Bundle mValue = null;
		try {
			JSONObject obj = new JSONObject(jsonCenter);
			JSONObject objData = obj.getJSONObject(JSONElement.responseData);
			Log.i("GetAuthen", "lastAccessed : "+ConnectApi.getJsonString(objData, JSONElement.lastAccessed));
			mValue = new Bundle();
			mValue.putString(JSONElement.passportNo, ConnectApi.getJsonString(objData, JSONElement.passportNo));
			mValue.putString(JSONElement.countryCode, ConnectApi.getJsonString(objData, JSONElement.countryCode));
			mValue.putString(JSONElement.email, ConnectApi.getJsonString(objData, JSONElement.email));
			mValue.putString(JSONElement.titleName, ConnectApi.getJsonString(objData, JSONElement.titleName));
			mValue.putString(JSONElement.birthDate, ConnectApi.getJsonString(objData, JSONElement.birthDate));
			mValue.putString(JSONElement.contractNo, ConnectApi.getJsonString(objData, JSONElement.contractNo));
			mValue.putString(JSONElement.indcForm, ConnectApi.getJsonString(objData, JSONElement.indcForm));
			mValue.putString(JSONElement.spouseBirthDate, ConnectApi.getJsonString(objData, JSONElement.spouseBirthDate));
			mValue.putString(JSONElement.passportNo, ConnectApi.getJsonString(objData, JSONElement.passportNo));
			mValue.putString(JSONElement.spousePassportNo, ConnectApi.getJsonString(objData, JSONElement.spousePassportNo));
			mValue.putString(JSONElement.spouseCountryCode, ConnectApi.getJsonString(objData, JSONElement.spouseCountryCode));
			mValue.putString(JSONElement.nid, ConnectApi.getJsonString(objData, JSONElement.nid));
			mValue.putString(JSONElement.name, ConnectApi.getJsonString(objData, JSONElement.name));
			mValue.putString(JSONElement.surname, ConnectApi.getJsonString(objData, JSONElement.surname));
			mValue.putString(JSONElement.buildName, ConnectApi.getJsonString(objData, JSONElement.buildName));
			mValue.putString(JSONElement.roomNo, ConnectApi.getJsonString(objData, JSONElement.roomNo));
			mValue.putString(JSONElement.passportNo, ConnectApi.getJsonString(objData, JSONElement.passportNo));
			mValue.putString(JSONElement.floorNo, ConnectApi.getJsonString(objData, JSONElement.floorNo));
			mValue.putString(JSONElement.addressNo, ConnectApi.getJsonString(objData, JSONElement.addressNo));
			mValue.putString(JSONElement.soi, ConnectApi.getJsonString(objData, JSONElement.soi));
			mValue.putString(JSONElement.village, ConnectApi.getJsonString(objData, JSONElement.village));
			mValue.putString(JSONElement.mooNo, ConnectApi.getJsonString(objData, JSONElement.mooNo));
			mValue.putString(JSONElement.street, ConnectApi.getJsonString(objData, JSONElement.street));
			mValue.putString(JSONElement.tambol, ConnectApi.getJsonString(objData, JSONElement.tambol));
			mValue.putString(JSONElement.amphur, ConnectApi.getJsonString(objData, JSONElement.amphur));
			mValue.putString(JSONElement.province, ConnectApi.getJsonString(objData, JSONElement.province));
			mValue.putString(JSONElement.postcode, ConnectApi.getJsonString(objData, JSONElement.postcode));
			mValue.putString(JSONElement.taxpayerStatus, ConnectApi.getJsonString(objData, JSONElement.taxpayerStatus));
			mValue.putString(JSONElement.spouseStatus, ConnectApi.getJsonString(objData, JSONElement.spouseStatus));
			mValue.putString(JSONElement.marryStatus, ConnectApi.getJsonString(objData, JSONElement.marryStatus));
			mValue.putString(JSONElement.spouseNid, ConnectApi.getJsonString(objData, JSONElement.spouseNid));
			mValue.putString(JSONElement.spouseName, ConnectApi.getJsonString(objData, JSONElement.spouseName));
			mValue.putString(JSONElement.spouseSurname, ConnectApi.getJsonString(objData, JSONElement.spouseSurname));
			mValue.putString(JSONElement.childNoStudy, ConnectApi.getJsonString(objData, JSONElement.childNoStudy));
			mValue.putString(JSONElement.childStudy, ConnectApi.getJsonString(objData, JSONElement.childStudy));
			mValue.putString(JSONElement.txpFatherPin, ConnectApi.getJsonString(objData, JSONElement.txpFatherPin));
			mValue.putString(JSONElement.txpMotherPin, ConnectApi.getJsonString(objData, JSONElement.txpMotherPin));
			mValue.putString(JSONElement.spouseFatherPin, ConnectApi.getJsonString(objData, JSONElement.spouseFatherPin));
			mValue.putString(JSONElement.spouseMotherPin, ConnectApi.getJsonString(objData, JSONElement.spouseMotherPin));
			mValue.putString(JSONElement.authenKey, ConnectApi.getJsonString(objData, JSONElement.authenKey));
			mValue.putString(JSONElement.thaiNation, ConnectApi.getJsonString(objData, JSONElement.thaiNation));
			mValue.putString(JSONElement.lastAccessed, ConnectApi.getJsonString(objData, JSONElement.lastAccessed));
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return mValue;
	}
}
