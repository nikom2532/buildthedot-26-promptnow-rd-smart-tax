package com.revenuedepartment.app;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.function.DateUtils1;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.SharedPref;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.text.format.DateFormat;
import android.text.format.Time;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class ResetPasswordStep1 extends Activity implements OnClickListener {
	TextView mEditTextForgetPasswordStep1Idcityzen;
	DatePicker mEditTextForgetPasswordStep1Birthdate;
	ButtonCustom mbuttonForgotPasswordStep1Submit, btCalendar;
	TopBar topBar;
	static final int DATE_DIALOG_ID = 1;
	// date and time
	private int mYear, mYearCurr;
	private int mMonth, mMonthCurr;
	private int mDay, mDayCurr;
	
//	public static void setLocale(String language, Activity activity)
//	{
//	    Locale locale= new Locale(language);
//	    Locale.setDefault(locale);
//
//	    Configuration config = new Configuration();
//	    config.locale = locale;
//
//	    thisActivity = activity;
//
//	    thisActivity.getBaseContext().getResources().updateConfiguration(config, thisActivity.getBaseContext().getResources().getDisplayMetrics());
//	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
//		Locale locale = new Locale("th","th","th");
//		Locale.setDefault(locale);
//		Configuration config = new Configuration();
//		config.locale = locale;
//		getBaseContext().getResources().updateConfiguration(config,
//		      getBaseContext().getResources().getDisplayMetrics());
		setView();
	}
	
	@SuppressWarnings("null")
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
	}

	@Override
	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case DATE_DIALOG_ID:
//			writeLog.LogV("mInitialYear", String.valueOf(mYear));
//			writeLog.LogV("mInitialMonth", String.valueOf(mMonth));
//			writeLog.LogV("mInitialDay", String.valueOf(mDay));
//			return new AppLocaleDatePickerDialog2(this, mDateSetListener, mYear, mMonth, mDay);
			return new DatePickerDialog(this, mDateSetListener, mYear, mMonth, mDay);
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
		public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
			// TODO
			mYear = year;
			mMonth = monthOfYear;
			mDay = dayOfMonth;
			
			
			
//			/*SET THE DATE IN THE TEXTBOX HERE*/
//		    Time chosenDate = new Time();
//		    chosenDate.set(dayOfMonth, monthOfYear, year);
//		    long dtDob = chosenDate.toMillis(true);
//		    CharSequence strDate = DateFormat.format("MMMM dd, yyyy", dtDob);
//		    //  Toast.makeText(TawajidiDetails.this,
//		    //                     "Date picked: " + strDate, Toast.LENGTH_SHORT).show();
//		    String selectedDateTo = String.valueOf(year)+"-"+String.valueOf(monthOfYear+1)+"-"+String.valueOf(dayOfMonth);
//		    btCalendar.setText(strDate);
		    
//			writeLog.LogV("getMonthLongFormat", AppLocaleDatePickerDialog2.getMonthLongFormat(ResetPasswordStep1.this).toString());
			
			btCalendar.setText(new StringBuilder().append(pad(mDay)).append("/").append(pad(mMonth + 1)).append("/").append(mYear + 543));
			selectDate = String.valueOf(mDay) + "-" + String.valueOf(mMonth + 1) + "-" + String.valueOf(mYear);
			selectDate_TH = String.valueOf(mDay) + "/" + String.valueOf(mMonth + 1) + "/" + String.valueOf(mYear);
		}
		
	};
	String selectDate, selectDate_TH;

	public void setView() {
		
//		Locale locale = new Locale("th", "TH");
//		Locale.setDefault(locale);
		
		setContentView(R.layout.reset_password_step1);
		mEditTextForgetPasswordStep1Idcityzen = (TextView) findViewById(R.id.mEditTextForgetPasswordStep1Idcityzen);

		btCalendar = (ButtonCustom) findViewById(R.id.btCalendar);
		btCalendar.setDefault();
		btCalendar.setOnClickListener(this);

		mbuttonForgotPasswordStep1Submit = (ButtonCustom) findViewById(R.id.mbuttonForgotPasswordStep1Submit);
		mbuttonForgotPasswordStep1Submit.setDefault();
		mbuttonForgotPasswordStep1Submit.setOnClickListener(this);

		topBar = (TopBar) findViewById(R.id.Topbar);
		SharedPref pref = new SharedPref(ResetPasswordStep1.this);
		mEditTextForgetPasswordStep1Idcityzen.setText(pref.getString("LoginEFillingNid"));

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
	}

	@SuppressWarnings("deprecation")
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (mbuttonForgotPasswordStep1Submit.equals(v)) {

			int CalendarChoose = DateUtils1.componentTimeToTimestamp(mYear, mMonth, mDay, 0, 0, 0);
			int CalendarCurr = DateUtils1.componentTimeToTimestamp(mYearCurr, mMonthCurr, mDayCurr, 0, 0, 0);

			if (CalendarChoose == CalendarCurr) {
				Toast.makeText(ResetPasswordStep1.this, "โปรดใส่ วันเกิด", Toast.LENGTH_SHORT).show();
			} else if (CalendarChoose >= CalendarCurr) {
				writeLog.LogV("CalendarChoose", String.valueOf(CalendarChoose));
				Toast.makeText(ResetPasswordStep1.this,
						"วันเกิด จะไม่เป็นปัจจุบัน หรือ อนาคต", Toast.LENGTH_SHORT)
						.show();
			} else {
				new requestCheckPassword().execute();
			}
		} else if (v.equals(btCalendar)) {
			showDialog(DATE_DIALOG_ID);
		}
	}

	// ################################################################################################################
	// requestCheckPassword

	private class requestCheckPassword extends AsyncTask<String, Void, M_ResetPasswordRequest> {
		DialogProcess dialog = new DialogProcess(ResetPasswordStep1.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected M_ResetPasswordRequest doInBackground(String... params) {

			// ### Make json request (nid) ###
			String mJsonRequest = "";
			// mJsonRequest += "{\"nid\":\"" +
			// mEditTextForgetPasswordStep1Idcityzen.getText() +
			// "\",\"birthDate\":\"" +
			// mEditTextForgetPasswordStep1Birthdate.getDayOfMonth() +
			// "\",\"version\":\"1.0.0\"}";
			mJsonRequest += "{\"nid\":\"" + mEditTextForgetPasswordStep1Idcityzen.getText() + "\",\"birthDate\":\"" + mDay + "/" + mMonth + "/"
					+ mDay + "\",\"version\":\"1.0.0\"}";
			M_ResetPasswordRequest mResetPasswordRequest = new ConnectApi().mResetPasswordRequest(mJsonRequest);

			return mResetPasswordRequest;
		}

		@Override
		protected void onPostExecute(M_ResetPasswordRequest result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {

				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					// writeLog.LogV("getResponseStatus=OK?",
					// result.getResponseData().getStatus());

					if (result.getResponseData().getEmail().equals("")) {
						Intent intent = new Intent(ResetPasswordStep1.this, ResetPasswordNoHaveEmailRequest.class);
						intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
						startActivityForResult(intent, 0);
					} else {
						SharedPref pref = new SharedPref(ResetPasswordStep1.this);
						pref.setString("ResetPasswordStep1_email", result.getResponseData().getEmail());

						Intent intent = new Intent(ResetPasswordStep1.this, ResetPasswordHaveEmailRequest.class);
						intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
						startActivityForResult(intent, 0);
					}
				} else {

				}
			}
		}
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == Login_E_Filing.RESULT_RESETPASSWORD) {
			setResult(Login_E_Filing.RESULT_RESETPASSWORD);
			finish();
		}
	}
}