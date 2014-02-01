package com.revenuedepartment.app;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
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

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonRequestRD;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_Login;
import com.revenuedepartment.datamodels.M_MarryHash;
import com.revenuedepartment.datamodels.M_SaveRegister;
import com.revenuedepartment.datamodels.M_SpouseHash;
import com.revenuedepartment.datamodels.M_TaxPayerHash;
import com.revenuedepartment.datapackages.P_Login;
import com.revenuedepartment.function.DateUtils1;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.Format;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.Validate;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.req_datamodels.MRequest_SaveRegister;
import com.revenuedepartment.req_datamodels.MRequest_UpdateProfile;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.ElementMessage;
import com.revenuedepartment.service.ElementPlaceHolder;
import com.revenuedepartment.service.GetAuthen;
import com.revenuedepartment.service.GetMessageError;
import com.revenuedepartment.service.GetPlaceHolders;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.SharedPref;

public class UpdateProfile extends Activity implements OnClickListener {
	EditText etName;
	TextViewCustom txTitleName1;
	TextView etMiddleName;
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
	Button btCalender;
	ButtonCustom btSubmit, btCancel;

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
	// ArrayList<String> nameTitleNameList = new ArrayList<String>();
	ArrayList<ObjectSpinner> marryHashList = new ArrayList<UpdateProfile.ObjectSpinner>();
	ArrayList<ObjectSpinner> spouseHashList = new ArrayList<UpdateProfile.ObjectSpinner>();
	ArrayList<ObjectSpinner> taxPayerHashList = new ArrayList<UpdateProfile.ObjectSpinner>();

	TopBar topBar;

	PopupDialog popup = new PopupDialog(UpdateProfile.this);
	GetMessageError messageError;
	GetPlaceHolders placeHolders;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		messageError = new GetMessageError(UpdateProfile.this);
		placeHolders = new GetPlaceHolders(UpdateProfile.this);
		CommonRequestRD.LANG = "th";
		this.getDataCenter();
		setView();

		// Locale local=new Locale("th","TH"); Locale.setDefault(locale);
		Locale locale = new Locale("th");
		Locale.setDefault(locale);
		final Calendar c = Calendar.getInstance();
		Calendar.getInstance(locale);
		mYear = c.get(Calendar.YEAR);
		mMonth = c.get(Calendar.MONTH);
		mDay = c.get(Calendar.DAY_OF_MONTH);
		mYearCurr = c.get(Calendar.YEAR);
		mMonthCurr = c.get(Calendar.MONTH);
		mDayCurr = c.get(Calendar.DAY_OF_MONTH);

		// mYear = 2000;
		mMonth = 0;
		mDay = 1;

		pref = new SharedPref(UpdateProfile.this);
		if (!pref.getProfile().equals(""))
			mData = GetAuthen.getTempAuthen(pref.getProfile());

		if (mData != null) {
			etNid.setText(Format.formatNid(mData.getNid()));
			txNid.setText(Format.formatNid(mData.getNid()));
			etName.setText(mData.getName());
			txTitleName1.setText(mData.getTitleName());
			etSurname.setText(mData.getSurname());
			etMiddleName.setText(mData.middleName);
//			etTelephone.setText(mData.getContractNo());

			// xx-xxxx-xxxx
			String textTelephone = mData.getContractNo();
//			textTelephone = "0812345678";
//			textTelephone = "0897706773";
			String textTelephoneWithDash = textTelephone.substring(0, 2) + "-" + textTelephone.substring(2, 6) + "-" + textTelephone.substring(6, 10);

//			writeLog.LogV("textTelephone", textTelephoneWithDash);
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

		
	}

	void init() {
		initFindView();
		EditTextWatcher();
		initKeyboardInput();
		setHint();
	}

