package com.revenuedepartment.app;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;

import org.w3c.dom.Text;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.res.Configuration;
import android.inputmethodservice.Keyboard.Key;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnKeyListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.revenuedepartment.datamodels.M_Login;
import com.revenuedepartment.datamodels.M_MarryHash;
import com.revenuedepartment.datamodels.M_SpouseHash;
import com.revenuedepartment.datamodels.M_TaxPayerHash;
import com.revenuedepartment.function.DateUtils1;
import com.revenuedepartment.function.Format;
import com.revenuedepartment.function.Validate;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.req_datamodels.MRequest_UpdateProfile;
import com.revenuedepartment.service.GetAuthen;
import com.revenuedepartment.service.SharedPref;

public class UpdateProfile extends Activity implements OnClickListener {
	EditText etName;
	EditText etMiddleName;
	EditText etSurname;
	EditText etTelephone;
	EditText etEmail;
	EditText etNid;
	TextView txNid;
	EditText etPasssportNo;
	EditText etBuildName;
	EditText etRoomNo;
	EditText etFloorNo;
	EditText etAddressNo;
	EditText etSoi;
	EditText etVillage;
	EditText etMooNo;
	EditText etStreet;
	Spinner etProvince;
	Spinner etAmphur;
	Spinner etTambol;
	EditText etPostcode;
	Spinner spTaxpayerStatus;
	Spinner spSpouseStatus;
	Spinner spMarryStatus;
	EditText etSpouseNid;
	Spinner etTitleName;
	EditText etSpouseName;
	EditText etSpouseSurname;
	DatePicker mDatePickerUserProfileSpouseBirthDate;
	EditText etSpousePassportNo;
	EditText etTxpFatherPin, etSpouseTxpFatherPin;
	EditText etTxpMotherPin, etSpouseTxpMotherPin;
	EditText etChildNoStudy;
	EditText etChildStudy;
	Button btSubmit, btCancel, btCalender;

	SharedPref pref;
	M_Login mData;
	String flag_people = "1";

	static final int DATE_DIALOG_ID = 1;
	// date and time
	private int mYear, mYearCurr;
	private int mMonth, mMonthCurr;
	private int mDay, mDayCurr;

	ArrayList<String> nameMarryHashList = new ArrayList<String>();
	ArrayList<String> nameSpouseHashList = new ArrayList<String>();
	ArrayList<String> nametaxPayerHashList = new ArrayList<String>();
	ArrayList<ObjectSpinner> marryHashList = new ArrayList<UpdateProfile.ObjectSpinner>();
	ArrayList<ObjectSpinner> spouseHashList = new ArrayList<UpdateProfile.ObjectSpinner>();
	ArrayList<ObjectSpinner> taxPayerHashList = new ArrayList<UpdateProfile.ObjectSpinner>();
	
	private DecimalFormat df;
	private DecimalFormat dfnd;
	private boolean hasFractionalPart;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();

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

		pref = new SharedPref(UpdateProfile.this);
		if (!pref.getProfile().equals(""))
			mData = GetAuthen.getResponseData(pref.getProfile());

