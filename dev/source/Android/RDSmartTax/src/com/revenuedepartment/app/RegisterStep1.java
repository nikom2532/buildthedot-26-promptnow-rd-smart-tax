package com.revenuedepartment.app;

import java.util.Calendar;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
//import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
//import android.widget.Toast;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_Login;
import com.revenuedepartment.datamodels.M_SaveRegister;
import com.revenuedepartment.function.DateUtils1;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.Format;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.req_datamodels.MRequest_SaveRegister;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.ElementMessage;
import com.revenuedepartment.service.GetMessageError;
import com.revenuedepartment.service.SharedPref;
import com.revenuedepartment.service.SharedPref2;

public class RegisterStep1 extends Activity implements OnClickListener {
	TopBar topbar;
	ButtonCustom btNext;
	TextView txNid;
//	EditTextCustom etNid;
	EditTextCustom etPassword, etPasswordAgain;
	EditTextCustom etEmail, etAnswer;
	EditTextCustom txName, txMiddleName, txSurName, txTelephone,
			txTelephoneExtension;
	EditTextCustom txFatherName, txMotherName;
	EditTextCustom txPassportNo;
	LinearLayout LayoutPassportNo;
	EditTextCustom txCountryCode;
	LinearLayout LayoutCountryCode;
	
	TextView tvFatherName, tvMotherName, tvPassportNo;
	Spinner etQuestion;
	// DatePicker dpBirthdate;
	Button btCalendar;

	static final int DATE_DIALOG_ID = 1;
	// date and time
	private int mYear, mYearCurr;
	private int mMonth, mMonthCurr;
	private int mDay, mDayCurr;

	SharedPref pref;
	SharedPref2 pref2;
	M_Login mData;
	String flagThPeople = null; // for check isThaiPeoples

