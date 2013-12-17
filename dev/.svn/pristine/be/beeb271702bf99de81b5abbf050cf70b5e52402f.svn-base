package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class UpdateProfile extends Activity implements OnClickListener {

	public static EditText mEditTextUserProfileName;
	public static EditText mEditTextUserProfileSurname;
	public static EditText mEditTextUserProfileTelephone;
	public static EditText mEditTextUserProfileEmail;
	public static EditText mEditTextUserProfileIncomePayer;
	public static EditText mEditTextUserProfilePasssportNo;
	public static EditText mEditTextUserProfileCountryCode;
	public static EditText mEditTextUserProfileBuildName;
	public static EditText mEditTextUserProfileRoomNo;
	public static EditText mEditTextUserProfileFloorNo;
	public static EditText mEditTextUserProfileAddressNo;
	public static EditText mEditTextUserProfileSoi;
	public static EditText mEditTextUserProfileVillage;
	public static EditText mEditTextUserProfileMooNo;
	public static EditText mEditTextUserProfileStreet;
	public static EditText mEditTextUserProfileProvince;
	public static EditText mEditTextUserProfileAmphur;
	public static EditText mEditTextUserProfileTambol;
	public static EditText mEditTextUserProfilePostcode;
	public static EditText mEditTextUserProfileTaxpayerStatus;
	public static EditText mEditTextUserProfileSpouseStatus;
	public static EditText mEditTextUserProfileMarryStatus;
	public static EditText mEditTextUserProfileSpouseNid;
	public static EditText mEditTextUserProfileTitleName;
	public static EditText mEditTextUserProfileSpouseName;
	public static EditText mEditTextUserProfileSpouseSurname;
	public static EditText mEditTextUserProfileSpousePassportNo;
	public static EditText mEditTextUserProfileSpouseCountryCode;
	public static EditText mEditTextUserProfileTxpFatherPin;
	public static EditText mEditTextUserProfileTxpMotherPin;
	public static EditText mEditTextUserProfileChildNoStudy;
	public static EditText mEditTextUserProfileChildStudy;
	public static Button mButtonUserProfileSubmit;
	
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
		setContentView(R.layout.updateprofile);
		init();
		mButtonUserProfileSubmit = (Button) findViewById(R.id.mButtonUserProfileSubmit);
		mButtonUserProfileSubmit.setOnClickListener(this);
	}
	
	@Override
	public void onClick(View v) {
	    // TODO Auto-generated method stub
//		if (mButtonUserProfileSubmit.equals(v)) {
//			if (CURRENT_STEP == STEP_CHECK) {
//				
//			} else {
//				
//			}
//		}
		Intent intent = new Intent(this, MainEFilling.class);
		startActivity(intent);
	}

	public void init(){
		mEditTextUserProfileName = (EditText) findViewById(R.id.mEditTextUserProfileName);
		mEditTextUserProfileSurname = (EditText) findViewById(R.id.mEditTextUserProfileSurname);
		mEditTextUserProfileTelephone = (EditText) findViewById(R.id.mEditTextUserProfileTelephone);
		mEditTextUserProfileEmail = (EditText) findViewById(R.id.mEditTextUserProfileEmail);
		mEditTextUserProfileIncomePayer = (EditText) findViewById(R.id.mEditTextUserProfileIncomePayer);
		mEditTextUserProfilePasssportNo = (EditText) findViewById(R.id.mEditTextUserProfilePasssportNo);
		mEditTextUserProfileCountryCode = (EditText) findViewById(R.id.mEditTextUserProfileCountryCode);
		mEditTextUserProfileBuildName = (EditText) findViewById(R.id.mEditTextUserProfileBuildName);
		mEditTextUserProfileRoomNo = (EditText) findViewById(R.id.mEditTextUserProfileRoomNo);
		mEditTextUserProfileFloorNo = (EditText) findViewById(R.id.mEditTextUserProfileFloorNo);
		mEditTextUserProfileAddressNo = (EditText) findViewById(R.id.mEditTextUserProfileAddressNo);
		mEditTextUserProfileSoi = (EditText) findViewById(R.id.mEditTextUserProfileSoi);
		mEditTextUserProfileVillage = (EditText) findViewById(R.id.mEditTextUserProfileVillage);
		mEditTextUserProfileMooNo = (EditText) findViewById(R.id.mEditTextUserProfileMooNo);
		mEditTextUserProfileStreet = (EditText) findViewById(R.id.mEditTextUserProfileStreet);
		mEditTextUserProfileProvince = (EditText) findViewById(R.id.mEditTextUserProfileProvince);
		mEditTextUserProfileAmphur = (EditText) findViewById(R.id.mEditTextUserProfileAmphur);
		mEditTextUserProfileTambol = (EditText) findViewById(R.id.mEditTextUserProfileTambol);
		mEditTextUserProfilePostcode = (EditText) findViewById(R.id.mEditTextUserProfilePostcode);
		mEditTextUserProfileTaxpayerStatus = (EditText) findViewById(R.id.mEditTextUserProfileTaxpayerStatus);
		mEditTextUserProfileSpouseStatus = (EditText) findViewById(R.id.mEditTextUserProfileSpouseStatus);
		mEditTextUserProfileMarryStatus = (EditText) findViewById(R.id.mEditTextUserProfileMarryStatus);
		mEditTextUserProfileSpouseNid = (EditText) findViewById(R.id.mEditTextUserProfileSpouseNid);
		mEditTextUserProfileTitleName = (EditText) findViewById(R.id.mEditTextUserProfileTitleName);
		mEditTextUserProfileSpouseName = (EditText) findViewById(R.id.mEditTextUserProfileTitleName);
		mEditTextUserProfileSpouseSurname = (EditText) findViewById(R.id.mEditTextUserProfileSpouseSurname);
		mEditTextUserProfileSpousePassportNo = (EditText) findViewById(R.id.mEditTextUserProfileSpousePassportNo);
		mEditTextUserProfileSpouseCountryCode = (EditText) findViewById(R.id.mEditTextUserProfileSpouseCountryCode);
		mEditTextUserProfileTxpFatherPin = (EditText) findViewById(R.id.mEditTextUserProfileTxpFatherPin);
		mEditTextUserProfileTxpMotherPin = (EditText) findViewById(R.id.mEditTextUserProfileTxpMotherPin);
		mEditTextUserProfileChildNoStudy = (EditText) findViewById(R.id.mEditTextUserProfileChildNoStudy);
		mEditTextUserProfileChildStudy = (EditText) findViewById(R.id.mEditTextUserProfileChildStudy);
	}
}
