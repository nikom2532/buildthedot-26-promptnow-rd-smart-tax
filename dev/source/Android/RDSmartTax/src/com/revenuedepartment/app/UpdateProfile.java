package com.revenuedepartment.app;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.Typeface;
import android.location.Location;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnTouchListener;
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
import com.promptnow.network.model.lgauthen.AuthenData;
import com.promptnow.network.model.pfupdateprofile.UpdateProfileRequest;
import com.promptnow.network.model.pfupdateprofile.UpdateProfileResponse;
import com.promptnow.network.model.rqamphur.AmphurRequest;
import com.promptnow.network.model.rqamphur.AmphurResponse;
import com.promptnow.network.model.rqamphur.Tambol;
import com.promptnow.network.model.rqprovince.ProvinceRequest;
import com.promptnow.network.model.rqprovince.ProvinceResponse;
import com.promptnow.network.service.AsyncTaskCompleteListener;
import com.promptnow.network.service.LocationHelper;
import com.promptnow.network.service.ServiceAsyn;
import com.promptnow.network.service.UtilCalendar;
import com.promptnow.network.service.UtilTextWatcher;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_MarryHash;
import com.revenuedepartment.datamodels.M_SpouseHash;
import com.revenuedepartment.datamodels.M_TaxPayerHash;
import com.revenuedepartment.function.DateUtils1;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.Validate;
import com.revenuedepartment.req_datamodels.MRequest_UpdateProfile;
import com.revenuedepartment.service.ElementMessage;
import com.revenuedepartment.service.ElementPlaceHolder;
import com.revenuedepartment.service.GetAuthen;
import com.revenuedepartment.service.GetMessageError;
import com.revenuedepartment.service.GetPlaceHolders;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.SharedPref;

