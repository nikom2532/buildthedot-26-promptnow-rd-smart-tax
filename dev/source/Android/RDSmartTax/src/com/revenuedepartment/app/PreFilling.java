package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_CheckTempTaxForm;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.req_datamodels.MRequest_CheckTempForm;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.GetAuthen;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.SharedPref;
import com.revenuedepartment.service.checkOnline;

public class PreFilling extends Activity implements OnClickListener {

	ButtonCustom btFilling;
	TopBar topBar;
	Bundle mValue = new Bundle();
	SharedPref pref;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		pref = new SharedPref(PreFilling.this);
		mValue = GetAuthen.dataCenter(pref.getProfile());
		SavedInstance.map.put(SavedInstance.VALUE, mValue);

		if (!checkOnline.check(PreFilling.this)) {
			new PopupDialog(PreFilling.this).show("", getString(R.string.alert_no_network));
		} else {
//			new getCheckTempForm().execute();
		}
	}

	private void setView() {
		setContentView(R.layout.pre_filling);
		btFilling = (ButtonCustom) findViewById(R.id.btFilling);
		btFilling.setDefault();
		btFilling.setOnClickListener(this);

		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_efilling));

		SavedInstance.map.put(SavedInstance.TMEP_VALUE, null);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btFilling)) {
			Intent intent = new Intent(PreFilling.this, Filling.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	}

	private class getCheckTempForm extends AsyncTask<String, Void, P_CheckTempTaxForm> {
		PopupDialog popup = new PopupDialog(PreFilling.this);
		DialogProcess dialog = new DialogProcess(PreFilling.this);
		ConnectApi connApi = new ConnectApi(PreFilling.this);
		MRequest_CheckTempForm tempForm = new MRequest_CheckTempForm();
		String JSONObjSend;

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
			tempForm.nid = mValue.getString(JSONElement.nid);
			tempForm.authenKey = mValue.getString(JSONElement.authenKey);
			tempForm.deviceID = new GetDeviceID(PreFilling.this).getDeviceID();
		}

		@Override
		protected P_CheckTempTaxForm doInBackground(String... params) {
			tempForm.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(tempForm);
			P_CheckTempTaxForm rs = connApi.requestTempTaxForm(JSONObjSend);
			return rs;
		}

		@Override
		protected void onPostExecute(P_CheckTempTaxForm result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show(getString(R.string.system_error));
			} else {
				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
				} else {
					popup.show(result.responseMessage);
				}
			}
		}
	}

	@Override
	// TODO onActivityResult
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == MainEFilling.RESULT_CLOSE) {
			setResult(MainEFilling.RESULT_CLOSE);
			finish();
		}
	}
}