	PopupDialog popup = new PopupDialog(RegisterStep1.this);
	GetMessageError messageError;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
		messageError = new GetMessageError(RegisterStep1.this);
	}

	public void setView() {
		setContentView(R.layout.registerstep1);
		topbar = (TopBar) findViewById(R.id.Topbar);
		topbar.setTitle(getString(R.string.txRegister));
		btNext = (ButtonCustom) findViewById(R.id.btNext);
		btNext.setDefault();
		btNext.setOnClickListener(this);
//		etNid = (EditTextCustom) findViewById(R.id.etNid);
//		etNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
//		writeLog.LogV("start", "setView");
//		etNid.addTextChangedListener(etNidFormat);
		txNid = (TextView) findViewById(R.id.txNid);
		
		pref2 = new SharedPref2(RegisterStep1.this);
//		pref2.setString("RegisterNewUserNid", "1-1111-11111-11-2");
//		txNid.setText( Format.formatNid(NewUserPref.getString("RegisterNewUserNid")) );
		txNid.setText(pref2.getString("RegisterNewUserNid"));
		
		etPassword = (EditTextCustom) findViewById(R.id.etPassword);
		etPassword.setInputType(InputType.TYPE_CLASS_TEXT
				| InputType.TYPE_TEXT_VARIATION_PASSWORD);
		etPasswordAgain = (EditTextCustom) findViewById(R.id.etPasswordAgain);
		etPasswordAgain.setInputType(InputType.TYPE_CLASS_TEXT
				| InputType.TYPE_TEXT_VARIATION_PASSWORD);

		etEmail = (EditTextCustom) findViewById(R.id.etEmail);
		etAnswer = (EditTextCustom) findViewById(R.id.etAnswer);
		// dpBirthdate = (DatePicker) findViewById(R.id.dpBirthdate);
		etQuestion = (Spinner) findViewById(R.id.etQuestion);
		getSpinnerQuestion();
		btCalendar = (Button) findViewById(R.id.btCalendar);
		btCalendar.setOnClickListener(this);

		final Calendar c = Calendar.getInstance();
		mYear = c.get(Calendar.YEAR);
		mMonth = c.get(Calendar.MONTH);
		mDay = c.get(Calendar.DAY_OF_MONTH);
		mYearCurr = c.get(Calendar.YEAR);
		mMonthCurr = c.get(Calendar.MONTH);
		mDayCurr = c.get(Calendar.DAY_OF_MONTH);

		// mYear = 2000;
		// mMonth = 0;
		// mDay = 1;

		txName = (EditTextCustom) findViewById(R.id.txName);
		txMiddleName = (EditTextCustom) findViewById(R.id.txMiddleName);
		txSurName = (EditTextCustom) findViewById(R.id.txSurName);
		txTelephone = (EditTextCustom) findViewById(R.id.txTelephone);
		txTelephone.setRawInputType(Configuration.KEYBOARD_QWERTY);
		txTelephone.addTextChangedListener(txTelephoneFormat);
		txTelephoneExtension = (EditTextCustom) findViewById(R.id.txTelephoneExtension);
		txTelephoneExtension.setRawInputType(Configuration.KEYBOARD_QWERTY);
		// txTelephoneExtension.addTextChangedListener(txTelephoneExtensionFormat);

		txFatherName = (EditTextCustom) findViewById(R.id.txFatherName);
		txMotherName = (EditTextCustom) findViewById(R.id.txMotherName);
		txPassportNo = (EditTextCustom) findViewById(R.id.txPassportNo);
		txCountryCode = (EditTextCustom) findViewById(R.id.txCountryCode);
		
		LayoutPassportNo = (LinearLayout) findViewById(R.id.LayoutPassportNo);
		LayoutCountryCode = (LinearLayout) findViewById(R.id.LayoutCountryCode);

		tvFatherName = (TextView) findViewById(R.id.tvFatherName);
		tvMotherName = (TextView) findViewById(R.id.tvMotherName);
		tvPassportNo = (TextView) findViewById(R.id.tvPassportNo);

		// pref = new SharedPref(RegisterStep1.this);
		// if (!pref.getProfile().equals(""))
		// mData = GetAuthen.getResponseData(pref.getProfile());
		//
		// if (mData != null) {
		//
		// }

		if (flagThPeople == "1") {
			LayoutPassportNo.setVisibility(View.GONE);
			LayoutCountryCode.setVisibility(View.GONE);
		} else if (flagThPeople == "0") {
			LayoutPassportNo.setVisibility(View.VISIBLE);
			LayoutCountryCode.setVisibility(View.VISIBLE);
		}
	}

	private void getSpinnerQuestion() {
		etQuestion = (Spinner) findViewById(R.id.etQuestion);
		ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this,
				android.R.layout.simple_spinner_item, android.R.id.text1);
		spinnerAdapter
				.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		etQuestion.setAdapter(spinnerAdapter);
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question1));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question2));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question3));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question4));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question5));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question6));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question7));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question8));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question9));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question10));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question11));
		spinnerAdapter
				.add(getString(R.string.lang_th_forgetpassword_no_have_email_question12));
		spinnerAdapter.notifyDataSetChanged();
	}

	@Override
	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case DATE_DIALOG_ID:
			return new DatePickerDialog(this, mDateSetListener, mYear, mMonth,
					mDay);
		}
		return null;
	}

	public static String pad(int c) {
		if (c >= 10)
			return String.valueOf(c);
		else
			return "0" + String.valueOf(c);
	}

	private DatePickerDialog.OnDateSetListener mDateSetListener = new DatePickerDialog.OnDateSetListener() {
		public void onDateSet(DatePicker view, int year, int monthOfYear,
				int dayOfMonth) {
			// TODO
			mYear = year;
			mMonth = monthOfYear;
			mDay = dayOfMonth;
			btCalendar.setText(new StringBuilder().append(pad(mDay))
					.append("/").append(pad(mMonth + 1)).append("/")
					.append(mYear + 543));
			selectDate = String.valueOf(mDay) + "-"
					+ String.valueOf(mMonth + 1) + "-" + String.valueOf(mYear);
			selectDate_TH = String.valueOf(mDay) + "/"
					+ String.valueOf(mMonth + 1) + "/" + String.valueOf(mYear);
		}
	};
	String selectDate, selectDate_TH;

	private class requestRegister extends
			AsyncTask<String, Void, M_SaveRegister> {

		DialogProcess dialog = new DialogProcess(RegisterStep1.this);
		ConnectApi connApi = new ConnectApi(RegisterStep1.this);
		MRequest_SaveRegister saveRegister = new MRequest_SaveRegister();
		String JSONObjSend;

		public requestRegister() {
			saveRegister.deviceID = new GetDeviceID(RegisterStep1.this).getDeviceID();
			saveRegister.nid = Format.spitNid(txNid.getText().toString());
			saveRegister.name = txName.getText().toString();
			saveRegister.surname = txSurName.getText().toString();
			saveRegister.birthDate = btCalendar.getText().toString();
			saveRegister.passportNo = txPassportNo.getText().toString();
			saveRegister.countryCode = txCountryCode.getText().toString();
			saveRegister.fatherName = txFatherName.getText().toString();
			saveRegister.motherName = txMotherName.getText().toString();
			saveRegister.telephone = txTelephone.getText().toString();
			saveRegister.password = txPassportNo.getText().toString();
//			saveRegister.questionId
			saveRegister.answer = etAnswer.getText().toString();
//			saveRegister.moiFlag
			saveRegister.middleName = txMiddleName.getText().toString(); 
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected M_SaveRegister doInBackground(String... params) {

			saveRegister.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(saveRegister);

			M_SaveRegister mRegisterSave = connApi.requestRegisterSave(JSONObjSend);
			// writeLog.LogV("pCheckNewUser", pCheckNewUser.toString());

			writeLog.LogV("requestRegisterSave", "4");

			return mRegisterSave;

			// M_RegisterSave mRegisterSave = new ConnectApi()
			// .requestRegisterSave();
			// writeLog.LogV("mRegisterSave",
			// mRegisterSave.getResponseStatus());
			//
			// return mRegisterSave;
		}

		@Override
		protected void onPostExecute(M_SaveRegister result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				writeLog.LogV("onpost", "null");
			} else {
				writeLog.LogV("onpost", "onpost");
				// writeLog.LogV("ResponseStatus", result.getResponseStatus());
				// result.setResponseStatus("CONFIRM");
				// writeLog.LogV("result.responseStatus",
				// result.responseStatus);
				
				// if (result.getResponseStatus().equals("CONFIRM")) {
				// if(result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
				if(result.responseStatus.equals("CONFIRM"))
				  {
					PopupDialog popupRegisterSave = new PopupDialog(RegisterStep1.this); 
					popupRegisterSave.alert2Button(
							getString(R.string.lang_th_register_popup_message),getString(R.string.lang_th_register_popup_yes),
							getString(R.string.lang_th_register_popup_no), new DialogInterface.OnClickListener() {
				  
					  @Override 
					  public void onClick(DialogInterface dialog, int
					  which)
					  { new requestRegisterStep2().execute(); } }, new
					  DialogInterface.OnClickListener() {
					  
					  @Override public void onClick(DialogInterface dialog, int
					  which) { Intent intent = new Intent( RegisterStep1.this,
					  RegisterStep3.class);
					  intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					  startActivityForResult(intent, 0); } }); 
				  } 
				else if (result.responseStatus.equals(getString(R.string.OK))) {
					
				}
				else { 
					// SharedPref pref = new SharedPref(RegisterStep1.this);
					// pref.setProfile(result.getTemp_json_data());
					// Bundle mValue = new Bundle();
					// GetAuthen.dataCenter(pref.getProfile());
					// SavedInstance.map.put(SavedInstance.VALUE, mValue);
					// Intent intent = new Intent(RegisterStep1.this, TermsAndConditions.class);
					// startActivity(intent);
					// finish();
				  
					Intent intent = new Intent(RegisterStep1.this, RegisterStep3.class);
					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					startActivityForResult(intent, 0); 
				}
			}
		}
	}

	private class requestRegisterStep2 extends
			AsyncTask<String, Void, M_SaveRegister> {

		DialogProcess dialog = new DialogProcess(RegisterStep1.this);
		ConnectApi connApi = new ConnectApi(RegisterStep1.this);
		MRequest_SaveRegister saveRegister = new MRequest_SaveRegister();
		String JSONObjSend;
		
		public requestRegisterStep2() {
			saveRegister.deviceID = new GetDeviceID(RegisterStep1.this).getDeviceID();
			saveRegister.nid = Format.spitNid(txNid.getText().toString());
			saveRegister.name = txName.getText().toString();
			saveRegister.surname = txSurName.getText().toString();
			saveRegister.birthDate = btCalendar.getText().toString();
			saveRegister.passportNo = txPassportNo.getText().toString();
			saveRegister.countryCode = txCountryCode.getText().toString();
			saveRegister.fatherName = txFatherName.getText().toString();
			saveRegister.motherName = txMotherName.getText().toString();
			saveRegister.telephone = txTelephone.getText().toString();
			saveRegister.password = txPassportNo.getText().toString();
//			saveRegister.questionId
			saveRegister.answer = etAnswer.getText().toString();
//			saveRegister.moiFlag
			saveRegister.middleName = txMiddleName.getText().toString(); 
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected M_SaveRegister doInBackground(String... params) {

			// M_RegisterSave mRegisterSave = new
			// ConnectApi().requestRegisterSave();
			// writeLog.LogV("mRegisterSave",
			// mRegisterSave.getResporequestRegisterSavenseStatus());
			//
			// return mRegisterSave;
			
			saveRegister.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(saveRegister);
			M_SaveRegister mRegisterSave = new ConnectApi(RegisterStep1.this)
				.requestRegisterSave(JSONObjSend);
			
			return mRegisterSave;
		}

		@Override
		protected void onPostExecute(M_SaveRegister result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				
//				result.setResponseStatus("OK");
				result.responseStatus = CommonResponseRD.CODE_SUCCESS;
				
//				if (result.getResponseStatus().equals("OK")) {
				if (result.responseStatus.equals(CommonResponseRD.CODE_SUCCESS)) {
					Intent intent = new Intent(RegisterStep1.this,
							RegisterStep3.class);
					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					startActivityForResult(intent, 0);
				}
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub

//		String vEtNid = etNid.getText().toString();
		String vEtPassword = etPassword.getText().toString();
		String vEtPasswordAgain = etPasswordAgain.getText().toString();

		String vEtEmail, vEtAnswer;
		vEtEmail = etEmail.getText().toString();
		vEtAnswer = etAnswer.getText().toString();

		int CalendarChoose = DateUtils1.componentTimeToTimestamp(mYear, mMonth,
				mDay, 0, 0, 0);
		int CalendarCurr = DateUtils1.componentTimeToTimestamp(mYearCurr,
				mMonthCurr, mDayCurr, 0, 0, 0);

		// #############################
		// Email Regular Expression
		Boolean isEmailReg = null;
		try {
			String lineIwant = etEmail.getText().toString();
			String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
			Boolean b = lineIwant.matches(EMAIL_PATTERN);
			if (b == false) {
				isEmailReg = false;
			} else if (b == true) {
				isEmailReg = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			writeLog.LogV("ErrorEmailReg", e.getMessage());
		}
		// ##############################

		if (btNext.equals(v)) {
			
//			if (vEtNid.equalsIgnoreCase("")) { 
//				// Toast.makeText(RegisterStep1.this, "โปรดใส่เลขประจำตัวประชาชน",
//				// Toast.LENGTH_SHORT).show(); popup.show("",
//				messageError.getFieldMessage(ElementMessage.nidEmpty));
//				etNid.requestFocus(); return; 
//			}
			
			if (vEtPassword.equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this, "โปรดใส่รหัสผ่าน",
				// Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.passwordEmpty));
				etPassword.requestFocus();
				return;
			} else if (vEtPasswordAgain.equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this, "โปรดใส่รหัสผ่านอีกครั้ง",
				// Toast.LENGTH_SHORT).show();
				popup.show(
						"",
						messageError
								.getFieldMessage(ElementMessage.passwordEmpty)
								+ "อีกครั้ง");
				etPasswordAgain.requestFocus();
				return;
			} else if (!vEtPassword.equals(vEtPasswordAgain)) {
				// Toast.makeText(RegisterStep1.this,
				// "Password is not the same.",
				// Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.passwordNotEqual));
				etPasswordAgain.requestFocus();
				return;
			} else if (vEtEmail.equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this, "โปรดใส่ E-mail",
				// Toast.LENGTH_SHORT).show();
				popup.show("",
						messageError.getFieldMessage(ElementMessage.emailEmpty));
				etEmail.requestFocus();
				return;
			} else if (isEmailReg == false) {
				// Toast.makeText(RegisterStep1.this,
				// "E-mail ไม่ตรง Standard Format", Toast.LENGTH_SHORT)
				// .show();
				popup.show("", "E-mail ไม่ตรง Standard Format");
				etEmail.requestFocus();
				return;
			} else if (CalendarChoose == CalendarCurr) {
				// Toast.makeText(RegisterStep1.this, "โปรดใส่ วันเกิด",
				// Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.birthDateEmpty));
				return;
			} else if (CalendarChoose > CalendarCurr) {
				// writeLog.LogV("CalendarChoose",
				// String.valueOf(CalendarChoose));
				// Toast.makeText(RegisterStep1.this,
				// "วันเกิด จะไม่เป็นปัจจุบัน หรือ อนาคต",
				// Toast.LENGTH_SHORT).show();
				popup.show("", "วันเกิด จะไม่เป็นปัจจุบัน หรือ อนาคต");
				return;
			} else if (vEtAnswer.equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this, "โปรดใส่คำตอบ",
				// Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.answerEmpty));
				etAnswer.requestFocus();
				return;
			} else if (txName.getText().toString().equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this,
				// "โปรดใส่ชื่อ (ไม่ต้องระบุคำนำหน้าชื่อ)",
				// Toast.LENGTH_SHORT).show();
				popup.show("",
						messageError.getFieldMessage(ElementMessage.nameEmpty));
				txName.requestFocus();
				return;
			}
			// else if(txMiddleName.getText().toString().equalsIgnoreCase("")){
			// Toast.makeText(RegisterStep1.this, "โปรดใส่ชื่อกลาง",
			// Toast.LENGTH_SHORT).show();
			// }
			else if (txTelephone.getText().toString().equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this,
				// "โปรดใส่เบอร์โทรศัพท์มือถือที่สะดวกในการติดต่อ",
				// Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.contractNoEmpty));
				txTelephone.requestFocus();
				return;
			} else if ((!(txTelephone.getText().toString().charAt(0) == '0' && txTelephone
					.getText().toString().charAt(1) == '8') || (txTelephone
					.getText().toString().charAt(0) == '0' && txTelephone
					.getText().toString().charAt(1) == '9'))) {
				// Toast.makeText(RegisterStep1.this,
				// "โปรดใส่เบอร์โทรศัพท์มือถือ ที่ขึ้นต้นด้วย 08 09",
				// Toast.LENGTH_SHORT).show();
				popup.show("",
						"โปรดใส่เบอร์โทรศัพท์มือถือ ที่ขึ้นต้นด้วย 08 09");
				txTelephone.requestFocus();
				return;
			} else if (txTelephone.getText().toString().length() != 12) {
				// Toast.makeText(RegisterStep1.this,
				// "โปรดใส่เบอร์ต่อโทรศัพท์ ให้ครบ 10 หลัก",
				// Toast.LENGTH_SHORT).show();
				popup.show("", "โปรดใส่เบอร์ต่อโทรศัพท์ ให้ครบ 10 หลัก");
				txTelephone.requestFocus();
				return;
			}
			// else
			// if(txTelephoneExtension.getText().toString().equalsIgnoreCase("")){
			// Toast.makeText(RegisterStep1.this, "โปรดใส่เบอร์ต่อโทรศัพท์",
			// Toast.LENGTH_SHORT).show();
			// }
			else if (txFatherName.getText().toString().equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this,
				// "โปรดใส่ชื่อและชื่อสกุลบิดา", Toast.LENGTH_SHORT)
				// .show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.fatherNameEmpty));
				txFatherName.requestFocus();
				return;
			} else if (txMotherName.getText().toString().equalsIgnoreCase("")) {
				// Toast.makeText(RegisterStep1.this,
				// "โปรดใชื่อและชื่อสกุลมารดา",
				// Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.motherNameEmpty));
				txFatherName.requestFocus();
				return;
			} else {
				new requestRegister().execute();
			}
		} else if (v.equals(btCalendar)) {
			showDialog(DATE_DIALOG_ID);
		}
	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		overridePendingTransition(0, 0);
	}

	// txTelephoneFormat
	TextWatcher txTelephoneFormat = new TextWatcher() {
		int textlength = 0;

		@Override
		public void afterTextChanged(Editable s) {
			// TODO Auto-generated method stub

		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count,
				int after) {
			// TODO Auto-generated method stub

		}

		@Override
		public void onTextChanged(CharSequence s, int start, int before,
				int count) {
			// TODO Auto-generated method stub
			String text = txTelephone.getText().toString();
			textlength = txTelephone.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 3 || textlength == 8) {
				txTelephone.setText(new StringBuilder(text).insert(
						text.length() - 1, "-").toString());
				txTelephone.setSelection(txTelephone.getText().length());
			}
		}
	};
	/*
	 * TextWatcher txTelephoneExtensionFormat = new TextWatcher() { int
	 * textlength = 0;
	 * 
	 * @Override public void afterTextChanged(Editable s) { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 * 
	 * @Override public void beforeTextChanged(CharSequence s, int start, int
	 * count, int after) { // TODO Auto-generated method stub
	 * 
	 * }
	 * 
	 * @Override public void onTextChanged(CharSequence s, int start, int
	 * before, int count) { // TODO Auto-generated method stub String text =
	 * txTelephoneExtension.getText().toString(); textlength =
	 * txTelephoneExtension.getText().length();
	 * 
	 * if (text.endsWith("-")) return; if (textlength == 3 || textlength == 9) {
	 * txTelephoneExtension.setText(new StringBuilder(text).insert(text.length()
	 * - 1, "-").toString());
	 * txTelephoneExtension.setSelection(txTelephoneExtension
	 * .getText().length()); } } };
	 */
}