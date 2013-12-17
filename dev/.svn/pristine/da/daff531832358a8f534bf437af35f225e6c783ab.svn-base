package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.datapackages.P_Login;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConnectApi;

public class Login_E_Filing extends Activity implements OnClickListener {

	Button btLogin, btForgotPassword;
	EditText etNid, etPassword;

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
		etPassword = (EditText) findViewById(R.id.etPassword);
		etNid.addTextChangedListener(etNidFormat);
		etPassword.addTextChangedListener(etNidFormat);
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
		btForgotPassword.setVisibility(View.VISIBLE);
		setTxTitleBar(getString(R.string.txInSystem));
		setTxTitle(getString(R.string.txNid));
	}

	private void showStepCheck() {
		CURRENT_STEP = STEP_CHECK;
		etNid.setEnabled(false);
		etPassword.setVisibility(View.GONE);
		btForgotPassword.setVisibility(View.GONE);
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
			//### Make json request (nid) ###
			String mJsonRequestEtNid = "";
			mJsonRequestEtNid += "{\"nid\":\"" + etNid.getText() + "\",\"version\":\"1.0.0\"}";
			
			//writeLog.LogV("mJsonRequestEtNid", mJsonRequestEtNid.toString());
			
			P_ChchkNewUser pCheckNewUser = new ConnectApi().requestCheckNewUser(mJsonRequestEtNid);
			
			//writeLog.LogV("pCheckNewUser",pCheckNewUser.getResponseData().toString());
			
			return pCheckNewUser;
		}

		@Override
		protected void onPostExecute(P_ChchkNewUser result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				//Cound number Digit of etNid.getText()
				String s = etNid.getText().toString();
				int countEtNid = 0;
				for (int i = 0, len = s.length(); i < len; i++) {
				    if (Character.isDigit(s.charAt(i))) {
				    	countEtNid++;
				    }
				}
				//Validate Form == 13 number Digit?
				if(countEtNid == 13){
					//writeLog.LogV("countEtNid", String.valueOf(countEtNid));
					
					//From Num Start here *****
					if (result.getResponseStatus().equals(getString(R.string.OK))) {
						//writeLog.LogV("getResponseStatus=OK?", result.getResponseData().getStatus());
						if (result.getResponseData().getStatus().equals(getString(R.string.status_olduser))) {
							
							//Step 2. Validate Check is new user?
							if(result.getResponseData().getStatus().equals("0")){
								 Intent intent = new Intent(Login_E_Filing.this, RegisterStep1.class);
								 intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
								 startActivityForResult(intent, 0);
							}
							else if(result.getResponseData().getStatus().equals("1")){
								showStepLogin();
								
							}
							//End Step 2. Validate Check is new user?
							
						} else {
							showStepCheck();
							// Intent intent = new Intent(Login_E_Filing.this,
							// UpdateProfile.class);
							// intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
							// startActivityForResult(intent, 0);
						}
					} else {
						
					}
					//From Num End here *****
				}
				else{ //Validate Form != 13 number Digit?
					//writeLog.LogV("countEtNid", String.valueOf(countEtNid));
					//writeLog.LogV("13 number Digit?", "N");
					
					//Popup or else, for the way to show error
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
					//writeLog.LogV("result", result.getResponseStatus());
					Intent intent = new Intent(Login_E_Filing.this, MainEFilling.class);
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
				//writeLog.LogI("onClick","requestCheckNewUser");
				new requestCheckNewUser().execute();
			} else {
				//writeLog.LogI("onClick","requestLogin");
				new requestLogin().execute();
			}
		}
		if (btForgotPassword.equals(v)) {
			//writeLog.LogV("result", result.getResponseStatus());
			Intent intent = new Intent(Login_E_Filing.this, ResetPasswordHaveEmailRequest.class);
			startActivity(intent);
			finish();
		}
		
	}

	//TextWatch is watch for make the validate for EditText, control how to key in EditText
	int prevCursor = 0;
	TextWatcher etNidFormat = new TextWatcher() {
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			String text = etNid.getText().toString();
			//writeLog.LogV("onTextChanged", "etNidFormat");
			if (prevCursor <= 1) {
				if (text.length() == 1) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
			} else if (prevCursor <= 6) {
				if (text.length() == 6) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
			} else if (prevCursor <= 12) {
				if (text.length() == 12) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
			} else if (prevCursor <= 15) {
				if (text.length() == 15) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
			}

			etNid.requestFocus();
			prevCursor = text.length();
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {

		}

		@Override
		public void afterTextChanged(Editable s) {

		}
	};
}