	void initFindView() {
		etName = (EditText) findViewById(R.id.etName);
		txTitleName1 = (TextViewCustom) findViewById(R.id.txTitleName1);
		etMiddleName = (TextView) findViewById(R.id.etMiddleName);
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
		
		btSubmit = (ButtonCustom) findViewById(R.id.btSubmit);
		btSubmit.setDefault();
		btSubmit.setOnClickListener(this);

		btCancel = (ButtonCustom) findViewById(R.id.btCancel);
		btCancel.setDefault();
		btCancel.setOnClickListener(this);

		btCalender = (Button) findViewById(R.id.btBirthday);
		btCalender.setOnClickListener(this);

		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_user));
	}

	private void initSpinner() {
		spTaxpayerStatus = (Spinner) findViewById(R.id.etTaxpayerStatus);
		spSpouseStatus = (Spinner) findViewById(R.id.etSpouseStatus);
		spMarryStatus = (Spinner) findViewById(R.id.etMarryStatus);
		etTitleName = (Spinner) findViewById(R.id.etTitleName);

		M_TaxPayerHash taxPayerHash = mData.getTaxpayerHash();
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT0Value(), taxPayerHash.getT0()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT1Value(), taxPayerHash.getT1()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT2Value(), taxPayerHash.getT2()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT3Value(), taxPayerHash.getT3()));
		for (int i = 0; i < taxPayerHashList.size(); i++) {
			nametaxPayerHashList.add(taxPayerHashList.get(i).name);
		}

		ArrayAdapter<String> taxPayerHashAdapter = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, nametaxPayerHashList);
		taxPayerHashAdapter.setDropDownViewResource(R.layout.text_spinner_items);
		spTaxpayerStatus.setAdapter(taxPayerHashAdapter);
		spTaxpayerStatus.setSelection(parseInt(mData.getTaxpayerStatus()));

		M_SpouseHash spouseHash = mData.getSpouseHash();
		spouseHashList.add(new ObjectSpinner(spouseHash.getT0Value(), spouseHash.getT0()));
		spouseHashList.add(new ObjectSpinner(spouseHash.getT1Value(), spouseHash.getT1()));
		for (int i = 0; i < spouseHashList.size(); i++) {
			nameSpouseHashList.add(spouseHashList.get(i).name);
		}
		ArrayAdapter<String> spouseHashAdapter = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, nameSpouseHashList);
		spouseHashAdapter.setDropDownViewResource(R.layout.text_spinner_items);
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
		marryHashAdapter.setDropDownViewResource(R.layout.text_spinner_items);
		spMarryStatus.setAdapter(marryHashAdapter);
		spMarryStatus.setSelection(parseInt(mData.getMarryStatus()));

		spTaxpayerStatus.setOnItemSelectedListener(statusChange);
		spSpouseStatus.setOnItemSelectedListener(statusChange);
		// spMarryStatus.setOnItemSelectedListener(statusChange);

		ArrayAdapter<String> etTitleNameSpinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, android.R.id.text1);
		etTitleNameSpinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		etTitleName.setAdapter(etTitleNameSpinnerAdapter);
		etTitleNameSpinnerAdapter.add(getString(R.string.lang_th_Label_user_profile_middlename_list1));
		etTitleNameSpinnerAdapter.add(getString(R.string.lang_th_Label_user_profile_middlename_list2));
		etTitleNameSpinnerAdapter.add(getString(R.string.lang_th_Label_user_profile_middlename_list3));
		etTitleNameSpinnerAdapter.add(getString(R.string.lang_th_Label_user_profile_middlename_list4));
		etTitleNameSpinnerAdapter.add(getString(R.string.lang_th_Label_user_profile_middlename_list5));
		etTitleNameSpinnerAdapter.add(getString(R.string.lang_th_Label_user_profile_middlename_list6));
		etTitleNameSpinnerAdapter.notifyDataSetChanged();

	}
	
	private void setHint(){
		etName.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.name));
		etSurname.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.surname));
		etTelephone.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.contractNo));
		etEmail.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.email));