public class UpdateProfile extends Activity implements OnClickListener, AsyncTaskCompleteListener {
	EditText etName;
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
	Spinner spProvince;
	Spinner spAmphur;
	Spinner spTambol;
	EditText etPostcode;
	Spinner spTaxpayerStatus;
	Spinner spSpouseStatus;
	Spinner spMarryStatus;
	EditText etSpouseNid;
//	Spinner etTitleName;
	EditText etTitleName;
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
	AuthenData mData;
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
	Location currentLocation;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		
		//piyawat 20140204 1217
		LocationHelper mLocationHelper = new LocationHelper(this);
		currentLocation = mLocationHelper.getCurrentLocation();
		
		
		if ( LocationHelper.isGPSAvaliable(this) )  mLocationHelper.startUpdateLocation();
		
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
		///////////////		Province		//////////////////
		callProvince();
		///////////////		#Province		////////////////// 	 
	}
	
	private void callService(String service, Object request) {
		Gson g = new Gson(); 
		String json = g.toJson(request); 
		logRequest("UpdateProfile", "request\n" + json); 
		new ServiceAsyn(this, json, service).execute(); 
	} 
	 
	ProvinceResponse provinceRes;
	AmphurResponse amphurRes;
	boolean firstCome = true;
	@Override
	public void onTaskComplete(String result, String service) {
		Log.i("response", "response : "+result);
		
		try { 
			Gson g = new Gson(); 
			JSONObject jsonObject = new JSONObject(result); 
			if(service.equals("rq-province")){
				provinceRes = g.fromJson(result, ProvinceResponse.class); 
				setProvince(); 
				///////////////		Amphur		//////////////////
				callAmphur();
				///////////////		#Amphur	////////////////// 	
			} else if(service.equals("rq-amphur")){
				Log.i("Joe", "do amphur"); 
				amphurRes = g.fromJson(result, AmphurResponse.class); 
				setAmphur(); 
				setTambol(); 
				
				firstCome = false;
			} else if(ServiceAsyn.haveKey(jsonObject, "responseMessage")){
				PopupDialog popup = new PopupDialog(this);
				UpdateProfileResponse response = g.fromJson(result, UpdateProfileResponse.class);
				Log.i("Joe", response.responseMessage); 
				popup.show(response.responseMessage);
			} 
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} 
	}   

	private void initLoginData() {  
		if (mData != null) {  
			initSpinner();
			
//			logRequest("mData", mData);
			 
//			etAmphur.setSelection(amphurMap.get(mData.amphur));
//			mData.authenKey;// : 311040077946710022557043026417
//			mData.birthDate;// : 07062509
//			etBuildName.setText(mData.buildName);// : 
//			etChildNoStudy.setText(mData.childNoStudy);// : 1
//			etChildStudy.setText(mData.childStudy);// : 1
//			mData.contractNo);// : 0841485702
//			mData.countryCode);// : 
//			mData.displaySatisfication);// : 
//			etEmail.setText(mData.email);// : supida.ng@rd.go.th
//			etFloorNo.setText(mData.floorNo);// : 
//			mData.indcForm);// : 0
//			mData.lastAccessed);// : 
//			mData.loginFirst);// : 
//			mData.marryHash);// : com.revenuedepartment.datamodels.M_MarryHash@420d4d30
//			mData.marryStatus);// : 0
//			etMiddleName.setText(mData.middleName);// : 
//			etMooNo.setText(mData.mooNo);// : 9
//			etName.setText(mData.name);// : ??????
//			etNid.setText(mData.nid);// : 3110400779467
//			etPasssportNo.setText(mData.passportNo);// : 
//			etPostcode.setText(mData.postcode);// : 11120
//			etProvince.setSelection(provinceMap.get(mData.province));// : ???????
//			mData.responseData);// : 
//			etRoomNo.setText(mData.roomNo);// : 
//			etSoi.setText(mData.soi);// : ??????????
//			mData.spouseBirthDate);// : 12112509
//			mData.spouseCountryCode);// : 
//			etSpouseTxpFatherPin.setText(mData.spouseFatherPin);// : 
//			mData.spouseHash);// : com.revenuedepartment.datamodels.M_SpouseHash@420d4d10
//			etSpouseTxpMotherPin.setText(mData.spouseMotherPin);// : 
//			etSpouseName.setText(mData.spouseName);// : ??????
//			etSpouseNid.setText(mData.spouseNid);// : 3480900131277
//			etSpousePassportNo.setText(mData.spousePassportNo);// : 
//			mData.spouseStatus);// : 1
//			etSpouseSurname.setText(mData.spouseSurname);// : ???????????
//			etStreet.setText(mData.street);// : ?????????
//			etSurname.setText(mData.surname);// : ???????????
//			etTambol.setSelection(tambolMap.get(mData.tambol));// : ??????
//			mData.taxpayerHash);// : com.revenuedepartment.datamodels.M_TaxPayerHash@420d4ce0
//			spTaxpayerStatus.setSelection(mData.taxpayerStatus);// : 1
//			mData.termsConditionDetail);// : 
//			mData.thaiNation);// : 1  
//			etTitleName.setSelection(titleMap.get(mData.titleName));
//			mData.txpFatherPin);// : 
//			mData.txpMotherPin);// : 3110400779441
//			etVillage.setText(mData.village);// : ???????????

			
			etNid.setText(DataForShared.getNidFormat());// : 3110400779467
			etName.setText(mData.name);// : ??????
			etSurname.setText(mData.surname);// : ???????????
			etBuildName.setText(mData.buildName);// : 
			etRoomNo.setText(mData.roomNo);// : 
			etFloorNo.setText(mData.floorNo);// : 
			etAddressNo.setText(mData.addressNo);
			etSoi.setText(mData.soi);// : ??????????
			etVillage.setText(mData.village);// : ???????????
			etMooNo.setText(mData.mooNo);// : 9
			etStreet.setText(mData.street);// : ?????????
			Log.i("Joe", "data tambol : "+mData.tambol);
			Log.i("Joe", "tambolMap : "+tambolMap);
			spTambol.setSelection(tambolMap.get(mData.tambol));// : ??????
			spAmphur.setSelection(amphurMap.get(mData.amphur));
			spProvince.setSelection(provinceMap.get(mData.province));
			etPostcode.setText(mData.postcode);// : 11120
//			taxpayerStatus));
//			mData.spouseStatus);// : 1
//			marryStatus));
			etSpouseNid.setText(DataForShared.getNidFormat());
			etSpouseName.setText(mData.spouseName);// : ??????
			etSpouseSurname.setText(mData.spouseSurname);// : ???????????
			etChildNoStudy.setText(mData.childNoStudy);// : 1
			etChildStudy.setText(mData.childStudy);// : 1
//			txpFatherPin));
//			txpMotherPin));
			etSpouseTxpFatherPin.setText(mData.spouseFatherPin);// 
			etSpouseTxpMotherPin.setText(mData.spouseMotherPin);// : 
//			authenKey));
//			version));
			etPasssportNo.setText(mData.passportNo);// : 
//			countryCode));
			etEmail.setText(mData.email);// : supida.ng@rd.go.th
//			phoneNumber));
			etSpousePassportNo.setText(mData.spousePassportNo);// : 
//			spouseCountryCode));
//			spouseBirthDate));
			etMiddleName.setText(mData.middleName);// : 
			Log.i("Joe","mData.titleName : "+mData.titleName);
//			etTitleName.setSelection(titleMap.get(mData.titleName));
			etTitleName.setText(mData.titleName);
			Log.e("palmmmmmmmmm","mData.titleName : "+mData.titleName);
			
//			birthDate));
//			indcForm));
//			spouseMiddleName));

			
			
//			etTelephone.setText(mData.getContractNo());

			// xx-xxxx-xxxx
			String textTelephone = "";
//			textTelephone = "0812345678";
			textTelephone = "0897706773";
			String textTelephoneWithDash = textTelephone.substring(0, 2) + "-" + textTelephone.substring(2, 6) + "-" + textTelephone.substring(6, 10);

//			writeLog.LogV("textTelephone", textTelephoneWithDash);
			etTelephone.setText(textTelephoneWithDash);
			
			
			etEmail.setText(mData.getEmail());
		}
	}

	private void callProvince() { 
		ProvinceRequest requestPV = new ProvinceRequest();
		requestPV.sessionID = PromptnowCommandData.JSESSIONID; 
//		requestPV.language = "TH"; // EN, TH
		if(currentLocation!=null) {
			requestPV.longitude = Double.toString(currentLocation.getLongitude());//"100.558611";
			requestPV.latitude = Double.toString(currentLocation.getLatitude());//"13.807465";
		}
		requestPV.deviceID = new GetDeviceID(UpdateProfile.this).getDeviceID();
//		requestPV.deviceType = "android"; 
//		Log.i("Joe","time \n"+UtilCalendar.getCurrentTimeFormat("yyyy-MM-dd HH:mm:ss"));
		requestPV.clientDateTime = UtilCalendar.getCurrentTimeFormat("yyyy-MM-dd HH:mm:ss");//"2013-07-18 00:00:00";
		callService("rq-province", requestPV); 
	}

	private void callAmphur() {
		AmphurRequest requestAP = new AmphurRequest();
		requestAP.sessionID = PromptnowCommandData.JSESSIONID;
		if(currentLocation!=null) {
			requestAP.longitude = Double.toString(currentLocation.getLongitude());//"100.558611";
			requestAP.latitude = Double.toString(currentLocation.getLatitude());//"13.807465";
		}
		requestAP.deviceID = new GetDeviceID(UpdateProfile.this).getDeviceID();
		requestAP.clientDateTime = UtilCalendar.getCurrentTimeFormat("yyyy-MM-dd HH:mm:ss");
		
		int selectedProvince = spProvince.getSelectedItemPosition(); 
		selectedProvince = selectedProvince>=0? selectedProvince : 0; 
		requestAP.provinceID = provinceRes.proID[selectedProvince];
		Log.i("Joe", "requestAP.provinceID : "+requestAP.provinceID);
		callService("rq-amphur", requestAP);
	} 
	 
	
	private void callUpdateProfile() { 
		UpdateProfileRequest request = new UpdateProfileRequest();
		request.sessionID = PromptnowCommandData.JSESSIONID;
		
		request.language = "TH";
		
		if(currentLocation!=null) {
			request.longitude = Double.toString(currentLocation.getLongitude());//"100.558611";
			request.latitude = Double.toString(currentLocation.getLatitude());//"13.807465";
		}
		request.deviceID = new GetDeviceID(UpdateProfile.this).getDeviceID();
		request.deviceType = "iphone";
		request.clientDateTime = UtilCalendar.getCurrentTimeFormat("yyyy-MM-dd HH:mm:ss"); 
				
				
		request.nid = mValue.getString(JSONElement.nid);
		request.name = etName.getText().toString();
		request.surname = etSurname.getText().toString();
		request.buildName = "develop building";//etBuildName.getText().toString();
		request.roomNo = etRoomNo.getText().toString();
		request.floorNo = etFloorNo.getText().toString(); 
		request.addressNo = etAddressNo.getText().toString();
		request.soi = etSoi.getText().toString();
		request.village = etVillage.getText().toString();
		request.mooNo = etMooNo.getText().toString();
		request.street = etStreet.getText().toString();
		request.tambol = amphurRes.tambolID[spTambol.getSelectedItemPosition()];
		request.amphur = amphurRes.amphurID[spAmphur.getSelectedItemPosition()];
		request.province = provinceRes.proID[spProvince.getSelectedItemPosition()];
		request.postcode = etPostcode.getText().toString();
		request.taxpayerStatus = Integer.toString(spTaxpayerStatus.getSelectedItemPosition());
		request.spouseStatus =  Integer.toString(spSpouseStatus.getSelectedItemPosition());
		request.marryStatus =  Integer.toString(spMarryStatus.getSelectedItemPosition());
		request.spouseNid = etSpouseNid.getText().toString();
		request.spouseName = etSpouseName.getText().toString();
		request.spouseSurname = etSpouseSurname.getText().toString();
		request.childNoStudy = etChildNoStudy.getText().toString();
		request.childStudy = etChildStudy.getText().toString();	
		request.txpFatherPin = etTxpFatherPin.getText().toString();
		request.txpMotherPin = etTxpMotherPin.getText().toString();	
		request.spouseFatherPin = etSpouseTxpFatherPin.getText().toString();
		request.spouseMotherPin = etSpouseTxpMotherPin.getText().toString();
		request.authenKey = mValue.getString(JSONElement.authenKey);
		request.passsportNo = etPasssportNo.getText().toString();	//	M/O
		request.countryCode = mData.getCountryCode();	//?						//	M/O
		request.email = etEmail.getText().toString();	
		request.contractNo/*phoneNumber*/ = mData.getContractNo();	//?
		request.spousePassportNo = etPasssportNo.getText().toString(); 	//?
		request.spouseCountryCode = mData.getSpouseCountryCode();	//?
		request.spouseBirthDate = mData.getSpouseBirthDate();	//?
		request.middleName = etMiddleName.getText().toString();	//? 
//		request.titleName = etTitleName.getSelectedItem().toString();	//? 
		request.titleName = etTitleName.getText().toString();
		request.birthDate = mData.birthDate;//"20011990";	//?
		request.indcForm = mData.indcForm;//"0";	//?
		request.spouseMiddleName = "";//"middle name";	//?
 
		
		/*request.nid = "3750100119105";//mValue.getString(JSONElement.nid);
		request.name = "ยศวัฒน์";//etName.getText().toString();
		request.surname = "วัฒนปรีชานันท์";//etSurname.getText().toString();
		request.buildName = "ลิฟวิ่งเพลสคอนโด";//"develop building";//etBuildName.getText().toString();
		request.roomNo = "";//"191";//etRoomNo.getText().toString();
		request.floorNo = "21";//"12";//etFloorNo.getText().toString(); 
		request.addressNo = "90";//etAddressNo.getText().toString();
		request.soi = "ลาดพร้าว138(มีสุข)";//etSoi.getText().toString();
		request.village = "";//etVillage.getText().toString();
		request.mooNo = "";//etMooNo.getText().toString();
		request.street = "พหลโยธิน";//etStreet.getText().toString();
		request.tambol = "104302";//amphurRes.tambolID[etTambol.getSelectedItemPosition()];
		request.amphur = "000012";//amphurRes.amphurID[etAmphur.getSelectedItemPosition()];
		request.province = "000002";//provinceRes.proID[etProvince.getSelectedItemPosition()];
		request.postcode = "10240";//etPostcode.getText().toString();
		request.taxpayerStatus = "1";//Integer.toString(spTaxpayerStatus.getSelectedItemPosition());
		request.spouseStatus =  "1";//Integer.toString(spSpouseStatus.getSelectedItemPosition());
		request.marryStatus =  "0";//Integer.toString(spMarryStatus.getSelectedItemPosition());
		request.spouseNid = "3859900010938";//"3480900131277";//etSpouseNid.getText().toString();
		request.spouseName = "พงษ์ศักดิ์";//etSpouseName.getText().toString();
		request.spouseSurname = "ชนาธิป";//etSpouseSurname.getText().toString();
		request.childNoStudy = "2";//etChildNoStudy.getText().toString();
		request.childStudy = "1";//etChildStudy.getText().toString();	
		request.txpFatherPin = "3750100119041";//"1234567890123";//etTxpFatherPin.getText().toString();
		request.txpMotherPin = "3750100119091";//"3210987654321";//etTxpMotherPin.getText().toString();	
		request.spouseFatherPin = "";//"3423342345212";//etSpouseTxpFatherPin.getText().toString();
		request.spouseMotherPin = "";//"3423359294827";//etSpouseTxpMotherPin.getText().toString();
		request.authenKey = mValue.getString(JSONElement.authenKey);
		request.passsportNo = "";//"IF3423434";//etPasssportNo.getText().toString();	//	M/O
		request.countryCode = "";//"66";//mData.getCountryCode();	//?						//	M/O
		request.email = "yosawat.wa@rd.go.th";// etEmail.getText().toString();	
//		request.phoneNumber = mData.getContractNo();	//?
		request.contractNo = mData.getContractNo();
		request.spousePassportNo = "";//"IE5688781";//etPasssportNo.getText().toString(); 	//?
		request.spouseCountryCode = "";//"66";//mData.getSpouseCountryCode();	//?
		request.spouseBirthDate = "20012000";//mData.getSpouseBirthDate();	//?
		request.middleName = "";//"mid";//etMiddleName.getText().toString();	//? 
		request.titleName = "นาย";//etTitleName.getSelectedItem().toString();	//? 
		request.birthDate = "13092519";//mData.birthDate;//"20011990";	//?
		request.indcForm = "0";//mData.indcForm;//"0";	//?
		request.spouseMiddleName = "";//"middle name";	//?
*/		
		
		Log.i("mData", "sessionID : "+request.sessionID);
		Log.i("mData", "language : "+request.language);
		Log.i("mData", "deviceID : "+request.deviceID);
		Log.i("mData", "deviceType : "+request.deviceType);
		Log.i("mData", "nid : "+request.nid);
		Log.i("mData", "name : "+request.name);
		Log.i("mData", "surname : "+request.surname);
		Log.i("mData", "buildName : "+request.buildName);
		Log.i("mData", "roomNo : "+request.roomNo);
		Log.i("mData", "floorNo : "+request.floorNo);
		Log.i("mData", "addressNo : "+request.addressNo);
		Log.i("mData", "soi : "+request.soi);
		Log.i("mData", "village : "+request.village);
		Log.i("mData", "mooNo : "+request.mooNo);
		Log.i("mData", "street : "+request.street);
		Log.i("mData", "tambol : "+request.tambol);
		Log.i("mData", "amphur : "+request.amphur);
		Log.i("mData", "province : "+request.province);
		Log.i("mData", "postcode : "+request.postcode);
		Log.i("mData", "taxpayerStatus : "+request.taxpayerStatus);
		Log.i("mData", "spouseStatus : "+request.spouseStatus);
		Log.i("mData", "marryStatus : "+request.marryStatus);
		Log.i("mData", "spouseNid : "+request.spouseNid);
		Log.i("mData", "spouseName : "+request.spouseName);
		Log.i("mData", "spouseSurname : "+request.spouseSurname);
		Log.i("mData", "childNoStudy : "+request.childNoStudy);
		Log.i("mData", "childStudy : "+request.childStudy);
		Log.i("mData", "txpFatherPin : "+request.txpFatherPin);
		Log.i("mData", "txpMotherPin : "+request.txpMotherPin);
		Log.i("mData", "spouseFatherPin : "+request.spouseFatherPin);
		Log.i("mData", "spouseMotherPin : "+request.spouseMotherPin);
		Log.i("mData", "authenKey : "+request.authenKey);
		Log.i("mData", "passsportNo : "+request.passsportNo);//passsportNo	//	M/O
		Log.i("mData", "countryCode : "+request.countryCode);//countryCode	//	M/O
		Log.i("mData", "email : "+request.email);
		Log.i("mData", "contractNo : "+request.contractNo);
		Log.i("mData", "spousePassportNo : "+request.spousePassportNo);//spousePassportNo
		Log.i("mData", "spouseCountryCode : "+request.spouseCountryCode);//spouseCountryCode
		Log.i("mData", "spouseBirthDate : "+request.spouseBirthDate);//spouseBirthDate
		Log.i("mData", "middleName : "+request.middleName);//middleName 
		Log.i("mData", "titleName : "+request.titleName);
		Log.i("mData", "birthDate : "+request.birthDate);
		Log.i("mData", "indcForm : "+request.indcForm);
		Log.i("mData", "spouseMiddleName : "+request.spouseMiddleName);//spouseMiddleName
		
//		logRequest("request", request); 
		
		callService("pf-update-taxpayerprofile", request);
	}
	
	private void logRequest(String tag, Object request) {
		try {
			String classForName = request.getClass().getCanonicalName();
			Class<?> clfn = Class.forName(classForName);
			Field[] fields = request.getClass().getDeclaredFields();
			Log.i(tag, "|||||||"+request.getClass().getName()+"|||||||");
			for(int index=0; index<fields.length; index++){  
				Field field = clfn.getDeclaredField(fields[index].getName()); 
				field.setAccessible(true);
				Object value = field.get(request);
				Log.i(tag, fields[index].getName()+" : "+value.toString()); 
			}
		} catch (NoSuchFieldException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

	Map<String, Integer> provinceMap = new HashMap<String, Integer>();
	private void setProvince() { 
		Log.i("Joe", "do province");
		
		provinceRes.proID = new String[provinceRes.province.size()];
		provinceRes.proName = new String[provinceRes.province.size()];
		
		for(int index=0; index<provinceRes.province.size(); index++){
			provinceRes.proID[index] = provinceRes.province.get(index).id;
			provinceRes.proName[index] = provinceRes.province.get(index).name;
			provinceMap.put(provinceRes.province.get(index).name, index);
		}
		setAdapter(spProvince, provinceRes.proName);
		setProvinceListener();
		if(firstCome)  spProvince.setSelection(provinceMap.get(mData.province)); 
	} 

	Map<String, Integer> amphurMap = new HashMap<String, Integer>();
	private void setAmphur() {
		amphurRes.amphurID = new String[amphurRes.amphur.size()];
		amphurRes.amphurName = new String[amphurRes.amphur.size()];
		 
		for(int index=0; index<amphurRes.amphur.size(); index++){
			Log.i("Joe", "amphur name : "+amphurRes.amphur.get(index).amphurName);
			amphurRes.amphurID[index] = amphurRes.amphur.get(index).amphurID;
			amphurRes.amphurName[index] = amphurRes.amphur.get(index).amphurName; 
			amphurMap.put(amphurRes.amphur.get(index).amphurName, index);
		}
		
		setAdapter(spAmphur, amphurRes.amphurName);
		setAmphurListener(); 
		if(firstCome) spAmphur.setSelection(amphurMap.get(mData.amphur));
	}
	
	Map<String, Integer> tambolMap = new HashMap<String, Integer>();
	private void setTambol() {
		int amphurSelected = spAmphur.getSelectedItemPosition();
		List<Tambol> tambols = amphurRes.amphur.get(amphurSelected).tambol; 
		amphurRes.tambolID = new String[tambols.size()];
		amphurRes.tambolName = new String[tambols.size()];
		for(int index=0; index<tambols.size(); index++){
			amphurRes.tambolID[index] = tambols.get(index).tambolID;
			amphurRes.tambolName[index] = tambols.get(index).tambolName;
			tambolMap.put(tambols.get(index).tambolName, index);
		} 
		
		setAdapter(spTambol, amphurRes.tambolName); 
		if(firstCome) {
			spTambol.setSelection(tambolMap.get(mData.tambol));
			initLoginData();
		}
	} 

	private boolean promptProvinceService = false;
	private void setProvinceListener() {
		spProvince.setOnTouchListener(new OnTouchListener() {
			
			public boolean onTouch(View v, MotionEvent event) {
				
				switch (event.getAction()) {
				case MotionEvent.ACTION_DOWN:  
					promptProvinceService = true;
					Log.i("Joe", "promptProvinceService : "+promptProvinceService);
					break;
					
				case MotionEvent.ACTION_UP: 
					break;

				default:
					break;
				}
				
				return false;
			}
		});
		
		spProvince.setOnItemSelectedListener(new OnItemSelectedListener() { 
			
			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					final int arg2, long arg3) {  
				Log.i("Joe", "on selected : "+arg2+", "+arg3);
				if(promptProvinceService) callAmphur();
				promptProvinceService = false;
				Log.i("Joe", "promptProvinceService : "+promptProvinceService);
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) { 
			} 
		});
	}
	
	private boolean promptAmphurService = false;
	private void setAmphurListener() {
		spAmphur.setOnTouchListener(new OnTouchListener() {
			
			public boolean onTouch(View v, MotionEvent event) {
				
				switch (event.getAction()) {
				case MotionEvent.ACTION_DOWN:  
					promptAmphurService = true;
					Log.i("Joe", "promptAmphurService : "+promptAmphurService);
					break;
					
				case MotionEvent.ACTION_UP: 
					break;

				default:
					break;
				}
				
				return false;
			}
		});
		
		spAmphur.setOnItemSelectedListener(new OnItemSelectedListener() { 
			
			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					final int arg2, long arg3) {  
				Log.i("Joe", "on selected : "+arg2+", "+arg3);
				if(promptAmphurService) setTambol();
				promptAmphurService = false;
				Log.i("Joe", "promptAmphurService : "+promptAmphurService);
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) { 
			} 
		});
	}
	
	
	// TODO Authen;  
	
