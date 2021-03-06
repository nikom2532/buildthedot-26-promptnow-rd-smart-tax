package com.revenuedepartment.app;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.promptnow.network.ConnectServer;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonRequestRD;
import com.promptnow.network.model.CommonResponseRD;
import com.promptnow.network.model.lgauthen.AuthenData;
import com.promptnow.network.model.lgauthen.AuthenRequest;
import com.promptnow.network.model.lgauthen.AuthenResponse;
import com.promptnow.network.model.lgchecknewuser.CheckNewUserRequest;
import com.promptnow.network.model.lgchecknewuser.CheckNewUserResponse;
import com.promptnow.network.model.pfupdateprofile.UpdateProfileResponse;
import com.promptnow.network.model.rqamphur.AmphurResponse;
import com.promptnow.network.model.rqprovince.ProvinceRequest;
import com.promptnow.network.model.rqprovince.ProvinceResponse;
import com.promptnow.network.service.AsyncTaskCompleteListener;
import com.promptnow.network.service.ServiceAsyn;
import com.promptnow.network.service.UtilTextWatcher;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.datapackages.P_CheckUpdateVersion;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.Format;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.GetVersionApp;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog; 
import com.revenuedepartment.req_datamodels.MRequest_CheckNewUser;
import com.revenuedepartment.req_datamodels.MRequest_CheckVersion;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.GetMessageError;
import com.revenuedepartment.service.SharedPref;
import com.revenuedepartment.service.SharedPref2;
import com.revenuedepartment.service.checkOnline;

public class Login_E_Filing extends Activity implements OnClickListener, AsyncTaskCompleteListener {

	ImageView ic_efilling,icon_setting;
	Button btLogin, btForgotPassword , btLogin_taxmanagement,btSuggest;
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
	SharedPref pref;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		CommonRequestRD.LANG = "TH";
		pref = new SharedPref(Login_E_Filing.this);
		setView();

		if (!checkOnline.check(Login_E_Filing.this)) {
			new PopupDialog(Login_E_Filing.this).show("", getString(R.string.alert_no_network));
		} else {
			new requestCheckVersion().execute();
		}
	}

	public void setView() {
		CommonRequestRD.LANG = "TH";
		setContentView(R.layout.login_e_filing);

		messageError = new GetMessageError(Login_E_Filing.this);

		btLogin = (Button) findViewById(R.id.btLogin);
		btLogin.setOnClickListener(this);
		
		btLogin_taxmanagement = (Button) findViewById(R.id.btLogin_taxmanagement);
		btLogin_taxmanagement.setOnClickListener(this);

		btForgotPassword = (Button) findViewById(R.id.btForgotPassword);
		btForgotPassword.setOnClickListener(this);

		label_efilling = (TextViewCustom) findViewById(R.id.label_efilling);
//		label_show_message = (TextViewCustom) findViewById(R.id.label_show_message);
		ic_efilling = (ImageView) findViewById(R.id.ic_efilling);
		icon_setting = (ImageView) findViewById(R.id.ivRight);

		etNid = (EditText) findViewById(R.id.etNid);
		etNid.addTextChangedListener(new UtilTextWatcher(etNid, this));

		etPassword = (EditText) findViewById(R.id.etPassword);
		etPassword.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);

		txNid = (TextView) findViewById(R.id.txNid);
		
		btSuggest = (Button) findViewById(R.id.btSuggest);
		btSuggest.setOnClickListener(this);
		
		

		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.hideBack();
//		topBar.setTitle(getString(R.string.label_efilling));
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
//		etNid.setText("0-9910-00037-70-5");
		etNid.setText("3-1104-00779-46-7");
		//nid for nonregistered
//		etNid.setText("3-1006-00196-69-4");
		
//		etPassword.setText("W1xckWyP");
		etPassword.setText("11111111"); 
		
		
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
	
	
//	second login
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
		btLogin_taxmanagement.setVisibility(View.GONE);	
		etNid.setVisibility(View.GONE);
		label_efilling.setVisibility(View.VISIBLE);
		label_efilling.setTextChangeLanguage(getString(R.string.label_wellcome));
//		label_show_message.setVisibility(View.GONE);
		ic_efilling.setVisibility(View.GONE);
		LinearLayoutBtSuggest.setVisibility(View.GONE);
