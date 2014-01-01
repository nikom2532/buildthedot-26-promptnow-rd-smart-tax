package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.datapackages.P_Login;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.GetAuthen;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.SharedPref;

public class Login_E_Filing extends Activity implements OnClickListener {

	Button btLogin, btForgotPassword;
	EditText etNid, etPassword;
	TextView txNid;

	int STEP_CHECK = 0;
	int STEP_LOGIN = 1;
	int CURRENT_STEP = STEP_CHECK;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.login_e_filing);

		btLogin = (Button) findViewById(R.id.btLogin);
		btLogin.setOnClickListener(this);

		btForgotPassword = (Button) findViewById(R.id.btForgotPassword);
		btForgotPassword.setOnClickListener(this);

		etNid = (EditText) findViewById(R.id.etNid);
		etNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etNid.addTextChangedListener(etNidFormat);

		etPassword = (EditText) findViewById(R.id.etPassword);
		etPassword.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
		// etPassword.addTextChangedListener(etNidFormat);

		txNid = (TextView) findViewById(R.id.txNid);
	}

	private void setTxTitleBar(String message) {
		TextViewCustom txTitleBar = (TextViewCustom) findViewById(R.id.txTitleBar);
		txTitleBar.setText(message);
	}

	private void setTxTitle(String message) {
		TextViewCustom txTitle = (TextViewCustom) findViewById(R.id.txTitle);
		txTitle.setText(message);
	}

	private void showStepLogin() {
		CURRENT_STEP = STEP_LOGIN;
		etNid.setEnabled(false);
		etPassword.setVisibility(View.VISIBLE);
		etPassword.requestFocus();
		btForgotPassword.setVisibility(View.VISIBLE);
		setTxTitleBar(getString(R.string.txInSystem));
		setTxTitle(getString(R.string.txNid));
		txNid.setVisibility(View.VISIBLE);
		txNid.setText(etNid.getText().toString());
		etNid.setVisibility(View.GONE);
	}

	private void showStepCheck() {
		CURRENT_STEP = STEP_CHECK;
		etNid.setEnabled(false);
		etPassword.setVisibility(View.GONE);
		btForgotPassword.setVisibility(View.GONE);
		txNid.setVisibility(View.GONE);
		etNid.setVisibility(View.VISIBLE);
	}

	private class requestCheckNewUser extends AsyncTask<String, Void, P_ChchkNewUser> {

		DialogProcess dialog = new DialogProcess(Login_E_Filing.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_ChchkNewUser doInBackground(String... params) {
			// ### Make json request (nid) ###
			String mJsonRequestEtNid = "";
			mJsonRequestEtNid += "{\"nid\":\"" + etNid.getText() + "\",\"version\":\"1.0.0\"}";

			// writeLog.LogV("mJsonRequestEtNid", mJsonRequestEtNid.toString());

			P_ChchkNewUser pCheckNewUser = new ConnectApi().requestCheckNewUser(mJsonRequestEtNid);

			// writeLog.LogV("pCheckNewUser",pCheckNewUser.getResponseData().toString());
			return pCheckNewUser;
		}

		@Override
		protected void onPostExecute(P_ChchkNewUser result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				// Count number Digit of etNid.getText()
				String s = etNid.getText().toString();
				int countEtNid = 0;
				for (int i = 0, len = s.length(); i < len; i++) {
					if (Character.isDigit(s.charAt(i))) {
						countEtNid++;
					}
				}
				// Validate Form == 13 number Digit?
				// writeLog.LogV("countEtNid", String.valueOf(countEtNid));

				// From Num Start here *****
				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					// writeLog.LogV("getResponseStatus=OK?",
					// result.getResponseData().getStatus());
					if (result.getResponseData().getStatus().equals(getString(R.string.status_olduser))) {

						// Step 2. Validate Check is new user?
						if (result.getResponseData().getStatus().equals("0")) {
							Intent intent = new Intent(Login_E_Filing.this, RegisterStep1.class);
							intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
							startActivityForResult(intent, 0);
						} else if (result.getResponseData().getStatus().equals("1")) {
							showStepLogin();
						}
						// End Step 2. Validate Check is new user?

					} else {
						showStepCheck();
						// Intent intent = new Intent(Login_E_Filing.this,
						// UpdateProfile.class);
						// intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
						// startActivityForResult(intent, 0);
					}
				} else {

				}
			}
		}
	}

	private class requestLogin extends AsyncTask<String, Void, P_Login> {

		DialogProcess dialog = new DialogProcess(Login_E_Filing.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_Login doInBackground(String... params) {
			P_Login pLogin = new ConnectApi().requestLogin();
			writeLog.LogV("pLogin", pLogin.getResponseStatus());

			return pLogin;
		}

		@Override
		protected void onPostExecute(P_Login result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					SharedPref pref = new SharedPref(Login_E_Filing.this);
					pref.setProfile(result.getTemp_json_data());
					Bundle mValue = new Bundle();
					GetAuthen.dataCenter(pref.getProfile());
					SavedInstance.map.put(SavedInstance.VALUE, mValue);
					Intent intent = new Intent(Login_E_Filing.this, TermsAndConditions.class);
					startActivity(intent);
					finish();
				} else {

				}
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO onClick page
		if (btLogin.equals(v)) {
			if (CURRENT_STEP == STEP_CHECK) {

				int countEtNid = 0;
				for (int i = 0, len = etNid.getText().toString().length(); i < len; i++) {
					if (Character.isDigit(etNid.getText().toString().charAt(i))) {
						countEtNid++;
					}
				}

				writeLog.LogV("countEtNid", String.valueOf(countEtNid));

				if (etNid.getText().toString().equalsIgnoreCase("")) {
					Toast.makeText(Login_E_Filing.this, "โปรดใส่เลขประจำตัวประชาชน", Toast.LENGTH_SHORT).show();
				} else if (countEtNid != 13) {
					writeLog.LogI("onClick", "requestCheckNewUser");
					Toast.makeText(Login_E_Filing.this, "โปรดใส่เลขประจำตัวประชาชนให้ครบ 13 หลัก", Toast.LENGTH_SHORT).show();
				} else {
					new requestCheckNewUser().execute();
				}
			} else {
				// writeLog.LogI("onClick","requestLogin");
				if (etPassword.getText().toString().equalsIgnoreCase("")) {
					Toast.makeText(Login_E_Filing.this, "โปรดใส่รหัสผ่าน", Toast.LENGTH_SHORT).show();
				} else {
					int countEtPassword = 0;
					for (int i = 0, len = etPassword.getText().toString().length(); i < len; i++) {
						countEtPassword++;
					}
					writeLog.LogV("countEtPassword", String.valueOf(countEtPassword));
					if (countEtPassword != 8) {
						Toast.makeText(Login_E_Filing.this, "โปรดใส่รหัสผ่านให้ครบ 8 หลัก", Toast.LENGTH_SHORT).show();
					} else {
						new requestLogin().execute();
					}
				}
			}
		}
		if (btForgotPassword.equals(v)) {
			// writeLog.LogV("result", result.getResponseStatus());

			SharedPref FrogetPassPref = new SharedPref(Login_E_Filing.this);
			FrogetPassPref.setString("LoginEFillingNid", etNid.getText().toString());

			Intent intent = new Intent(Login_E_Filing.this, ResetPasswordStep1.class);
			startActivity(intent);
			finish();
		}

	}

	// TextWatch is watch for make the validate for EditText, control how to key
	// in EditText
	TextWatcher etNidFormat = new TextWatcher() {
		int textlength = 0;

		@Override
		public void afterTextChanged(Editable s) {
			// TODO Auto-generated method stub

		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {
			// TODO Auto-generated method stub

		}

		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			// TODO Auto-generated method stub
			String text = etNid.getText().toString();
			textlength = etNid.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16) {
				etNid.setText(new StringBuilder(text).insert(text.length() - 1, "-").toString());
				etNid.setSelection(etNid.getText().length());
			}
		}
	};
}
