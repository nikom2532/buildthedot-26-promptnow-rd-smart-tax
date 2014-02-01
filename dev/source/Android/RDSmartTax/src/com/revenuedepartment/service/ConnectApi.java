package com.revenuedepartment.service;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.google.gson.Gson;
import com.promptnow.network.ConnectServer;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.datamodels.M_RegisterConfirm;
import com.revenuedepartment.datamodels.M_SaveRegister;
import com.revenuedepartment.datamodels.M_ResetPasswordConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordEmailConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionChangeOnlyPassword;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.datapackages.P_CheckStatus;
import com.revenuedepartment.datapackages.P_CheckTempTaxForm;
import com.revenuedepartment.datapackages.P_CheckUpdateVersion;
import com.revenuedepartment.datapackages.P_ChosenCounterService;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.datapackages.P_InstructionDetail;
import com.revenuedepartment.datapackages.P_Instructions;
import com.revenuedepartment.datapackages.P_Login;
import com.revenuedepartment.datapackages.P_Print;
import com.revenuedepartment.datapackages.P_UpdateTaxCal;
import com.revenuedepartment.function.writeLog;

public class ConnectApi {
	ConnectServer conn;
	Context context;
	String responseText;

	public ConnectApi(Context context) {
		conn = new ConnectServer(context);
	}

	public ConnectApi() {
	}

	public boolean getKeyExchange() {
		boolean isGet = conn.getKeyExchange();
		writeLog.LogD("key", PromptnowCommandData.JSESSIONID);
		return isGet;
	}