//		etNid.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.));
		etPasssportNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.passportNo));
		etBuildName.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.buildName));
		etRoomNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.roomNo));
		etFloorNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.floorNo));
		etAddressNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.addressNo));
		etSoi.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.soi));
		etVillage.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.village));
		etMooNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.mooNo));
		etStreet.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.street));
		etPostcode.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.postcode));
		etSpouseNid.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.spouseNid));
		etSpouseName.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.spouseName));
		etSpouseSurname.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.spouseSurname));
		etSpousePassportNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.spousePassportNo));
		etTxpFatherPin.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.txpFatherPin));
		etSpouseTxpFatherPin.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.spouseFatherPin));
		etTxpMotherPin.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.txpMotherPin));
		etSpouseTxpMotherPin.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.txpMotherPin));
		etChildNoStudy.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.childNoStudy));
		etChildStudy.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.childStudy));
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
		// etRoomNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		// etFloorNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		// etMooNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
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

	// make Telephone Format
	TextWatcher textWatcherEtTelephone = new TextWatcher() {
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
			String text = etTelephone.getText().toString();
			textlength = etTelephone.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 3 || textlength == 8) {
				etTelephone.setText(new StringBuilder(text).insert(text.length() - 1, "-").toString());
				etTelephone.setSelection(etTelephone.getText().length());
			}
		}
	};
	
	TextWatcher textWatcherSpouseNid = new TextWatcher() {
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
			String text = etSpouseNid.getText().toString();
			textlength = etSpouseNid.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16) {
				etSpouseNid.setText(new StringBuilder(text).insert(text.length() - 1, "-").toString());
				etSpouseNid.setSelection(etSpouseNid.getText().length());
			}
		}
	};

	TextWatcher textWatcherSpouseTxpFatherPin = new TextWatcher() {
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
			String text = etSpouseTxpFatherPin.getText().toString();
			textlength = etSpouseTxpFatherPin.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16) {
				etSpouseTxpFatherPin.setText(new StringBuilder(text).insert(text.length() - 1, "-").toString());
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
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {
			// TODO Auto-generated method stub

		}

		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			// TODO Auto-generated method stub
			String text = etSpouseTxpMotherPin.getText().toString();
			textlength = etSpouseTxpMotherPin.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16) {
				etSpouseTxpMotherPin.setText(new StringBuilder(text).insert(text.length() - 1, "-").toString());
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
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {
			// TODO Auto-generated method stub

		}

		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			// TODO Auto-generated method stub
			String text = etTxpFatherPin.getText().toString();
			textlength = etTxpFatherPin.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16) {
				etTxpFatherPin.setText(new StringBuilder(text).insert(text.length() - 1, "-").toString());
				etTxpFatherPin.setSelection(etTxpFatherPin.getText().length());
			}
		}
	};

	/*
	 * int prevCursorFatherPin = 0; TextWatcher textWatcherTxpFatherPin = new
	 * TextWatcher() {
	 * 
	 * @Override public void onTextChanged(CharSequence s, int start, int
	 * before, int count) { String text = etTxpFatherPin.getText().toString();
	 * if (prevCursorFatherPin <= 1) { if (text.length() == 1) { String newtext
	 * = etTxpFatherPin.getText().toString() + "-"; etTxpFatherPin.setText("");
	 * etTxpFatherPin.append(newtext); } } else if (prevCursorFatherPin <= 6) {
	 * if (text.length() == 6) { String newtext =
	 * etTxpFatherPin.getText().toString() + "-"; etTxpFatherPin.setText("");
	 * etTxpFatherPin.append(newtext); } } else if (prevCursorFatherPin <= 12) {
	 * if (text.length() == 12) { String newtext =
	 * etTxpFatherPin.getText().toString() + "-"; etTxpFatherPin.setText("");
	 * etTxpFatherPin.append(newtext); } } else if (prevCursorFatherPin <= 15) {
	 * if (text.length() == 15) { String newtext =
	 * etTxpFatherPin.getText().toString() + "-"; etTxpFatherPin.setText("");
	 * etTxpFatherPin.append(newtext); } } etTxpFatherPin.requestFocus();
	 * prevCursorFatherPin = text.length(); }
	 * 
	 * @Override public void beforeTextChanged(CharSequence s, int start, int
	 * count, int after) {
	 * 
	 * }
	 * 
	 * @Override public void afterTextChanged(Editable s) {
	 * 
	 * } };
	 */

	TextWatcher textWatcherMotherPin = new TextWatcher() {
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
			String text = etTxpMotherPin.getText().toString();
			textlength = etTxpMotherPin.getText().length();

			if (text.endsWith("-"))
				return;
			if (textlength == 2 || textlength == 7 || textlength == 13 || textlength == 16) {
				etTxpMotherPin.setText(new StringBuilder(text).insert(text.length() - 1, "-").toString());
				etTxpMotherPin.setSelection(etTxpMotherPin.getText().length());
			}
		}
	};

	/*
	 * int prevCursorMotherPin = 0; TextWatcher textWatcherMotherPin = new
	 * TextWatcher() {
	 * 
	 * @Override public void onTextChanged(CharSequence s, int start, int
	 * before, int count) { String text = etTxpMotherPin.getText().toString();
	 * if (prevCursorMotherPin <= 1) { if (text.length() == 1) { String newtext
	 * = etTxpMotherPin.getText().toString() + "-"; etTxpMotherPin.setText("");
	 * etTxpMotherPin.append(newtext); } } else if (prevCursorMotherPin <= 6) {
	 * if (text.length() == 6) { String newtext =
	 * etTxpMotherPin.getText().toString() + "-"; etTxpMotherPin.setText("");
	 * etTxpMotherPin.append(newtext); } } else if (prevCursorMotherPin <= 12) {
	 * if (text.length() == 12) { String newtext =
	 * etTxpMotherPin.getText().toString() + "-"; etTxpMotherPin.setText("");
	 * etTxpMotherPin.append(newtext); } } else if (prevCursorMotherPin <= 15) {
	 * if (text.length() == 15) { String newtext =
	 * etTxpMotherPin.getText().toString() + "-"; etTxpMotherPin.setText("");
	 * etTxpMotherPin.append(newtext); } } etTxpMotherPin.requestFocus();
	 * prevCursorMotherPin = text.length(); }
	 * 
	 * @Override public void beforeTextChanged(CharSequence s, int start, int
	 * count, int after) {
	 * 
	 * }
	 * 
	 * @Override public void afterTextChanged(Editable s) {
	 * 
	 * } };
	 */

	// ############################################################################################################
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
	
	Bundle mValue = new Bundle();
	
	private void getDataCenter() {
		mValue = GetAuthen.dataCenter(new SharedPref(UpdateProfile.this).getProfile());
		SavedInstance.map.put(SavedInstance.VALUE, mValue);
	}

	MRequest_UpdateProfile profileSend;

	// ##############################################################################################################
	private class requestUpdateProfile extends AsyncTask<String, Void, P_Login> {

		DialogProcess dialog = new DialogProcess(UpdateProfile.this);
		ConnectApi connApi = new ConnectApi(UpdateProfile.this);
		MRequest_UpdateProfile updateProfile = new MRequest_UpdateProfile();
		String JSONObjSend;
		
		public requestUpdateProfile() {
			
			updateProfile.deviceID = new GetDeviceID(UpdateProfile.this).getDeviceID();
			updateProfile.nid = mValue.getString(JSONElement.nid);
			updateProfile.authenKey = mValue.getString(JSONElement.authenKey);
			updateProfile.name = etName.getText().toString();
			updateProfile.surname = etSurname.getText().toString();
			
			updateProfile.buildName = etBuildName.getText().toString();
			updateProfile.roomNo = etRoomNo.getText().toString();
			updateProfile.floorNo = etFloorNo.getText().toString();
			updateProfile.addressNo = etAddressNo.getText().toString();
			updateProfile.soi = etSoi.getText().toString();
			updateProfile.village = etVillage.getText().toString();
			updateProfile.mooNo = etMooNo.getText().toString();
			updateProfile.street = etStreet.getText().toString();
//			updateProfile.tambol
//			updateProfile.amphur
//			updateProfile.province
			updateProfile.postcode = etPostcode.getText().toString();
			updateProfile.taxpayerStatus = spTaxpayerStatus.getSelectedItem().toString();
			updateProfile.spouseStatus = spSpouseStatus.getSelectedItem().toString();
			updateProfile.marryStatus = spMarryStatus.getSelectedItem().toString();
			updateProfile.spouseNid = etSpouseNid.getText().toString();
			updateProfile.spouseName = etSpouseName.getText().toString();
			updateProfile.spouseSurname = etSpouseSurname.getText().toString();
			updateProfile.childNoStudy = etChildNoStudy.getText().toString();
			updateProfile.childStudy = etChildStudy.getText().toString();
			updateProfile.txpFatherPin = etTxpFatherPin.getText().toString();
			updateProfile.txpMotherPin = etTxpMotherPin.getText().toString();
			updateProfile.spouseFatherPin = etSpouseTxpFatherPin.getText().toString();
			updateProfile.spouseMotherPin = etSpouseTxpMotherPin.getText().toString();
			updateProfile.passsportNo = etPasssportNo.getText().toString();
//			updateProfile.countryCode
			updateProfile.email = etEmail.getText().toString();
			updateProfile.phoneNumber = profileSend.getPhoneNumber();
			updateProfile.spousePassportNo = etSpousePassportNo.getText().toString();
//			updateProfile.spouseCountryCode
//			updateProfile.spouseBirthDate
			
			
//			//***
//			int CalendarChoose = DateUtils1.componentTimeToTimestamp(mYear, mMonth, mDay, 0, 0, 0);
//			long unixSeconds = (long) CalendarChoose;
//			Date date = new Date(unixSeconds*1000L); // *1000 is to convert seconds to milliseconds
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // the format of your date
//			sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
//			String formattedDate = sdf.format(date);
//			
//			writeLog.LogV("bd", String.valueOf(formattedDate));
//			
//			saveRegister.birthDate = String.valueOf(formattedDate);
//			//***
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_Login doInBackground(String... params) {

			updateProfile.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(updateProfile);

			P_Login mUpdateProfile = connApi.requestUpdateProfile(JSONObjSend);
			// writeLog.LogV("pCheckNewUser", pCheckNewUser.toString());

			writeLog.LogV("requestRegisterSave", "4");

			return mUpdateProfile;

			// M_RegisterSave mRegisterSave = new ConnectApi()
			// .requestRegisterSave();
			// writeLog.LogV("mRegisterSave",
			// mRegisterSave.getResponseStatus());
			//
			// return mRegisterSave;
		}

		@Override
		protected void onPostExecute(P_Login result) {
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
				// if(result.responseCode.equals(CommonResponseRD.CODE_SUCCESS))
				// {
					
				if (result.getResponseStatus().equals(getString(R.string.OK))) {

				} else {
					// SharedPref pref = new SharedPref(RegisterStep1.this);
					// pref.setProfile(result.getTemp_json_data());
					// Bundle mValue = new Bundle();
					// GetAuthen.dataCenter(pref.getProfile());
					// SavedInstance.map.put(SavedInstance.VALUE, mValue);
					// Intent intent = new Intent(RegisterStep1.this,
					// TermsAndConditions.class);
					// startActivity(intent);
					// finish();

//					Intent intent = new Intent(UpdateProfile.this, MainEFilling.class);
//					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
//					startActivityForResult(intent, 0);
				}
				writeLog.LogV("ok", "ok");
			}
		}
	}
	// ##############################################################################################################

	@Override
	public void onClick(View v) {
		if (v.equals(btSubmit)) {
			
			// x x - x x x x - x x  x  x
			//0 1 2 3 4 5 6 7 8 9 10 11 12
			String textTelephone = etTelephone.getText().toString();
			String textTelephoneWithDash = textTelephone.substring(0, 2) + textTelephone.substring(3, 7) + "-" + textTelephone.substring(8, 12);
			
			//********
//			int CalendarChoose = DateUtils1.componentTimeToTimestamp(mYear, mMonth, mDay, 0, 0, 0);
//			long unixSeconds = (long) CalendarChoose;
//			Date date = new Date(unixSeconds*1000L); // *1000 is to convert seconds to milliseconds
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // the format of your date
//			sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
//			String formattedDate = sdf.format(date);
//			
//			writeLog.LogV("birthdate", String.valueOf(formattedDate));
//			
//			saveRegister.birthDate = String.valueOf(formattedDate);
			//********
			
			profileSend = new MRequest_UpdateProfile();

			validateGeneralUserAndAddress();
			validateGeneralUserAndAddress2();
			validateCase(flag_people, taxPayerHashList.get(spTaxpayerStatus.getSelectedItemPosition()).value,
					spouseHashList.get(spSpouseStatus.getSelectedItemPosition()).value);

			// O
			profileSend.setPhoneNumber(textTelephoneWithDash);
			profileSend.setBuildName(etBuildName.getText().toString());
			profileSend.setRoomNo(etRoomNo.getText().toString());
			profileSend.setFloorNo(etFloorNo.getText().toString());
			profileSend.setSoi(etSoi.getText().toString());
			profileSend.setVillage(etVillage.getText().toString());
			profileSend.setMooNo(etMooNo.getText().toString());
			profileSend.setStreet(etStreet.getText().toString());
			
			
//			writeLog.LogV("spTaxpayerStatus", spTaxpayerStatus.getSelectedItem().toString());
//			spTaxpayerStatus.getSelectedItem().toString();
			
			
			new requestUpdateProfile().execute();

			
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

	// ######################################################################################################################

	private void validateGeneralUserAndAddress2() {
		String prefix = "โปรดใส่";
		if (etName.getText().toString().equalsIgnoreCase("")) {
			popup.show("", messageError.getFieldMessage(ElementMessage.nameEmpty));
			etName.requestFocus();
			return;
//		} else if (etMiddleName.getText().toString().equalsIgnoreCase("")) {
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_middlename));
//			etMiddleName.requestFocus();
//			return;
		} else if (etSurname.getText().toString().equalsIgnoreCase("")) {
			popup.show("", messageError.getFieldMessage(ElementMessage.surnameEmpty));
			etSurname.requestFocus();
			return;
		} else if (etTelephone.getText().toString().equalsIgnoreCase("")) {
			popup.show("", messageError.getFieldMessage(ElementMessage.contractNoEmpty));
			etTelephone.requestFocus();
			return;
		} else if (etEmail.getText().toString().equalsIgnoreCase("")) {
			popup.show("", messageError.getFieldMessage(ElementMessage.emailEmpty));
			etEmail.requestFocus();
			return;
//		}

//		else if (etBuildName.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_buildName));
//			etBuildName.requestFocus();
//			return;
//		} else if (etRoomNo.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_roomNo));
//			etRoomNo.requestFocus();
//			return;
//		} else if (etFloorNo.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_floorNo));
//			etFloorNo.requestFocus();
//			return;
		} else if (etAddressNo.getText().toString().equalsIgnoreCase("")) {

			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_addressNo));
			etAddressNo.requestFocus();
			return;