//		((View) (View) findViewById(R.id.vLineForgot)).setVisibility(View.VISIBLE);
		icon_setting.setVisibility(View.GONE);
		topBar.clickBack(new OnClickListener() {

			@Override
			public void onClick(View v) {
				overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
				showStepCheck();
			}
		});
	}

	
//	first login
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
		btLogin_taxmanagement.setVisibility(View.VISIBLE);
		LinearLayoutBtSuggest.setVisibility(View.VISIBLE);
//		((View) (View) findViewById(R.id.vLineForgot)).setVisibility(View.GONE);
		topBar.hideBack();
		icon_setting.setVisibility(View.VISIBLE);
	}
  
	
	@Override
	public void onTaskComplete(String result, String service) { 
		
		Log.i("response", "response : "+result);
		
		try { 
			Gson g = new Gson(); 
			JSONObject jsonObject = new JSONObject(result); 
			Log.i("response", "service : "+service);
			if(service.equals("lg-authen")){
				AuthenResponse response =  g.fromJson(result, AuthenResponse.class);
				if (response.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					///// 20140217 lastaccessed ////// 
					DataForShared.lastAccessed = response.lastAccessed;
					AuthenData authenData = response.responseData;
					DataForShared.name 	= authenData.name;
					DataForShared.surname = authenData.surname;
					DataForShared.nid = authenData.nid;
					Log.i("Login_E_Filing", "nid : "+DataForShared.getNidFormat());
					
//					response.setTemp_json_data(jsonObject.toString());
					SharedPref pref = new SharedPref(Login_E_Filing.this);
					Log.i("response", "login response.getTemp_json_data() : "+jsonObject.toString());//response.getTemp_json_data());
					pref.setProfile(jsonObject.toString());//response.getTemp_json_data());
					Intent intent = new Intent(Login_E_Filing.this, TermsAndConditions.class);
					startActivityForResult(intent, 0);
					overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
				} else {
					popup.show(response.responseMessage);
				}  
			} else if (service.equals("lg-check-newuser")){
				CheckNewUserResponse response = g.fromJson(result, CheckNewUserResponse.class);
				if (response.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					if (response.responseData.status.equals(ConfigApp.CODE_STATUS_OLDUSER)) { 
						showStepLogin();
					} else if (response.responseData.status.equals(ConfigApp.CODE_STATUS_NEWUSER)) {
						showStepCheck();

						SharedPref Pref = new SharedPref(Login_E_Filing.this);
						
						Pref.setRegisterNewUserThaiFlag(response.responseData.thaiNation);
						  

						Intent intent = new Intent(Login_E_Filing.this, RegisterStep1.class);
						startActivityForResult(intent, 0);
						overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
					}
				} else {
					popup.show("", response.responseMessage);
				}
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
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
//							new requestCheckNewUser().execute();
							CheckNewUserRequest request = new CheckNewUserRequest();
							request.nid = etNid.getText().toString().replace("-", "");//Format.spitNid(etNid.getText().toString());
							request.deviceID = new GetDeviceID(Login_E_Filing.this).getDeviceID();
							request.sessionID = PromptnowCommandData.JSESSIONID;
							callService("lg-check-newuser", request);
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
//							new requestLogin().execute();
							AuthenRequest request = new AuthenRequest();
							request.nid = etNid.getText().toString().replace("-", "");//Format.spitNid(etNid.getText().toString());
							Log.i("request", "nid : "+request.nid);
							request.deviceID = new GetDeviceID(Login_E_Filing.this).getDeviceID();
							request.password = etPassword.getText().toString();
							request.sessionID = PromptnowCommandData.JSESSIONID;
							callService("lg-authen", request);
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
		}if (btSuggest.equals(v)) {
			Intent intent = new Intent(Login_E_Filing.this, InstructionsList.class);
			startActivityForResult(intent, 0);
			overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);
		}

	}
	
	private void callService(String service, Object request) {
//		ConnectServer server = new ConnectServer(this); 
//		boolean boo_getkey = server.getKeyExchange();
//		Log.d("debug","boolean_getkay : "+boo_getkey);
//		if(boo_getkey){ 
//			popup.show("boolean_getkay : "+boo_getkey);
			Gson g = new Gson(); 
			String json = g.toJson(request); 
			new ServiceAsyn(this, json, service).execute(); 
//		} else {
//			popup.show("invalid keyExchange");
//		}
	}  

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