		if (mData != null) {
			etNid.setText(Format.formatNid(mData.getNid()));
			txNid.setText(Format.formatNid(mData.getNid()));
			etName.setText(mData.getName());
			etSurname.setText(mData.getSurname());
//			etTelephone.setText(mData.getContractNo());
			
			//xx-xxxx-xxxx
			String textTelephone = mData.getContractNo();
			String textTelephoneWithDash = textTelephone.substring(0,2)+"-"+textTelephone.substring(3,4)+"-"+textTelephone.substring(9,4);
			
			writeLog.LogV("textTelephone", textTelephoneWithDash);
			etTelephone.setText(textTelephoneWithDash);
			
			etEmail.setText(mData.getEmail());

			// Address
			etBuildName.setText(mData.getBuildName());
			etRoomNo.setText(mData.getRoomNo());
			etFloorNo.setText(mData.getAddressNo());
			etVillage.setText(mData.getVillage());
			etSoi.setText(mData.getSoi());
			etMooNo.setText(mData.getMooNo());
			etStreet.setText(mData.getStreet());
			etPostcode.setText(mData.getPostcode());

			initSpinner();
		}

	}

	// sample
	public void setView() {
		setContentView(R.layout.updateprofile);
		init();

		btSubmit = (Button) findViewById(R.id.btSubmit);
		btSubmit.setOnClickListener(this);

		btCancel = (Button) findViewById(R.id.btCancel);
		btCancel.setOnClickListener(this);

		btCalender = (Button) findViewById(R.id.btBirthday);
		btCalender.setOnClickListener(this);
	}

	void init() {
		initFindView();
		EditTextWatcher();
		initKeyboardInput();
	}

	void initFindView() {
		etName = (EditText) findViewById(R.id.etName);
		etMiddleName = (EditText) findViewById(R.id.etMiddleName);
		etSurname = (EditText) findViewById(R.id.etSurname);
		etTelephone = (EditText) findViewById(R.id.etTelephone);
		etEmail = (EditText) findViewById(R.id.etEmail);
		etNid = (EditText) findViewById(R.id.etNid);
		txNid = (TextView) findViewById(R.id.txNid);
		etPasssportNo = (EditText) findViewById(R.id.etPasssportNo);
		etBuildName = (EditText) findViewById(R.id.etBuildName);
		etRoomNo = (EditText) findViewById(R.id.etRoomNo);
		etFloorNo = (EditText) findViewById(R.id.etFloorNo);
		etAddressNo = (EditText) findViewById(R.id.etAddressNo);
		etSoi = (EditText) findViewById(R.id.etSoi);
		etVillage = (EditText) findViewById(R.id.etVillage);
		etMooNo = (EditText) findViewById(R.id.etMooNo);
		etStreet = (EditText) findViewById(R.id.etStreet);
		etProvince = (Spinner) findViewById(R.id.etProvince);
		etAmphur = (Spinner) findViewById(R.id.etAmphur);
		etTambol = (Spinner) findViewById(R.id.etTambol);
		etPostcode = (EditText) findViewById(R.id.etPostcode);

		etSpouseNid = (EditText) findViewById(R.id.etSpouseNid);
		etSpouseName = (EditText) findViewById(R.id.etSpouseName);
		etSpouseSurname = (EditText) findViewById(R.id.etSpouseSurname);
		etSpousePassportNo = (EditText) findViewById(R.id.etSpousePassportNo);
		// sp = (Spinner) findViewById(R.id.etSpouseCountryCode);
		etTxpFatherPin = (EditText) findViewById(R.id.etTxpFatherPin);
		etTxpMotherPin = (EditText) findViewById(R.id.etTxpMotherPin);
		etChildNoStudy = (EditText) findViewById(R.id.etChildNoStudy);
		etChildStudy = (EditText) findViewById(R.id.etChildStudy);
		etSpouseTxpFatherPin = (EditText) findViewById(R.id.etSpouseTxpFatherPin);
		etSpouseTxpMotherPin = (EditText) findViewById(R.id.etSpouseTxpMotherPin);
	}

	private void initSpinner() {
		spTaxpayerStatus = (Spinner) findViewById(R.id.etTaxpayerStatus);
		spSpouseStatus = (Spinner) findViewById(R.id.etSpouseStatus);
		spMarryStatus = (Spinner) findViewById(R.id.etMarryStatus);

		M_TaxPayerHash taxPayerHash = mData.getTaxpayerHash();
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT0Value(), taxPayerHash.getT0()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT1Value(), taxPayerHash.getT1()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT2Value(), taxPayerHash.getT2()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT3Value(), taxPayerHash.getT3()));
		for (int i = 0; i < taxPayerHashList.size(); i++) {
			nametaxPayerHashList.add(taxPayerHashList.get(i).name);
		}

		ArrayAdapter<String> taxPayerHashAdapter = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, nametaxPayerHashList);
		taxPayerHashAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spTaxpayerStatus.setAdapter(taxPayerHashAdapter);
		spTaxpayerStatus.setSelection(parseInt(mData.getTaxpayerStatus()));

		M_SpouseHash spouseHash = mData.getSpouseHash();
		spouseHashList.add(new ObjectSpinner(spouseHash.getT0Value(), spouseHash.getT0()));
		spouseHashList.add(new ObjectSpinner(spouseHash.getT1Value(), spouseHash.getT1()));
		for (int i = 0; i < spouseHashList.size(); i++) {
			nameSpouseHashList.add(spouseHashList.get(i).name);
		}
		ArrayAdapter<String> spouseHashAdapter = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, nameSpouseHashList);
		spouseHashAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spSpouseStatus.setAdapter(spouseHashAdapter);
		spSpouseStatus.setSelection(parseInt(mData.getSpouseStatus()));

		M_MarryHash marryHash = mData.getMarryHash();
		marryHashList.add(new ObjectSpinner(marryHash.getT0Value(), marryHash.getT0()));
		marryHashList.add(new ObjectSpinner(marryHash.getT1Value(), marryHash.getT1()));
		marryHashList.add(new ObjectSpinner(marryHash.getT2Value(), marryHash.getT2()));
		marryHashList.add(new ObjectSpinner(marryHash.getT3Value(), marryHash.getT3()));
		for (int i = 0; i < marryHashList.size(); i++) {

			nameMarryHashList.add(marryHashList.get(i).name);
		}

		ArrayAdapter<String> marryHashAdapter = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, nameMarryHashList);
		marryHashAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spMarryStatus.setAdapter(marryHashAdapter);
		spMarryStatus.setSelection(parseInt(mData.getMarryStatus()));

		spTaxpayerStatus.setOnItemSelectedListener(statusChange);
		spSpouseStatus.setOnItemSelectedListener(statusChange);
		// spMarryStatus.setOnItemSelectedListener(statusChange);

	}

	private int parseInt(String value) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return 0;
		}
	}

	OnItemSelectedListener statusChange = new OnItemSelectedListener() {

		@Override
		public void onItemSelected(AdapterView<?> arg0, View arg1, int position, long arg3) {

			condition(flag_people, taxPayerHashList.get(spTaxpayerStatus.getSelectedItemPosition()).value,
					spouseHashList.get(spSpouseStatus.getSelectedItemPosition()).value);
		}

		@Override
		public void onNothingSelected(AdapterView<?> arg0) {

		}
	};

	void EditTextWatcher() {
		
		etNid.addTextChangedListener(textWatcherEtNid);
		etTelephone.addTextChangedListener(textWatcherEtTelephone);
		etSpouseNid.addTextChangedListener(textWatcherSpouseNid);
		
		etSpouseTxpFatherPin.addTextChangedListener(textWatcherSpouseTxpFatherPin);
		etSpouseTxpMotherPin.addTextChangedListener(textWatcherSpouseTxpMotherPin);
		
		etTxpFatherPin.addTextChangedListener(textWatcherTxpFatherPin);
		etTxpMotherPin.addTextChangedListener(textWatcherMotherPin);

	}

	void initKeyboardInput() {

		etTelephone.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
		txNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
//		etRoomNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
//		etFloorNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
//		etMooNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etPostcode.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etSpouseNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etSpouseTxpFatherPin.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etSpouseTxpMotherPin.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etTxpFatherPin.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etTxpMotherPin.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etChildNoStudy.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etChildStudy.setRawInputType(Configuration.KEYBOARD_QWERTY);
	}

	// TODO
	private void condition(String thai_people, String tax_payer_status, String tax_incode_status) {
		if (thai_people.equals("1")) {
			thai_people(tax_payer_status, tax_incode_status);
		} else {
			foreign(tax_payer_status, tax_incode_status);
		}
	}

	private void thai_people(String tax_payer_status, String tax_incode_status) {
		hiddenView(R.id.lnForeign);
		// single
		if (tax_payer_status.equals("0") || tax_payer_status.equals("3")) {
			showView(R.id.lnFatherMotherPin);
			hiddenView(R.id.lnMarried);
			hiddenView(R.id.lnNoInCome);
		} else if (tax_payer_status.equals("1") && tax_incode_status.equals("0")) {
			showView(R.id.lnMarried);
			hiddenView(R.id.lnMarriedForeign);
			showView(R.id.lnNoInCome);
			showView(R.id.lnSpouseNid);
		} else if (tax_payer_status.equals("1") && tax_incode_status.equals("1")) {
			showView(R.id.lnMarried);
			hiddenView(R.id.lnMarriedForeign);
			hiddenView(R.id.lnNoInCome);
			showView(R.id.lnSpouseNid);
		} else if (tax_payer_status.equals("2") && tax_incode_status.equals("0")) {
			showView(R.id.lnMarried);
			showView(R.id.lnMarriedForeign);
			hiddenView(R.id.lnNoInCome);
			hiddenView(R.id.lnSpouseNid);
		} else if (tax_payer_status.equals("2") && tax_incode_status.equals("1")) {
			showView(R.id.lnMarried);
			hiddenView(R.id.lnMarriedForeign);
			hiddenView(R.id.lnNoInCome);
			showView(R.id.lnSpouseNid);
		}
	}

	private void foreign(String tax_payer_status, String tax_incode_status) {
		showView(R.id.lnForeign);
		if (tax_payer_status.equals("0") || tax_payer_status.equals("3")) {
			hiddenView(R.id.lnMarried);
			hiddenView(R.id.lnFatherMotherPin);
		} else if (tax_payer_status.equals("1") && tax_incode_status.equals("0")) {
			showView(R.id.lnMarried);
			hiddenView(R.id.lnMarriedForeign);
			showView(R.id.lnNoInCome);
			showView(R.id.lnSpouseNid);
		} else if (tax_payer_status.equals("1") && tax_incode_status.equals("1")) {
			showView(R.id.lnMarried);
			showView(R.id.lnSpouseNid);
			hiddenView(R.id.lnNoInCome);
			hiddenView(R.id.lnFatherMotherPin);
		} else if (tax_payer_status.equals("2") && tax_incode_status.equals("0")) {
			showView(R.id.lnMarried);
			showView(R.id.lnMarriedForeign);
			hiddenView(R.id.lnSpouseNid);
			hiddenView(R.id.lnNoInCome);
			hiddenView(R.id.lnFatherMotherPin);
		} else if (tax_payer_status.equals("2") && tax_incode_status.equals("1")) {
			showView(R.id.lnSpouseNid);
			showView(R.id.lnMarried);
			hiddenView(R.id.lnNoInCome);
			hiddenView(R.id.lnFatherMotherPin);
		}
	}

	private void hiddenView(int view) {
		((LinearLayout) (LinearLayout) findViewById(view)).setVisibility(View.GONE);
	}

	private void showView(int view) {
		((LinearLayout) (LinearLayout) findViewById(view)).setVisibility(View.VISIBLE);
	}

	TextWatcher textWatcherEtNid = new TextWatcher() {
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
			
			if(text.endsWith("-"))          
			    return;
			if(textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16)
			{
				etNid.setText(new StringBuilder(text).insert(text.length()-1, "-").toString());
				etNid.setSelection(etNid.getText().length());
			}
		}
	};
	
	//make Telephone Format
	TextWatcher textWatcherEtTelephone = new TextWatcher() {
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
			String text = etTelephone.getText().toString();
			textlength = etTelephone.getText().length();
			
			if(text.endsWith("-"))          
			    return;
			if(textlength == 3 || textlength == 8)
			{
				etTelephone.setText(new StringBuilder(text).insert(text.length()-1, "-").toString());
				etTelephone.setSelection(etTelephone.getText().length());
			}
		}
	};
	
	/*
	int prevCursorEtTelephone = 0;
	TextWatcher textWatcherEtTelephone = new TextWatcher() {
//		private void OnKeyDownHandler(object sender, KeyEventArgs e)
//		{
//		    if (e.Key == Key.Back || e.Key == Key.Delete)
//		    {
//		        // The user deleted a character
//		    	etTelephone.setText("");
//		    }
//		}
		
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			//12345678
			//1-1018-
			String text = etTelephone.getText().toString();
			writeLog.LogV("prevCursorEtTelephone", String.valueOf(prevCursorEtTelephone));
			writeLog.LogV("length", String.valueOf(text.length()));
//			writeLog.LogV("char", s.toString());
//			writeLog.LogV("start", String.valueOf(start));
//			writeLog.LogV("before", String.valueOf(before));
//			writeLog.LogV("count", String.valueOf(count));
			if (prevCursorEtTelephone <= 1) {
				if (text.length() == 1) {
					String newtext = etTelephone.getText().toString() + "-";
					etTelephone.setText("");
					etTelephone.append(newtext);
				}
				
			} else if (prevCursorEtTelephone <= 6) {
				if (text.length() == 6) {
					String newtext = etTelephone.getText().toString() + "-";
					etTelephone.setText("");
					etTelephone.append(newtext);
				}
			}
			else if (prevCursorEtTelephone <= 12) {
				if (text.length() == 12) {
					String newtext = etTelephone.getText().toString() + "-";
					etTelephone.setText("");
					etTelephone.append(newtext);
				}
			}
			else if (prevCursorEtTelephone <= 15) {
				if (text.length() == 15) {
					String newtext = etTelephone.getText().toString() + "-";
					etTelephone.setText("");
					etTelephone.append(newtext);
				}
				else if(text.length() == 13 && prevCursorEtTelephone>text.length()){
					String newtext_changed = etTelephone.getText().toString();
					newtext_changed = newtext_changed.substring(0, newtext_changed.length()-1);
					etTelephone.setText("");
					etTelephone.append(newtext_changed);	
				}
				else if((text.length()==13 && prevCursorEtTelephone==13)){
					String lastChar = etTelephone.getText().toString();
					String oldString = lastChar.substring(0, lastChar.length()-1);
					lastChar = lastChar.substring(lastChar.length()-2, lastChar.length()-1);
					String newString = oldString+"-"+lastChar;
					etTelephone.setText("");
					etTelephone.append(newString);
				}
			}
			etTelephone.requestFocus();
			prevCursorEtTelephone = text.length();
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {
			
		}

		@Override
		public void afterTextChanged(Editable s) {
			//12345678
			//1-1018-1
//			String text = etTelephone.getText().toString();
//			if(text.length() == 7){
//				String newtext = text;
//				newtext.substring(newtext.length()-2, newtext.length()-1);
//				newtext
//				etTelephone.setText("");
//				etTelephone.append(newtext);
//			}
		}
	};
	*/
	
	TextWatcher textWatcherSpouseNid = new TextWatcher() {
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
			String text = etSpouseNid.getText().toString();
			textlength = etSpouseNid.getText().length();
			
			if(text.endsWith("-"))          
			    return;
			if(textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16)
			{
				etSpouseNid.setText(new StringBuilder(text).insert(text.length()-1, "-").toString());
				etSpouseNid.setSelection(etSpouseNid.getText().length());
			}
		}
	};
	/*
	int prevCursorSpouseNid = 0;
	TextWatcher textWatcherSpouseNid = new TextWatcher() {
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			String text = etSpouseNid.getText().toString();
			if (prevCursorSpouseNid <= 1) {
				if (text.length() == 1) {
					String newtext = etSpouseNid.getText().toString() + "-";
					etSpouseNid.setText("");
					etSpouseNid.append(newtext);
				}
			} else if (prevCursorSpouseNid <= 6) {
				if (text.length() == 6) {
					String newtext = etSpouseNid.getText().toString() + "-";
					etSpouseNid.setText("");
					etSpouseNid.append(newtext);
				}
			} else if (prevCursorSpouseNid <= 12) {
				if (text.length() == 12) {
					String newtext = etSpouseNid.getText().toString() + "-";
					etSpouseNid.setText("");
					etSpouseNid.append(newtext);
				}
			} else if (prevCursorSpouseNid <= 15) {
				if (text.length() == 15) {
					String newtext = etSpouseNid.getText().toString() + "-";
					etSpouseNid.setText("");
					etSpouseNid.append(newtext);
				}
			}
			etSpouseNid.requestFocus();
			prevCursorSpouseNid = text.length();
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {

		}

		@Override
		public void afterTextChanged(Editable s) {

		}
	};
	*/
	
	TextWatcher textWatcherSpouseTxpFatherPin = new TextWatcher() {
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
			String text = etSpouseTxpFatherPin.getText().toString();
			textlength = etSpouseTxpFatherPin.getText().length();
			
			if(text.endsWith("-"))          
			    return;
			if(textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16)
			{
				etSpouseTxpFatherPin.setText(new StringBuilder(text).insert(text.length()-1, "-").toString());
				etSpouseTxpFatherPin.setSelection(etSpouseTxpFatherPin.getText().length());
			}
		}
	};
	
	TextWatcher textWatcherSpouseTxpMotherPin = new TextWatcher() {
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
			String text = etSpouseTxpMotherPin.getText().toString();
			textlength = etSpouseTxpMotherPin.getText().length();
			
			if(text.endsWith("-"))          
			    return;
			if(textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16)
			{
				etSpouseTxpMotherPin.setText(new StringBuilder(text).insert(text.length()-1, "-").toString());
				etSpouseTxpMotherPin.setSelection(etSpouseTxpMotherPin.getText().length());
			}
		}
	};
	
	TextWatcher textWatcherTxpFatherPin = new TextWatcher() {
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
			String text = etTxpFatherPin.getText().toString();
			textlength = etTxpFatherPin.getText().length();
			
			if(text.endsWith("-"))          
			    return;
			if(textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16)
			{
				etTxpFatherPin.setText(new StringBuilder(text).insert(text.length()-1, "-").toString());
				etTxpFatherPin.setSelection(etTxpFatherPin.getText().length());
			}
		}
	};
	
	/*
	int prevCursorFatherPin = 0;
	TextWatcher textWatcherTxpFatherPin = new TextWatcher() {
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			String text = etTxpFatherPin.getText().toString();
			if (prevCursorFatherPin <= 1) {
				if (text.length() == 1) {
					String newtext = etTxpFatherPin.getText().toString() + "-";
					etTxpFatherPin.setText("");
					etTxpFatherPin.append(newtext);
				}
			} else if (prevCursorFatherPin <= 6) {
				if (text.length() == 6) {
					String newtext = etTxpFatherPin.getText().toString() + "-";
					etTxpFatherPin.setText("");
					etTxpFatherPin.append(newtext);
				}
			} else if (prevCursorFatherPin <= 12) {
				if (text.length() == 12) {
					String newtext = etTxpFatherPin.getText().toString() + "-";
					etTxpFatherPin.setText("");
					etTxpFatherPin.append(newtext);
				}
			} else if (prevCursorFatherPin <= 15) {
				if (text.length() == 15) {
					String newtext = etTxpFatherPin.getText().toString() + "-";
					etTxpFatherPin.setText("");
					etTxpFatherPin.append(newtext);
				}
			}
			etTxpFatherPin.requestFocus();
			prevCursorFatherPin = text.length();
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {

		}

		@Override
		public void afterTextChanged(Editable s) {

		}
	};
	*/
	
	TextWatcher textWatcherMotherPin = new TextWatcher() {
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
			String text = etTxpMotherPin.getText().toString();
			textlength = etTxpMotherPin.getText().length();
			
			if(text.endsWith("-"))          
			    return;
			if(textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16)
			{
				etTxpMotherPin.setText(new StringBuilder(text).insert(text.length()-1, "-").toString());
				etTxpMotherPin.setSelection(etTxpMotherPin.getText().length());
			}
		}
	};
	
	/*
	int prevCursorMotherPin = 0;
	TextWatcher textWatcherMotherPin = new TextWatcher() {
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			String text = etTxpMotherPin.getText().toString();
			if (prevCursorMotherPin <= 1) {
				if (text.length() == 1) {
					String newtext = etTxpMotherPin.getText().toString() + "-";
					etTxpMotherPin.setText("");
					etTxpMotherPin.append(newtext);
				}
			} else if (prevCursorMotherPin <= 6) {
				if (text.length() == 6) {
					String newtext = etTxpMotherPin.getText().toString() + "-";
					etTxpMotherPin.setText("");
					etTxpMotherPin.append(newtext);
				}
			} else if (prevCursorMotherPin <= 12) {
				if (text.length() == 12) {
					String newtext = etTxpMotherPin.getText().toString() + "-";
					etTxpMotherPin.setText("");
					etTxpMotherPin.append(newtext);
				}
			} else if (prevCursorMotherPin <= 15) {
				if (text.length() == 15) {
					String newtext = etTxpMotherPin.getText().toString() + "-";
					etTxpMotherPin.setText("");
					etTxpMotherPin.append(newtext);
				}
			}
			etTxpMotherPin.requestFocus();
			prevCursorMotherPin = text.length();
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {

		}

		@Override
		public void afterTextChanged(Editable s) {

		}
	};
	*/
	
	//############################################################################################################
	// Dialog
	
	@Override
	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case DATE_DIALOG_ID:
			return new DatePickerDialog(this, mDateSetListener, mYear, mMonth, mDay);
		}
		return null;
	}

	private DatePickerDialog.OnDateSetListener mDateSetListener = new DatePickerDialog.OnDateSetListener() {
		public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
			// TODO
			mYear = year;
			mMonth = monthOfYear;
			mDay = dayOfMonth;
			btCalender.setText(new StringBuilder().append(pad(mDay)).append("/").append(pad(mMonth + 1)).append("/").append(mYear + 543));
			selectDate = String.valueOf(mDay) + "-" + String.valueOf(mMonth + 1) + "-" + String.valueOf(mYear);
			selectDate_TH = String.valueOf(mDay) + "/" + String.valueOf(mMonth + 1) + "/" + String.valueOf(mYear);
		}
	};
	String selectDate, selectDate_TH;

	class ObjectSpinner {
		String value = "";
		String name = "";

		public ObjectSpinner(String value, String name) {
			super();
			this.value = value;
			this.name = name;
		}
	}

	MRequest_UpdateProfile profileSend;
	
	//##############################################################################################################
	
	

	//##############################################################################################################
	
	@Override
	public void onClick(View v) {
		if (v.equals(btSubmit)) {
			profileSend = new MRequest_UpdateProfile();

			validateGeneralUserAndAddress();
			validateCase(flag_people, taxPayerHashList.get(spTaxpayerStatus.getSelectedItemPosition()).value,
					spouseHashList.get(spSpouseStatus.getSelectedItemPosition()).value);

			// O
			profileSend.setBuildName(etBuildName.getText().toString());
			profileSend.setRoomNo(etRoomNo.getText().toString());
			profileSend.setFloorNo(etFloorNo.getText().toString());
			profileSend.setSoi(etSoi.getText().toString());
			profileSend.setVillage(etVillage.getText().toString());
			profileSend.setMooNo(etMooNo.getText().toString());
			profileSend.setStreet(etStreet.getText().toString());

			// Intent intent = new Intent(this, MainEFilling.class);
			// startActivity(intent);
		} else if (v.equals(btCancel)) {
			// TODO TEST
			if (flag_people.equals("0")) {
				flag_people = "1";
				Toast.makeText(UpdateProfile.this, "thai", Toast.LENGTH_SHORT).show();
			} else {
				Toast.makeText(UpdateProfile.this, "foreign", Toast.LENGTH_SHORT).show();
				flag_people = "0";
			}

			spTaxpayerStatus.setSelection(0);
			spSpouseStatus.setSelection(0);
			spMarryStatus.setSelection(0);

			condition(flag_people, taxPayerHashList.get(spTaxpayerStatus.getSelectedItemPosition()).value,
					spouseHashList.get(spSpouseStatus.getSelectedItemPosition()).value);

		} else if (v.equals(btCalender)) {
			showDialog(DATE_DIALOG_ID);
		}
	}
	
	//######################################################################################################################

	private void validateGeneralUserAndAddress() {
		if (!Validate.checkBlank(etName.getText().toString())) {
			return;
		} else {
			profileSend.setName(etName.getText().toString());
		}
		
		if (!Validate.checkBlank(etMiddleName.getText().toString())) {
			return;
		} else {
			//have no Middlename in the model
			// profileSend.setSurname(etMiddleName.getText().toString());
		}

		if (!Validate.checkBlank(etSurname.getText().toString())) {
			return;
		} else {
			profileSend.setSurname(etSurname.getText().toString());
		}

		if (Validate.isDisplay(etPasssportNo)) {
			if (!Validate.checkBlank(etPasssportNo.getText().toString())) {
				return;
			} else {
				profileSend.setPasssportNo(etPasssportNo.getText().toString());
			}
		}
		if (!Validate.checkBlank(etTelephone.getText().toString())) {
			return;
		} else {
			profileSend.setPhoneNumber(etTelephone.getText().toString());
		}
		if (!Validate.checkBlank(etEmail.getText().toString()) || !Validate.isValidEmail(etEmail.getText().toString())) {
			return;
		} else {
			profileSend.setEmail(etEmail.getText().toString());
		}

		if (!Validate.checkBlank(etAddressNo.getText().toString())) {
			return;
		} else {
			profileSend.setAddressNo(etAddressNo.getText().toString());
		}

		if (!Validate.checkBlank(etPostcode.getText().toString())) {
			return;
		} else {
			profileSend.setPostcode(etPostcode.getText().toString());
		}
	}

	private void validateCase(String thai_people, String tax_payer_status, String tax_incode_status) {
		if (thai_people.equals("1")) {

			if (tax_payer_status.equals("0") || tax_payer_status.equals("3")) {
				validateTxpFatherMontherPin();
				validateChild();

			} else if (tax_payer_status.equals("1") && tax_incode_status.equals("0")) {

				validateSpouseNId();
				validateSpouseName();
				validateBirthday();
				validateTxpFatherMontherPin();
				validateSpouseTxpFatherMontherPin();
				validateChild();

			} else if (tax_payer_status.equals("1") && tax_incode_status.equals("1")) {

				validateSpouseNId();
				validateSpouseName();
				validateBirthday();
				validateTxpFatherMontherPin();
				validateChild();
			} else if (tax_payer_status.equals("2") && tax_incode_status.equals("0")) {

				validateSpouseName();
				validateBirthday();
				validateSpousePassportNo();
				validateTxpFatherMontherPin();
				validateChild();

			} else if (tax_payer_status.equals("2") && tax_incode_status.equals("1")) {

				validateSpouseNId();
				validateSpouseName();
				validateBirthday();
				validateTxpFatherMontherPin();
				validateChild();
			}
		} else {
			if (tax_payer_status.equals("0") || tax_payer_status.equals("3")) {
				validateChild();
			} else if (tax_payer_status.equals("1") && tax_incode_status.equals("0")) {
				validateSpouseNId();
				validateSpouseName();
				validateBirthday();
				validateSpouseTxpFatherMontherPin();
				validateChild();
			} else if (tax_payer_status.equals("1") && tax_incode_status.equals("1")) {
				validateSpouseNId();
				validateSpouseName();
				validateBirthday();
				validateChild();
			} else if (tax_payer_status.equals("2") && tax_incode_status.equals("0")) {
				validateSpouseName();
				validateBirthday();
				validateSpousePassportNo();
				validateChild();
			} else if (tax_payer_status.equals("2") && tax_incode_status.equals("1")) {
				validateSpouseNId();
				validateSpouseName();
				validateBirthday();
				validateSpousePassportNo();
				validateChild();
			}
		}
	}

	private void validateTxpFatherMontherPin() {
		if (!Validate.checkBlank(etTxpFatherPin.getText().toString())) {
			return;
		} else {
			profileSend.setTxpFatherPin(etTxpFatherPin.getText().toString());
		}

		if (!Validate.checkBlank(etTxpMotherPin.getText().toString())) {
			return;
		} else {
			profileSend.setTxpFatherPin(etTxpMotherPin.getText().toString());
		}
	}

	private void validateSpouseTxpFatherMontherPin() {
		if (!Validate.checkBlank(etSpouseTxpFatherPin.getText().toString())) {
			return;
		} else {
			profileSend.setSpouseFatherPin(etSpouseTxpFatherPin.getText().toString());
		}
		if (!Validate.checkBlank(etSpouseTxpMotherPin.getText().toString())) {
			return;
		} else {
			profileSend.setSpouseMotherPin(etSpouseTxpMotherPin.getText().toString());
		}
	}

	private void validateSpouseNId() {

		if (!Validate.checkBlank(etSpouseNid.getText().toString())) {
			return;
		} else {
			profileSend.setSpouseNid(etSpouseNid.getText().toString());
		}
	}

	private void validateSpouseName() {
		if (!Validate.checkBlank(etSpouseName.getText().toString())) {
			return;
		} else {
			profileSend.setSpouseName(etSpouseName.getText().toString());
		}
		if (!Validate.checkBlank(etSpouseSurname.getText().toString())) {
			return;
		} else {
			profileSend.setSpouseSurname(etSpouseSurname.getText().toString());
		}
	}

	private void validateSpousePassportNo() {
		if (!Validate.checkBlank(etSpousePassportNo.getText().toString())) {
			return;
		} else {
			profileSend.setSpousePassportNo(etSpousePassportNo.getText().toString());
		}
	}

	private void validateBirthday() {
		int dateSelect = DateUtils1.componentTimeToTimestamp(mYear, mMonth, mDay, 0, 0, 0);
		int dateCurrent = DateUtils1.componentTimeToTimestamp(mYearCurr, mMonthCurr, mDayCurr, 0, 0, 0);
		if (dateSelect == dateCurrent) {
			Toast.makeText(UpdateProfile.this, "555", Toast.LENGTH_SHORT).show();
		} else if (dateSelect >= dateCurrent) {
			Toast.makeText(UpdateProfile.this, "555", Toast.LENGTH_SHORT).show();
		} else {
			profileSend.setSpouseBirthDate(btCalender.getText().toString());
		}
	}

	private void validateChild() {

		if (!Validate.checkBlank(etChildNoStudy.getText().toString())) {
			return;
		} else {
			profileSend.setChildNoStudy(etChildNoStudy.getText().toString());
		}
		if (!Validate.checkBlank(etChildStudy.getText().toString())) {
			return;
		} else {
			profileSend.setChildStudy(etChildStudy.getText().toString());
		}
	}

	public static String pad(int c) {
		if (c >= 10)
			return String.valueOf(c);
		else
			return "0" + String.valueOf(c);
	}
}
