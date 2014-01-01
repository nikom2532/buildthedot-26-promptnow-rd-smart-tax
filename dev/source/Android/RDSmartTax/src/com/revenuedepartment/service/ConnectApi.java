package com.revenuedepartment.service;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.revenuedepartment.datamodels.M_RegisterSave;
import com.revenuedepartment.datamodels.M_ResetPasswordConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordEmailConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionChangeOnlyPassword;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.datapackages.P_CheckStatus;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.datapackages.P_InstructionDetail;
import com.revenuedepartment.datapackages.P_Instructions;
import com.revenuedepartment.datapackages.P_Login;
import com.revenuedepartment.datapackages.P_Print;
import com.revenuedepartment.datapackages.P_UpdateTaxCal;
import com.revenuedepartment.function.writeLog;

public class ConnectApi {

	public P_Filling requestGetPnd91() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/pnd91/getFormPnd91.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_Filling rs = new GetPnd91().getPnd91(responseText);
			return rs;
		}
		return null;
	}

	public P_ChchkNewUser requestCheckNewUser(String mJsonRequestEtNid) {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/checkNewUser.json", mJsonRequestEtNid);

		// writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText",
		// responseText.toString());

		if (responseText != null && !responseText.equals("")) {
			P_ChchkNewUser rs = new Gson().fromJson(responseText, P_ChchkNewUser.class);

			// writeLog.LogV("P_ChchkNewUser_userID",
			// rs.getResponseData().getUserId());

			return rs;
		}
		return null;
	}

	public M_ResetPasswordRequest mResetPasswordRequest(String mJsonRequest) {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/resetPasswordRequest_2.json", mJsonRequest);
		// writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText",
		// responseText.toString());
		if (responseText != null && !responseText.equals("")) {
			M_ResetPasswordRequest rs = new Gson().fromJson(responseText, M_ResetPasswordRequest.class);
			// writeLog.LogV("P_ChchkNewUser_userID",
			// rs.getResponseData().getUserId());
			return rs;
		}
		return null;
	}

	public M_ResetPasswordEmailConfirm mResetPasswordEmailConfirm(String mJsonRequest) {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/resetPasswordConfirm.json", mJsonRequest);
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
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/confirmQuestion.json", mJsonRequest);
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
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/changeOnlyPassword.json", mJsonRequest);
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

	public P_Login requestLogin() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/authen.json", "");

		writeLog.LogV("P_Login=requestLogin=responseText", responseText.toString());

		if (responseText != null && !responseText.equals("")) {
			P_Login rs = new GetAuthen().getAuthen(responseText);

			// writeLog.LogV("P_Login=requestLogin=rs", rs.toString());

			return rs;
		}
		return null;
	}

	public P_Login requestUpdateProfile() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/updateProfile.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_Login rs = new GetAuthen().getAuthen(responseText);
			return rs;
		}
		return null;
	}

	public P_Print requestPrint(String request) {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/pit/printFormReceipt.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_Print rs = new Gson().fromJson(responseText, P_Print.class);
			return rs;
		}
		return null;
	}

	public P_CheckStatus requestCheckStatus() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/4serve/checkStatus.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_CheckStatus rs = new Gson().fromJson(responseText, P_CheckStatus.class);
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
	
	public M_RegisterSave requestRegisterSave() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post
				.httpQuery(
						"http://kimhun55.com/llnun/TestServiceRD/mobile/register/save.json",
						"");

		if (responseText != null && !responseText.equals("")) {
			M_RegisterSave rs = new Gson().fromJson(responseText,
					M_RegisterSave.class);
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