/*	private void setAdapter(Spinner sp, ArrayAdapter<String> adapterArr, String[] stringArr) {  
//			log("setAdapter : "+mapping.nameMapping );
//			log("setAdapter name : "+mapping.nameMapping+" type : "+mapping.type+", mapping.stringArr : "+mapping.stringArr.length);
			adapterArr = new ArrayAdapter<String>(this,android.R.layout.simple_dropdown_item_1line, stringArr);//{ 
//			@Override
//			public View getView(int position, View convertView,
//					ViewGroup parent) {
//					 View v = super.getView(position, convertView, parent);
//					 return getFont20(v);
//				}
//			@Override
//			public View getDropDownView(int position, View convertView,
//					ViewGroup parent) {	
//					View v =super.getDropDownView(position, convertView, parent);
//					return getFontSelect(v);
//				}
//			};
			adapterArr.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item); 
			sp.setAdapter(adapterArr); 
			 
//			sp.setSelection(index);  
	}*/
	
	private void setAdapter(Spinner sp, String[] stringArr) { 
		ArrayAdapter<String> adapterArr = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, stringArr);
		adapterArr.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);//R.layout.text_spinner_items);
		sp.setAdapter(adapterArr);
//		if(provinceData!=null){
//			if(provinceData.idProvince.length>0){
//				int selectedIndex = Integer.parseInt(provinceData.idProvince[sp.getSelectedItemPosition()]);
//				sp.setSelection(selectedIndex, true);
//			} else {
//				sp.setSelection(0, true);
//			}
//		}
//		spSpouseStatus.setSelection(parseInt(mData.getSpouseStatus()));
	}

	
	protected View getFont20(View v) { 
		 ((TextView) v).setTypeface(getTypeface());
     ((TextView) v).setTextColor(Color.parseColor("#000000"));
     ((TextView) v).setGravity(Gravity.RIGHT);
     ((TextView) v).setTextSize(22);
		return v;
	} 
	
	protected View getFontSelect(View v) {
		((TextView) v).setTypeface(getTypeface());
     ((TextView) v).setTextColor(Color.parseColor("#000000"));
     ((TextView) v).setTextSize(20);
		return v;
	}
	
	Typeface tf = null;
	private Typeface getTypeface(){
		if(tf==null) tf = Typeface.createFromAsset(this.getAssets(), "fonts/PSL-Kittithada.ttf");
		return tf;
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
//		txTitleName1 = (TextViewCustom) findViewById(R.id.txTitleName1);
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
		spProvince = (Spinner) findViewById(R.id.etProvince);
		spAmphur = (Spinner) findViewById(R.id.etAmphur);
		spTambol = (Spinner) findViewById(R.id.etTambol);
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
//		etTitleName = (Spinner) findViewById(R.id.etTitleName);
		etTitleName = (EditText) findViewById(R.id.etTitleName);

		M_TaxPayerHash taxPayerHash = mData.getTaxpayerHash();
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT0Value(), taxPayerHash.getT0()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT1Value(), taxPayerHash.getT1()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT2Value(), taxPayerHash.getT2()));
		taxPayerHashList.add(new ObjectSpinner(taxPayerHash.getT3Value(), taxPayerHash.getT3()));
		for (int i = 0; i < taxPayerHashList.size(); i++) {
			nametaxPayerHashList.add(taxPayerHashList.get(i).name);
		}

		ArrayAdapter<String> taxPayerHashAdapter = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, nametaxPayerHashList);
		taxPayerHashAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);//text_spinner_items);
		spTaxpayerStatus.setAdapter(taxPayerHashAdapter);
		spTaxpayerStatus.setSelection(parseInt(mData.getTaxpayerStatus()));

		M_SpouseHash spouseHash = mData.getSpouseHash();
		spouseHashList.add(new ObjectSpinner(spouseHash.getT0Value(), spouseHash.getT0()));
		spouseHashList.add(new ObjectSpinner(spouseHash.getT1Value(), spouseHash.getT1()));
		for (int i = 0; i < spouseHashList.size(); i++) {
			nameSpouseHashList.add(spouseHashList.get(i).name);
		}
		ArrayAdapter<String> spouseHashAdapter = new ArrayAdapter<String>(UpdateProfile.this, R.layout.text_spinner, nameSpouseHashList);
		spouseHashAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);//text_spinner_items);
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
		marryHashAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);//R.layout.text_spinner_items);
		spMarryStatus.setAdapter(marryHashAdapter);
		spMarryStatus.setSelection(parseInt(mData.getMarryStatus()));

		spTaxpayerStatus.setOnItemSelectedListener(statusChange);
		spSpouseStatus.setOnItemSelectedListener(statusChange);
		// spMarryStatus.setOnItemSelectedListener(statusChange);

