package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;

import com.google.gson.Gson;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.req_datamodels.MRequest_TermsAndConditions;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.GetAuthen;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.SharedPref;

public class TermsAndConditions extends Activity implements OnClickListener {

	TextView tvTermsAndConditions;
	ButtonCustom btAccept;
	ButtonCustom btCancel;
	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		getDataCenter();
		setView();

	}

	private void setView() {
		setContentView(R.layout.terms_and_conditions);
		tvTermsAndConditions = (TextView) findViewById(R.id.tvTermsAndConditions);
		// tvTermsAndConditions.setText(getString(R.string.lang_th_forgetpassword_termsandconditions_content));
		btAccept = (ButtonCustom) findViewById(R.id.btAccept);
		btAccept.setOnClickListener(this);
		btAccept.setTypeface(null,Typeface.BOLD);
//		btAccept.setDefault();
		btCancel = (ButtonCustom) findViewById(R.id.btCancel);
//		btCancel.setDefault();
		btCancel.setOnClickListener(this);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.hideBack();
		topBar.setTitle(getString(R.string.label_condition));
	}

	Bundle mValue = new Bundle();

	private void getDataCenter() {
		mValue = GetAuthen.dataCenter(new SharedPref(TermsAndConditions.this).getProfile());
		SavedInstance.map.put(SavedInstance.VALUE, mValue);
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (btAccept.equals(v)) {
			new saveTermsAndConditions().execute();
		} else if (btCancel.equals(v)) {
			finish();
			overridePendingTransition(0, R.anim.slide_out_right);
		}
	}

	private class saveTermsAndConditions extends AsyncTask<String, Void, CommonResponseRD> {
		PopupDialog popup = new PopupDialog(TermsAndConditions.this);
		DialogProcess dialog = new DialogProcess(TermsAndConditions.this);
		ConnectApi connApi = new ConnectApi(TermsAndConditions.this);
		MRequest_TermsAndConditions terms = new MRequest_TermsAndConditions();
		String JSONObjSend;

		public saveTermsAndConditions() {
			terms.nid = mValue.getString(JSONElement.nid);
			terms.deviceID = new GetDeviceID(TermsAndConditions.this).getDeviceID();
		}

		@Override
		protected void onPreExecute() {
			// TODO Auto-generated method stub
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected CommonResponseRD doInBackground(String... params) {
			JSONObjSend = new Gson().toJson(terms);
			CommonResponseRD rs = connApi.saveTermsAndConditions(JSONObjSend);
			return rs;
		}

		@Override
		protected void onPostExecute(CommonResponseRD result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show("", getString(R.string.system_error));
			} else {
				result.responseCode = "0";
				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					Intent intent = new Intent(TermsAndConditions.this, MainEFilling.class);
					startActivityForResult(intent, 0);
					overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
				} else {
					popup.show(result.responseMessage);
				}
			}

		}
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		setResult(99);
		finish();
	}
}