//		} else if (etSoi.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_soi));
//			etSoi.requestFocus();
//			return;
//		} else if (etVillage.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_village));
//			etVillage.requestFocus();
//			return;
//		} else if (etMooNo.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_mooNo));
//			etMooNo.requestFocus();
//			return;
//		} else if (etStreet.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_street));
//			etStreet.requestFocus();
//			return;
		} else if (etPostcode.getText().toString().equalsIgnoreCase("")) {

			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_postcode));
			etPostcode.requestFocus();
			return;
//		} else if (etSpouseNid.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_spouseNid));
//			etSpouseNid.requestFocus();
//			return;
//		} else if (etSpouseName.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_spouseName));
//			etSpouseName.requestFocus();
//			return;
//		} else if (etSpouseSurname.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_spouseSurname));
//			etSpouseSurname.requestFocus();
//			return;
//		} else if (etSpousePassportNo.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.lang_th_Label_user_profile_spousePassportNo));
//			etSpousePassportNo.requestFocus();
//			return;
//		} else if (etTxpFatherPin.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", messageError.getFieldMessage(ElementMessage.txpFatherPinEmpty));
//			etTxpFatherPin.requestFocus();
//			return;
//		} else if (etSpouseTxpFatherPin.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", messageError.getFieldMessage(ElementMessage.newPasswordEmpty));
//			etSpouseTxpFatherPin.requestFocus();
//			return;
//		} else if (etTxpMotherPin.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.label_txpMontherPin_spouse_en));
//			etTxpMotherPin.requestFocus();
//			return;
//		} else if (etSpouseTxpMotherPin.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", prefix + getString(R.string.label_txpMontherPin_spouse_en));
//			etSpouseTxpMotherPin.requestFocus();
//			return;
//		} else if (etChildNoStudy.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", messageError.getFieldMessage(ElementMessage.childNoStudyEmpty));
//			etChildNoStudy.requestFocus();
//			return;
//		} else if (etChildStudy.getText().toString().equalsIgnoreCase("")) {
//
//			popup.show("", messageError.getFieldMessage(ElementMessage.childStudyEmpty));
//			etChildStudy.requestFocus();
//			return;
		}
	}

	private void validateGeneralUserAndAddress() {
		String prefix = "โปรดใส่";
		if (!Validate.checkBlank(etName.getText().toString())) {
			return;
		} else {
			profileSend.setName(etName.getText().toString());
		}

		if (!Validate.checkBlank(etMiddleName.getText().toString())) {
			return;
		} else {
			// have no Middlename in the model
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
