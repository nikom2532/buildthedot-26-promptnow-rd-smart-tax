package com.revenuedepartment.app;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonRequestRD;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.datapackages.P_CheckUpdateVersion;
import com.revenuedepartment.datapackages.P_Login;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.Format;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.GetVersionApp;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.req_datamodels.MRequest_Authen;
import com.revenuedepartment.req_datamodels.MRequest_CheckNewUser;
import com.revenuedepartment.req_datamodels.MRequest_CheckVersion;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.GetMessageError;
import com.revenuedepartment.service.SharedPref;
import com.revenuedepartment.service.SharedPref2;
import com.revenuedepartment.service.checkOnline;

public class Login_E_Filing extends Activity implements OnClickListener {

	ImageView ic_efilling;
	Button btLogin, btForgotPassword;
	EditText etNid, etPassword;
	TextView txNid;
	TextViewCustom label_efilling; 
//	TextViewCustom label_show_message;
	LinearLayout LinearLayoutBtSuggest;

	int STEP_CHECK = 0;
	int STEP_LOGIN = 1;
	int CURRENT_STEP = STEP_CHECK;
	public static int RESULT_RESETPASSWORD = 1002;
	TopBar topBar;
	PopupDialog popup = new PopupDialog(Login_E_Filing.this);
	GetMessageError messageError;
	SharedPref2 Pref2 = new SharedPref2(Login_E_Filing.this);

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		CommonRequestRD.LANG = "th";
		setView();

		if (!checkOnline.check(Login_E_Filing.this)) {
			new PopupDialog(Login_E_Filing.this).show("", getString(R.string.alert_no_network));
		} else {
			new requestCheckVersion().execute();
		}
	}

	public void setView() {
		setContentView(R.layout.login_e_filing);

		messageError = new GetMessageError(Login_E_Filing.this);

		btLogin = (Button) findViewById(R.id.btLogin);
		btLogin.setOnClickListener(this);

		btForgotPassword = (Button) findViewById(R.id.btForgotPassword);
		btForgotPassword.setOnClickListener(this);

		label_efilling = (TextViewCustom) findViewById(R.id.label_efilling);
//		label_show_message = (TextViewCustom) findViewById(R.id.label_show_message);
		ic_efilling = (ImageView) findViewById(R.id.ic_efilling);

		etNid = (EditText) findViewById(R.id.etNid);
		etNid.addTextChangedListener(etNidFormat);

		etPassword = (EditText) findViewById(R.id.etPassword);
		etPassword.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);

		txNid = (TextView) findViewById(R.id.txNid);

		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.hideBack();
		topBar.setTitle(getString(R.string.label_efilling));
		topBar.setImageRight(R.drawable.icon_setting, new OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Login_E_Filing.this, FillingSitting.class);
				startActivityForResult(intent, 0);
				overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
			}
		});
		
		LinearLayoutBtSuggest = (LinearLayout) findViewById(R.id.LinearLayoutBtSuggest);
		
		// Test
//		etNid.setText("3-7501-00119-10-5");
		
		//nid for registered
		etNid.setText("0-9910-00037-70-5");
		
		//nid for nonregistered