//		ArrayAdapter<String> etTitleNameSpinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, android.R.id.text1);
//		etTitleNameSpinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//		etTitleName.setAdapter(etTitleNameSpinnerAdapter);
//		etTitleNameSpinnerAdapter.add(UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list1)));
//		etTitleNameSpinnerAdapter.add(UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list2)));
//		etTitleNameSpinnerAdapter.add(UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list3)));
//		etTitleNameSpinnerAdapter.add(UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list4)));
//		etTitleNameSpinnerAdapter.add(UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list5)));
//		etTitleNameSpinnerAdapter.add(UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list6)));
//		etTitleNameSpinnerAdapter.notifyDataSetChanged();
		
		
//		palm 17/2/2014
//		String[] titleArr = new String[6];
//		titleArr[0] = UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list1));
//		titleArr[1] = UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list2));
//		titleArr[2] = UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list3));
//		titleArr[3] = UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list4));
//		titleArr[4] = UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list5));
//		titleArr[5] = UtilGetStringLang.getTextOnLang(this, etTitleName, getString(R.string.lang_th_Label_user_profile_middlename_list6));
//		 
//		for(int index=0; index<titleArr.length; index++){
//			titleMap.put(titleArr[index], index);
//		}
//		setAdapter(etTitleName, titleArr);

	}
	Map<String, Integer> titleMap = new HashMap<String, Integer>();
	
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

		etNid.addTextChangedListener(new UtilTextWatcher(etNid, this));
		etTelephone.addTextChangedListener(textWatcherEtTelephone);
		etSpouseNid.addTextChangedListener(new UtilTextWatcher(etSpouseNid, this));

		etSpouseTxpFatherPin.addTextChangedListener(textWatcherSpouseTxpFatherPin);
		etSpouseTxpMotherPin.addTextChangedListener(textWatcherSpouseTxpMotherPin);

		etTxpFatherPin.addTextChangedListener(textWatcherTxpFatherPin);
		etTxpMotherPin.addTextChangedListener(textWatcherMotherPin);

	}

	void initKeyboardInput() {

		etTelephone.setRawInputType(Configuration.KEYBOARD_QWERTY);
		etNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
//		txNid.setRawInputType(Configuration.KEYBOARD_QWERTY);
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

	
//	if(v.equals(btSubmit)){
//		// x x - x x x x - x x  x  x
//					//0 1 2 3 4 5 6 7 8 9 10 11 12
//					String textTelephone = etTelephone.getText().toString();
//					String textTelephoneWithDash = textTelephone.substring(0, 2) + textTelephone.substring(3, 7) + "-" + textTelephone.substring(8, 12);
//					
//					//********
////					int CalendarChoose = DateUtils1.componentTimeToTimestamp(mYear, mMonth, mDay, 0, 0, 0);
////					long unixSeconds = (long) CalendarChoose;
////					Date date = new Date(unixSeconds*1000L); // *1000 is to convert seconds to milliseconds
////					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // the format of your date
////					sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
////					String formattedDate = sdf.format(date);
////					
////					writeLog.LogV("birthdate", String.valueOf(formattedDate));
////					
////					saveRegister.birthDate = String.valueOf(formattedDate);
//					//********
//					
//					profileSend = new MRequest_UpdateProfile();
//
//					validateGeneralUserAndAddress();
//					validateGeneralUserAndAddress2();
//					validateCase(flag_people, taxPayerHashList.get(spTaxpayerStatus.getSelectedItemPosition()).value,
//							spouseHashList.get(spSpouseStatus.getSelectedItemPosition()).value);
//
//					// O
//					profileSend.setPhoneNumber(textTelephoneWithDash);
//					profileSend.setBuildName(etBuildName.getText().toString());
//					profileSend.setRoomNo(etRoomNo.getText().toString());
//					profileSend.setFloorNo(etFloorNo.getText().toString());
//					profileSend.setSoi(etSoi.getText().toString());
//					profileSend.setVillage(etVillage.getText().toString());
//					profileSend.setMooNo(etMooNo.getText().toString());
//					profileSend.setStreet(etStreet.getText().toString());
//					
//					
////					writeLog.LogV("spTaxpayerStatus", spTaxpayerStatus.getSelectedItem().toString());
////					spTaxpayerStatus.getSelectedItem().toString();
//					
//					
//					new requestUpdateProfile().execute();
//
//					
//					// Intent intent = new Intent(this, MainEFilling.class);
//					// startActivity(intent);
//	}
	
	@Override
	public void onClick(View v) {
		if (v.equals(btSubmit)) {
			callUpdateProfile();
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
