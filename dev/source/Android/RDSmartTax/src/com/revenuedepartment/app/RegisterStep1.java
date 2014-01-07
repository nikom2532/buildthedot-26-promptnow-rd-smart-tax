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
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_Login;
import com.revenuedepartment.datamodels.M_RegisterSave;
import com.revenuedepartment.function.DateUtils1;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.SharedPref;

public class RegisterStep1 extends Activity implements OnClickListener {
	TopBar topbar;
	ButtonCustom btNext;
	TextView txNid;
	EditText etNid, etPassword, etPasswordAgain;
	EditText etEmail, etAnswer;
	EditText txName, txMiddleName, txSurName, txTelephone,
			txTelephoneExtension;
	EditText txFatherName, txMotherName, txPassportNo;
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
	M_Login mData;
	String flagThPeople = null; // for check isThaiPeoples

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.registerstep1);
		topbar = (TopBar) findViewById(R.id.Topbar);
		topbar.setTitle(getString(R.string.txRegister));
		btNext = (ButtonCustom) findViewById(R.id.btNext);
		btNext.setDefault();
		btNext.setOnClickListener(this);
		etNid = (EditText) findViewById(R.id.etNid);
		etNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etNid.addTextChangedListener(etNidFormat);
		txNid = (TextView) findViewById(R.id.txNid);

		etPassword = (EditText) findViewById(R.id.etPassword);
		etPassword.setInputType(InputType.TYPE_CLASS_TEXT
				| InputType.TYPE_TEXT_VARIATION_PASSWORD);
		etPasswordAgain = (EditText) findViewById(R.id.etPasswordAgain);
		etPasswordAgain.setInputType(InputType.TYPE_CLASS_TEXT
				| InputType.TYPE_TEXT_VARIATION_PASSWORD);

		etEmail = (EditText) findViewById(R.id.etEmail);
		etAnswer = (EditText) findViewById(R.id.etAnswer);
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

		txName = (EditText) findViewById(R.id.txName);
		txMiddleName = (EditText) findViewById(R.id.txMiddleName);
		txSurName = (EditText) findViewById(R.id.txSurName);
		txTelephone = (EditText) findViewById(R.id.txTelephone);
		txTelephone.setRawInputType(Configuration.KEYBOARD_QWERTY);
		txTelephone.addTextChangedListener(txTelephoneFormat);
		txTelephoneExtension = (EditText) findViewById(R.id.txTelephoneExtension);
		txTelephoneExtension.setRawInputType(Configuration.KEYBOARD_QWERTY);
		// txTelephoneExtension.addTextChangedListener(txTelephoneExtensionFormat);

		txFatherName = (EditText) findViewById(R.id.txFatherName);
		txMotherName = (EditText) findViewById(R.id.txMotherName);
		txPassportNo = (EditText) findViewById(R.id.txPassportNo);

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

		// #### Get from the Main_E_Filing.java ####
		SharedPref NewUserPref = new SharedPref(RegisterStep1.this);
		txNid.setText(NewUserPref.getString("RegisterNewUserNid"));
		flagThPeople = NewUserPref.getString("RegisterNewUserThaiNation");

		if (flagThPeople == "1") {
			tvFatherName.setVisibility(View.VISIBLE);
			tvMotherName.setVisibility(View.VISIBLE);
			tvPassportNo.setVisibility(View.GONE);
			txFatherName.setVisibility(View.VISIBLE);
			txMotherName.setVisibility(View.VISIBLE);
			txPassportNo.setVisibility(View.GONE);
		} else if (flagThPeople == "0") {
			tvFatherName.setVisibility(View.GONE);
			tvMotherName.setVisibility(View.GONE);
			tvPassportNo.setVisibility(View.VISIBLE);
			txFatherName.setVisibility(View.GONE);
			txMotherName.setVisibility(View.GONE);
			txPassportNo.setVisibility(View.VISIBLE);
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

	// //## This version is have no the future date in calendar
	// @Override
	// protected Dialog onCreateDialog(int id) {
	// switch (id) {
	// case DATE_DIALOG_ID:
	// DatePickerDialog _date = new DatePickerDialog(this, mDateSetListener,
	// mYear, mMonth, mDay){
	// @Override
	// public void onDateChanged(DatePicker view, int year, int monthOfYear, int
	// dayOfMonth)
	// {
	// if (year > mYear)
	// view.updateDate(mYear, mMonth, mDay);
	// if (monthOfYear > mMonth && year == mYear)
	// view.updateDate(mYear, mMonth, mDay);
	// if (dayOfMonth > mDay && year == mYear && monthOfYear == mMonth)
	// view.updateDate(mYear, mMonth, mDay);
	// }
	// };
	// return _date;
	// }
	// return null;
	// }

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
			AsyncTask<String, Void, M_RegisterSave> {

		DialogProcess dialog = new DialogProcess(RegisterStep1.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected M_RegisterSave doInBackground(String... params) {
			M_RegisterSave mRegisterSave = new ConnectApi()
					.requestRegisterSave();
			writeLog.LogV("mRegisterSave", mRegisterSave.getResponseStatus());

			return mRegisterSave;
		}

		@Override
		protected void onPostExecute(M_RegisterSave result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				result.setResponseStatus("CONFIRM");
				if (result.getResponseStatus().equals("CONFIRM")) {
					PopupDialog popupRegisterSave = new PopupDialog(
							RegisterStep1.this);
					popupRegisterSave.alert2Button(
							getString(R.string.lang_th_register_popup_message),
							getString(R.string.lang_th_register_popup_yes),
							getString(R.string.lang_th_register_popup_no),
							new DialogInterface.OnClickListener() {
								@Override
								public void onClick(DialogInterface dialog,
										int which) {
									new requestRegisterStep2().execute();
								}
							}, new DialogInterface.OnClickListener() {
								@Override
								public void onClick(DialogInterface dialog,
										int which) {
									Intent intent = new Intent(
											RegisterStep1.this,
											RegisterStep3.class);
									intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
									startActivityForResult(intent, 0);
								}
							});
				} else if (result.getResponseStatus().equals(
						getString(R.string.OK))) {
					// SharedPref pref = new SharedPref(RegisterStep1.this);
					// pref.setProfile(result.getTemp_json_data());
					// Bundle mValue = new Bundle();
					// GetAuthen.dataCenter(pref.getProfile());
					// SavedInstance.map.put(SavedInstance.VALUE, mValue);
					// Intent intent = new Intent(RegisterStep1.this,
					// TermsAndConditions.class);
					// startActivity(intent);
					// finish();

					Intent intent = new Intent(RegisterStep1.this,
							RegisterStep3.class);
					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					startActivityForResult(intent, 0);
				}
			}
		}
	}

	private class requestRegisterStep2 extends
			AsyncTask<String, Void, M_RegisterSave> {

		DialogProcess dialog = new DialogProcess(RegisterStep1.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected M_RegisterSave doInBackground(String... params) {
			M_RegisterSave mRegisterSave = new ConnectApi()
					.requestRegisterSave();
			writeLog.LogV("mRegisterSave", mRegisterSave.getResponseStatus());

			return mRegisterSave;
		}

		@Override
		protected void onPostExecute(M_RegisterSave result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				result.setResponseStatus("OK");
				if (result.getResponseStatus().equals("OK")) {
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

		String vEtNid = etNid.getText().toString();
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
			if (vEtNid.equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this, "โปรดใส่เลขประจำตัวประชาชน",
						Toast.LENGTH_SHORT).show();
			} else if (vEtPassword.equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this, "โปรดใส่รหัสผ่าน",
						Toast.LENGTH_SHORT).show();
			} else if (vEtPasswordAgain.equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this, "โปรดใส่รหัสผ่านอีกครั้ง",
						Toast.LENGTH_SHORT).show();
			} else if (!vEtPassword.equals(vEtPasswordAgain)) {
				Toast.makeText(RegisterStep1.this, "Password is not the same.",
						Toast.LENGTH_SHORT).show();
			} else if (vEtEmail.equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this, "โปรดใส่ E-mail",
						Toast.LENGTH_SHORT).show();
			} else if (isEmailReg == false) {
				Toast.makeText(RegisterStep1.this,
						"E-mail ไม่ตรง Standard Format", Toast.LENGTH_SHORT)
						.show();
			} else if (CalendarChoose == CalendarCurr) {
				Toast.makeText(RegisterStep1.this, "โปรดใส่ วันเกิด",
						Toast.LENGTH_SHORT).show();
			} else if (CalendarChoose > CalendarCurr) {
				writeLog.LogV("CalendarChoose", String.valueOf(CalendarChoose));
				Toast.makeText(RegisterStep1.this,
						"วันเกิด จะไม่เป็นปัจจุบัน หรือ อนาคต",
						Toast.LENGTH_SHORT).show();
			} else if (vEtAnswer.equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this, "โปรดใส่คำตอบ",
						Toast.LENGTH_SHORT).show();
			} else if (txName.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this,
						"โปรดใส่ชื่อ (ไม่ต้องระบุคำนำหน้าชื่อ)",
						Toast.LENGTH_SHORT).show();
			}
			// else if(txMiddleName.getText().toString().equalsIgnoreCase("")){
			// Toast.makeText(RegisterStep1.this, "โปรดใส่ชื่อกลาง",
			// Toast.LENGTH_SHORT).show();
			// }
			else if (txTelephone.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this,
						"โปรดใส่เบอร์โทรศัพท์มือถือที่สะดวกในการติดต่อ",
						Toast.LENGTH_SHORT).show();
			} else if ((!(txTelephone.getText().toString().charAt(0) == '0' && txTelephone
					.getText().toString().charAt(1) == '8') || (txTelephone
					.getText().toString().charAt(0) == '0' && txTelephone
					.getText().toString().charAt(1) == '9'))) {
				Toast.makeText(RegisterStep1.this,
						"โปรดใส่เบอร์ต่อโทรศัพท์ ให้ครบ 10 หลัก",
						Toast.LENGTH_SHORT).show();
			} else if (txTelephone.getText().toString().length() != 12) {
				Toast.makeText(RegisterStep1.this,
						"โปรดใส่เบอร์ต่อโทรศัพท์ ให้ครบ 10 หลัก",
						Toast.LENGTH_SHORT).show();
			}
			// else
			// if(txTelephoneExtension.getText().toString().equalsIgnoreCase("")){
			// Toast.makeText(RegisterStep1.this, "โปรดใส่เบอร์ต่อโทรศัพท์",
			// Toast.LENGTH_SHORT).show();
			// }
			else if (txFatherName.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this,
						"โปรดใส่ชื่อและชื่อสกุลบิดา", Toast.LENGTH_SHORT)
						.show();
			} else if (txMotherName.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(RegisterStep1.this, "โปรดใชื่อและชื่อสกุลมารดา",
						Toast.LENGTH_SHORT).show();
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

	TextWatcher etNidFormat = new TextWatcher() {
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
			String text = etNid.getText().toString();
			textlength = etNid.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 2 || textlength == 7 || textlength == 13
					|| textlength == 16) {
				etNid.setText(new StringBuilder(text).insert(text.length() - 1,
						"-").toString());
				etNid.setSelection(etNid.getText().length());
			}
		}
	};
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