//		etNid.setText("3-1006-00196-69-4");
		
		etPassword.setText("W1xckWyP");
	}

	private void setTxTitleBar(String message) {
		// TextViewCustom txTitleBar = (TextViewCustom)
		// findViewById(R.id.txTitleBar);
		// txTitleBar.setText(message);
	}

	private void setTxTitle(String message) {
		TextViewCustom txTitle = (TextViewCustom) findViewById(R.id.txTitle);
		txTitle.setTextChangeLanguage(message);
	}

	private void showStepLogin() {
		CURRENT_STEP = STEP_LOGIN;
		etNid.setEnabled(false);
		etPassword.setVisibility(View.VISIBLE);
		etPassword.requestFocus();
		btForgotPassword.setVisibility(View.VISIBLE);
		setTxTitleBar(getString(R.string.txInSystem));
		setTxTitle(getString(R.string.label_input_password));
		txNid.setVisibility(View.VISIBLE);
		txNid.setText(etNid.getText().toString());
		
		etNid.setVisibility(View.GONE);
		label_efilling.setVisibility(View.VISIBLE);
		label_efilling.setTextChangeLanguage(getString(R.string.label_wellcome));
//		label_show_message.setVisibility(View.GONE);
		ic_efilling.setVisibility(View.GONE);
		LinearLayoutBtSuggest.setVisibility(View.GONE);
		((View) (View) findViewById(R.id.vLineForgot)).setVisibility(View.VISIBLE);
		topBar.clickBack(new OnClickListener() {

			@Override
			public void onClick(View v) {
				showStepCheck();
			}
		});
	}

	private void showStepCheck() {
		CURRENT_STEP = STEP_CHECK;
		etNid.setText("");
		etNid.setEnabled(true);
		etPassword.setVisibility(View.GONE);
		btForgotPassword.setVisibility(View.GONE);
		txNid.setVisibility(View.GONE);
		etNid.setVisibility(View.VISIBLE);
		label_efilling.setVisibility(View.GONE);
//		label_show_message.setVisibility(View.VISIBLE);
		ic_efilling.setVisibility(View.VISIBLE);
		LinearLayoutBtSuggest.setVisibility(View.VISIBLE);
		((View) (View) findViewById(R.id.vLineForgot)).setVisibility(View.GONE);
		topBar.hideBack();
	}

	// TODO checkNewUser;
	private class requestCheckNewUser extends AsyncTask<String, Void, P_ChchkNewUser> {

		DialogProcess dialog = new DialogProcess(Login_E_Filing.this);
		ConnectApi connApi = new ConnectApi(Login_E_Filing.this);
		MRequest_CheckNewUser checkNewUser = new MRequest_CheckNewUser();
		String JSONObjSend;

		public requestCheckNewUser() {
			checkNewUser.nid = Format.spitNid(etNid.getText().toString());
			checkNewUser.deviceID = new GetDeviceID(Login_E_Filing.this).getDeviceID();
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_ChchkNewUser doInBackground(String... params) {
			// boolean boo_key = connApi.getKeyExchange();
			// // writeLog.LogV("boo_key_CheckNewUser",
			// String.valueOf(boo_key));
			// if (boo_key) {
			checkNewUser.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(checkNewUser);
			P_ChchkNewUser pCheckNewUser = connApi.requestCheckNewUser(JSONObjSend);
			// writeLog.LogV("pCheckNewUser", pCheckNewUser.toString());
			return pCheckNewUser;
			// } else {
			// return null;
			// }
		}

		@Override
		protected void onPostExecute(P_ChchkNewUser result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show("", getString(R.string.system_error));
			} else {
				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					if (result.responseData.status.equals(ConfigApp.CODE_STATUS_OLDUSER)) {
						writeLog.LogV("result.responseData.status.equals(ConfigApp.CODE_STATUS_OLDUSER)",
								String.valueOf(result.responseData.status.equals(ConfigApp.CODE_STATUS_OLDUSER)));
						showStepLogin();
					} else if (result.responseData.status.equals(ConfigApp.CODE_STATUS_NEWUSER)) {
						showStepCheck();

						SharedPref Pref = new SharedPref(Login_E_Filing.this);
						
						Pref.setRegisterNewUserThaiFlag(result.responseData.thaiNation);
						
//						writeLog.LogV("RegisterNewUserNid", Pref2.getString("RegisterNewUserNid"));
//						writeLog.LogV("RegisterNewUserThaiFlag", Pref2.getString("RegisterNewUserThaiFlag"));
						writeLog.LogV("login", "yes");

						Intent intent = new Intent(Login_E_Filing.this, RegisterStep1.class);
						startActivityForResult(intent, 0);
						overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
					}
				} else {
					popup.show("", result.responseMessage);
				}
			}
		}
	}

	// TODO Authen;
	private class requestLogin extends AsyncTask<String, Void, P_Login> {

		DialogProcess dialog = new DialogProcess(Login_E_Filing.this);
		ConnectApi connApi = new ConnectApi(Login_E_Filing.this);
		MRequest_Authen Authen = new MRequest_Authen();
		String JSONObjSend;

		public requestLogin() {
			Authen.nid = Format.spitNid(etNid.getText().toString());
			Authen.deviceID = new GetDeviceID(Login_E_Filing.this).getDeviceID();
			Authen.password = etPassword.getText().toString();
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_Login doInBackground(String... params) {
			Authen.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(Authen);
			P_Login pLogin = connApi.requestLogin(JSONObjSend);
			return pLogin;
		}

		@Override
		protected void onPostExecute(P_Login result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show("", getString(R.string.system_error));
			} else {
				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					SharedPref pref = new SharedPref(Login_E_Filing.this);
					pref.setProfile(result.getTemp_json_data());
					Intent intent = new Intent(Login_E_Filing.this, TermsAndConditions.class);
					startActivityForResult(intent, 0);
					overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
				} else {
					popup.show(result.responseMessage);
				}
			}
		}
	}

	// TODO check Application version
	private class requestCheckVersion extends AsyncTask<String, Void, P_CheckUpdateVersion> {

		DialogProcess dialog = new DialogProcess(Login_E_Filing.this);
		ConnectApi connApi = new ConnectApi(Login_E_Filing.this);
		MRequest_CheckVersion checkVersion = new MRequest_CheckVersion();
		String JSONObjSend;

		public requestCheckVersion() {
			checkVersion.version = new GetVersionApp(Login_E_Filing.this).getVersion();
			checkVersion.deviceID = new GetDeviceID(Login_E_Filing.this).getDeviceID();
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_CheckUpdateVersion doInBackground(String... params) {
			boolean boo_key = connApi.getKeyExchange();
			// writeLog.LogV("boo_key_CheckNewUser", String.valueOf(boo_key));
			if (boo_key) {
				checkVersion.sessionID = PromptnowCommandData.JSESSIONID;
				JSONObjSend = new Gson().toJson(checkVersion);
				P_CheckUpdateVersion pCheckVersion = connApi.checkUpdateVersion(JSONObjSend);
				return pCheckVersion;
			} else {
				return null;
			}
		}

		@Override
		protected void onPostExecute(final P_CheckUpdateVersion result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show("", getString(R.string.system_error));
				writeLog.LogV("error", "error");
			} else {
				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					if (result.update.equals("Y")) {
						popup.show(result.newVersion, getString(R.string.label_ok), new DialogInterface.OnClickListener() {

							@Override
							public void onClick(DialogInterface dialog, int which) {
								if (result.url != null && !result.url.equals("")) {
									Uri uri = Uri.parse(result.url);
									Intent intent = new Intent(Intent.ACTION_VIEW, uri);
									startActivity(intent);
								}
							}
						});

					} else if (result.update.equals("N")) {

					}
				} else {
					popup.show(result.responseMessage);
				}
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO onClick page
		if (btLogin.equals(v)) {
			
			SharedPref Pref = new SharedPref(Login_E_Filing.this);
//			Pref2.setString("RegisterNewUserNid", etNid.getText().toString());
			Pref.setRegisterNewUserNid(etNid.getText().toString());
			
			if (CURRENT_STEP == STEP_CHECK) {

				int countEtNid = 0;
				for (int i = 0, len = etNid.getText().toString().length(); i < len; i++) {
					if (Character.isDigit(etNid.getText().toString().charAt(i))) {
						countEtNid++;
					}
				}

				if (etNid.getText().toString().equalsIgnoreCase("")) {
					popup.show("", messageError.getFieldMessage("nidEmpty"));
					etNid.requestFocus();
					return;
				} else if (countEtNid != 13) {
					popup.show("", messageError.getFieldMessage("nidWrong"));
					etNid.requestFocus();
					return;
				} else {
					int repeatNid = 0;
					int i = 1;
					for (i = 1; i < 17; i++) {
						if (etNid.getText().toString().charAt(0) == etNid.getText().toString().charAt(i)) {
							repeatNid++;
						}
					}
					if (repeatNid == 12) {
						popup.show("", "เลขประจำตัวประชาชนต้องไม่ซ้ำกัน 13 หลัก");
						etNid.requestFocus();
						return;
					} else {

						if (!checkOnline.check(Login_E_Filing.this)) {
							new PopupDialog(Login_E_Filing.this).show("", getString(R.string.alert_no_network));
						} else {
							new requestCheckNewUser().execute();
						}

					}
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
						popup.show("", "โปรดใส่รหัสผ่านให้ครบ 8 หลัก");
						etPassword.requestFocus();
						return;
					} else {
						if (!checkOnline.check(Login_E_Filing.this)) {
							new PopupDialog(Login_E_Filing.this).show("", getString(R.string.alert_no_network));
						} else {
							new requestLogin().execute();
						}
					}
				}
			}
		}
		if (btForgotPassword.equals(v)) {
			// writeLog.LogV("result", result.getResponseStatus());

//			SharedPref2 FrogetPassPref = new SharedPref2(Login_E_Filing.this);
			SharedPref ForgetPassPref2 = new SharedPref(Login_E_Filing.this);
			
//			FrogetPassPref.setString("LoginEFillingNid", etNid.getText().toString());
			ForgetPassPref2.setLoginEFillingNid(etNid.getText().toString());

			Intent intent = new Intent(Login_E_Filing.this, ResetPasswordStep1.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
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

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == Login_E_Filing.RESULT_RESETPASSWORD) {
		}
		if (resultCode == 99) {
			finish();
		} else {
			setView();
		}
	}
}