	public P_ChchkNewUser requestCheckNewUser(String requestcheckNewUser) {
		P_ChchkNewUser rs = new P_ChchkNewUser();
		try {
			responseText = conn.sendSecureDataServerJson(requestcheckNewUser.getBytes(), "lg-check-newuser");
			writeLog.LogD("requestCheckNewUser", responseText);

			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, P_ChchkNewUser.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public P_Login requestLogin(String requestAuthen) {
		responseText = conn.sendSecureDataServerJson(requestAuthen.getBytes(), "lg-authen");
		writeLog.LogD("requestLogin", responseText);
		if (responseText != null && !responseText.equals("")) {
			P_Login rs = new GetAuthen().getAuthen(responseText);
			return rs;
		}
		return null;
	}

	public P_Print requestPrint(String requestPrint) {
		P_Print rs = new P_Print();
		try {
			responseText = conn.sendSecureDataServerJson(requestPrint.getBytes(), "fl-print-formreceipt");
			writeLog.LogD("requestPrint", responseText);
			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, P_Print.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public P_CheckStatus requestCheckStatus(String requestCheckStatus) {
		P_CheckStatus rs = new P_CheckStatus();
		try {
			responseText = conn.sendSecureDataServerJson(requestCheckStatus.getBytes(), "fl-check-status");
			writeLog.LogD("requestCheckStatus", responseText);

			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, P_CheckStatus.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public P_Filling requestGetPnd91(String requestPND91) {
		P_Filling rs = new P_Filling();
		try {
			responseText = conn.sendSecureDataServerJson(requestPND91.getBytes(), "fl-get-formpnd91");
			writeLog.LogD("requestGetPnd91", responseText);
			GetPnd91 pnd91 = new GetPnd91();
			if (responseText != null && !responseText.equals("")) {
				rs = pnd91.getPnd91(responseText);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	// wait data model P_CheckTempTaxForm
	public P_CheckTempTaxForm requestTempTaxForm(String requestTempTaxForm) {
		P_CheckTempTaxForm rs = new P_CheckTempTaxForm();
		try {
			responseText = conn.sendSecureDataServerJson(requestTempTaxForm.getBytes(), "fl-check-temptaxform");
			writeLog.LogD("requestTempTaxForm", responseText);
			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, P_CheckTempTaxForm.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public CommonResponseRD saveTermsAndConditions(String requestSave) {
		responseText = conn.sendSecureDataServerJson(requestSave.getBytes(), "lg-save-termsconditionfirst");
		writeLog.LogD("saveTermsAndConditions", responseText);
		CommonResponseRD rs = null;
		if (responseText != null && !responseText.equals("")) {
			rs = new Gson().fromJson(responseText, CommonResponseRD.class);
		}
		return rs;
	}

	public CommonResponseRD deleteForm(String reqesttDelete) {
		CommonResponseRD rs = new CommonResponseRD();
		try {
			responseText = conn.sendSecureDataServerJson(reqesttDelete.getBytes(), "fl-update-pnd91caltax");
			writeLog.LogD("deleteForm", responseText);

			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, CommonResponseRD.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public void updatePnd91CalTax(String requestUpdate) {
		responseText = conn.sendSecureDataServerJson(requestUpdate.getBytes(), "fl-update-pnd91caltax");
		writeLog.LogD("saveTermsAndConditions", responseText);
		CommonResponseRD rs = null;
		if (responseText != null && !responseText.equals("")) {
			// rs = new Gson().fromJson(responseText, CommonResponseRD.class);
		}
	}

	public CommonResponseRD sendSatisfication(String requestSatisfication) {
		CommonResponseRD rs = new CommonResponseRD();
		try {
			responseText = conn.sendSecureDataServerJson(requestSatisfication.getBytes(), "sf-send-satisfication");
			writeLog.LogD("saveTermsAndConditions", responseText);

			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, CommonResponseRD.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public P_ChosenCounterService requestChosenCountService(String requestSatisfication) {
		P_ChosenCounterService rs = new P_ChosenCounterService();
		try {
			responseText = conn.sendSecureDataServerJson(requestSatisfication.getBytes(), "fl-chosen-countservice");
			writeLog.LogD("chosenCountService", responseText);

			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, P_ChosenCounterService.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public P_CheckUpdateVersion checkUpdateVersion(String requestUpdateVersion) {
		P_CheckUpdateVersion rs = new P_CheckUpdateVersion();
		try {
			responseText = conn.sendSecureDataServerJson(requestUpdateVersion.getBytes(), "lg-update-version");
			writeLog.LogD("checkUpdateVersion", responseText);
			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, P_CheckUpdateVersion.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public CommonResponseRD logOut(String requestLogout) {

		CommonResponseRD rs = new CommonResponseRD();
		try {
			responseText = conn.sendSecureDataServerJson(requestLogout.getBytes(), "lg-logout");
			writeLog.LogD("logOut", responseText);

			if (responseText != null && !responseText.equals("")) {
				rs = new Gson().fromJson(responseText, CommonResponseRD.class);
			}
		} catch (Exception e) {
			rs.responseMessage = responseText;
			e.printStackTrace();
		}
		return rs;
	}

	public M_ResetPasswordRequest mResetPasswordRequest(String mJsonRequest) {
//		HttpRequestPost post = new HttpRequestPost();
//		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/resetPasswordRequest_2.json", mJsonRequest);
		String responseText = conn.sendSecureDataServerJson(mJsonRequest.getBytes(), "fg-reset-password-request");
		
		if (responseText != null && !responseText.equals("")) {
			M_ResetPasswordRequest rs = new Gson().fromJson(responseText, M_ResetPasswordRequest.class);
			return rs;
		}
		return null;
	}

	public M_ResetPasswordEmailConfirm mResetPasswordEmailConfirm(String mJsonRequest) {
//		HttpRequestPost post = new HttpRequestPost();
//		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/resetPasswordConfirm.json", mJsonRequest);
		String responseText = conn.sendSecureDataServerJson(mJsonRequest.getBytes(), "fg-reset-password-confirm");
		// writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText",
		// responseText.toString());
		if (responseText != null && !responseText.equals("")) {
			M_ResetPasswordEmailConfirm rs = new Gson().fromJson(responseText, M_ResetPasswordEmailConfirm.class);
			// writeLog.LogV("P_ChchkNewUser_userID",
			// rs.getResponseData().getUserId());
			return rs;
		}
		return null;
	}

	public M_ResetPasswordQuestionConfirm mResetPasswordQuestionConfirm(String mJsonRequest) {
//		HttpRequestPost post = new HttpRequestPost();
//		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/confirmQuestion.json", mJsonRequest);
		String responseText = conn.sendSecureDataServerJson(mJsonRequest.getBytes(), "fg-confirm-question");
		// writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText",
		// responseText.toString());
		if (responseText != null && !responseText.equals("")) {
			M_ResetPasswordQuestionConfirm rs = new Gson().fromJson(responseText, M_ResetPasswordQuestionConfirm.class);
			// writeLog.LogV("P_ChchkNewUser_userID",
			// rs.getResponseData().getUserId());
			return rs;
		}
		return null;
	}

	// http://kimhun55.com/llnun/TestServiceRD/mobile/register/confirmQuestion.json

	public M_ResetPasswordQuestionChangeOnlyPassword mResetPasswordQuestionChangeOnlyPassword(String mJsonRequest) {
//		HttpRequestPost post = new HttpRequestPost();
//		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/changeOnlyPassword.json", mJsonRequest);
		String responseText = conn.sendSecureDataServerJson(mJsonRequest.getBytes(), "fg-change-onlypassword");
		// writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText",
		// responseText.toString());
		if (responseText != null && !responseText.equals("")) {
			M_ResetPasswordQuestionChangeOnlyPassword rs = new Gson().fromJson(responseText, M_ResetPasswordQuestionChangeOnlyPassword.class);
			// writeLog.LogV("P_ChchkNewUser_userID",
			// rs.getResponseData().getUserId());
			return rs;
		}
		return null;
	}

	public M_ResetPasswordConfirm mResetPasswordConfirm(String mJsonRequest) {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/confirmRequestPassword.json", mJsonRequest);
		// writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText",
		// responseText.toString());
		if (responseText != null && !responseText.equals("")) {
			M_ResetPasswordConfirm rs = new Gson().fromJson(responseText, M_ResetPasswordConfirm.class);
			// writeLog.LogV("P_ChchkNewUser_userID",
			// rs.getResponseData().getUserId());
			return rs;
		}
		return null;
	}

	public P_Login requestUpdateProfile(String mJsonRequest) {
//		HttpRequestPost post = new HttpRequestPost();
//		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/updateProfile.json", "");
		String responseText = conn.sendSecureDataServerJson(mJsonRequest.getBytes(), "pf-update-taxpayerprofile");
		if (responseText != null && !responseText.equals("")) {
			P_Login rs = new GetAuthen().getAuthen(responseText);
			return rs;
		}
		return null;
	}

	public P_Instructions requestInstructions() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/susanoo/getInstructions.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_Instructions rs = new Gson().fromJson(responseText, P_Instructions.class);
			return rs;
		}
		return null;
	}

	public P_InstructionDetail requestInstructionDetail() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/susanoo/getInstructionsDetail.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_InstructionDetail rs = new Gson().fromJson(responseText, P_InstructionDetail.class);
			return rs;
		}
		return null;
	}

	public P_UpdateTaxCal updatePnd91CalTax() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/pnd91/updatePnd91CalTax.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_UpdateTaxCal rs = new Gson().fromJson(responseText, P_UpdateTaxCal.class);
			return rs;
		}
		return null;
	}

	public M_SaveRegister requestRegisterSave(String requestRegisterSave) {
		// HttpRequestPost post = new HttpRequestPost();
		// String responseText =
		// post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/save.json",
		// "");

		writeLog.LogV("requestRegisterSave", "3.1");

		responseText = conn.sendSecureDataServerJson(requestRegisterSave.getBytes(), "rg-save-form");

		writeLog.LogV("requestRegisterSave", "3.2");

		if (responseText != null && !responseText.equals("")) {

			writeLog.LogV("requestRegisterSave", "3.3");

			M_SaveRegister rs = new Gson().fromJson(responseText, M_SaveRegister.class);

			writeLog.LogV("requestRegisterSave", "3.4");

			return rs;
		}
		return null;
	}
	
	public M_RegisterConfirm requestRegisterConfirm(String requestRegisterConfirm) {
		responseText = conn.sendSecureDataServerJson(requestRegisterConfirm.getBytes(), "rg-confirm-form");
		if (responseText != null && !responseText.equals("")) {
			M_RegisterConfirm rs = new Gson().fromJson(responseText, M_RegisterConfirm.class);
			return rs;
		}
		return null;
	}

	public static int getJsonInt(JSONObject obj, String name) {
		try {
			return obj.get(name) != null ? obj.getInt(name) : 0;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public static boolean hasElement(JSONObject obj, String name) {
		if (obj.has(name))
			return true;
		return false;
	}

	public static String getJsonString(JSONObject obj, String name) {
		try {
			if (hasElement(obj, name)) {
				writeLog.LogD(writeLog.TAG, (obj.get(name) != null ? obj.getString(name) : ""));
				return (obj.get(name) != null ? obj.getString(name) : "");
			} else {
				writeLog.LogD(writeLog.TAG, "");
				return "";
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static boolean getJsonBoolean(JSONObject obj, String name) {
		try {
			return obj.get(name) != null ? obj.getBoolean(name) : false;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return false;
	}
}
