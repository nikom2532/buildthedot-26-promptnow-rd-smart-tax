package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_RegisterConfirm;
import com.revenuedepartment.datamodels.M_SaveRegister;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.req_datamodels.MRequest_ConfirmRegister;
import com.revenuedepartment.req_datamodels.MRequest_SaveRegister;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.ElementMessage;
import com.revenuedepartment.service.ElementPlaceHolder;
import com.revenuedepartment.service.GetMessageError;
import com.revenuedepartment.service.GetPlaceHolders;

public class RegisterStep3 extends Activity implements OnClickListener {
	TopBar topbar;
	EditText txCountryCode, txBuildName, txRoomNo, txFloorNo;
	EditText txAddressNo, txSoi, txVillage, txMooNo, txStreet;
	// EditText txProvince;
	Spinner etProvince;
	// EditText txAmphur;
	Spinner etAmphur;
	// EditText txTambol;
	Spinner etTambol;
	EditText txPostcode;
	ButtonCustom btNext;
	
	PopupDialog popup = new PopupDialog(RegisterStep3.this);
	GetMessageError messageError;
	GetPlaceHolders placeHolders;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		messageError = new GetMessageError(RegisterStep3.this);
		placeHolders = new GetPlaceHolders(RegisterStep3.this);
		setView();
	}

	public void setView() {
		setContentView(R.layout.registerstep3);
		topbar = (TopBar) findViewById(R.id.topbar);
		txCountryCode = (EditText) findViewById(R.id.txCountryCode);
		txBuildName = (EditText) findViewById(R.id.txBuildName);
		txRoomNo = (EditText) findViewById(R.id.txRoomNo);
		txFloorNo = (EditText) findViewById(R.id.txFloorNo);
		txAddressNo = (EditText) findViewById(R.id.txAddressNo);
		txSoi = (EditText) findViewById(R.id.txSoi);
		txVillage = (EditText) findViewById(R.id.txVillage);
		txMooNo = (EditText) findViewById(R.id.txMooNo);
		txStreet = (EditText) findViewById(R.id.txStreet);
		// txProvince = (EditText) findViewById(R.id.txProvince);
		etProvince = (Spinner) findViewById(R.id.etProvince);
		// txAmphur = (EditText) findViewById(R.id.txAmphur);
		etAmphur = (Spinner) findViewById(R.id.etAmphur);
		// txTambol = (EditText) findViewById(R.id.txTambol);
		etTambol = (Spinner) findViewById(R.id.etTambol);
		txPostcode = (EditText) findViewById(R.id.txPostcode);
		btNext = (ButtonCustom) findViewById(R.id.btNext);
		btNext.setDefault();
		btNext.setOnClickListener(this);
		topbar.setTitle(getString(R.string.txRegister));

		// txFloorNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		// txAddressNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		txMooNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		// txPostcode.setRawInputType(Configuration.KEYBOARD_QWERTY);
		
		setOnFocusChangeListener();
		setHint();
	}
	
	private void setHint(){
		txCountryCode.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.countryCode));
		txBuildName.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.buildName));
		txRoomNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.roomNo));
		txFloorNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.floorNo));
		txAddressNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.addressNo));
		txSoi.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.soi));
		txVillage.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.village));
		txMooNo.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.mooNo));
		txStreet.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.street));
		txPostcode.setHint(placeHolders.getFieldMessage(ElementPlaceHolder.postcode));
	}
	
	private class requestRegister extends
	AsyncTask<String, Void, M_RegisterConfirm> {
		
		DialogProcess dialog = new DialogProcess(RegisterStep3.this);
		ConnectApi connApi = new ConnectApi(RegisterStep3.this);
		MRequest_ConfirmRegister confirmRegister = new MRequest_ConfirmRegister();
		String JSONObjSend;
		
		public requestRegister() {
			// TODO Auto-generated constructor stub
			confirmRegister.nid = "";
			confirmRegister.buildName = txBuildName.getText().toString();
			confirmRegister.roomNo = txRoomNo.getText().toString();
			confirmRegister.floorNo = txFloorNo.getText().toString();
			confirmRegister.addressNo = txAddressNo.getText().toString();
			confirmRegister.village = txVillage.getText().toString();
			confirmRegister.mooNo = txMooNo.getText().toString();
			confirmRegister.street = txStreet.getText().toString();
//			confirmRegister.tambol = etTambol;
//			confirmRegister.amphur = etAmphur;
//			confirmRegister.province = etProvince;
			confirmRegister.postcode = txPostcode.getText().toString();
			confirmRegister.contractNo = txCountryCode.getText().toString();
		}
		
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected M_RegisterConfirm doInBackground(String... arg0) {
			// TODO Auto-generated method stub
			confirmRegister.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(confirmRegister);
			M_RegisterConfirm mRegisterConfirm = new ConnectApi(RegisterStep3.this)
				.requestRegisterConfirm(JSONObjSend);
			
			return mRegisterConfirm;
		}
		@Override
		protected void onPostExecute(M_RegisterConfirm result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				if (result.responseStatus.equals(CommonResponseRD.CODE_SUCCESS)) {
					Intent intent = new Intent(RegisterStep3.this,
							Login_E_Filing.class);
					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					startActivityForResult(intent, 0);
				}
			}
		}
	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		overridePendingTransition(0, 0);
	}
	
	private void setOnFocusChangeListener(){
//		EditText txCountryCode, txBuildName, txRoomNo, txFloorNo;
//		EditText txAddressNo, txSoi, txVillage, txMooNo, txStreet;
//		EditText txPostcode;
		//setOnFocusChangeListener
		txCountryCode.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					if (txCountryCode.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.passwordEmpty));
//						txCountryCode.requestFocus();
					}
				}
			}
		});
		txBuildName.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txCountryCode.getText().toString().equalsIgnoreCase("")) {
						popup.show("", (prefix + "ชื่ออาคาร"));
//						txBuildName.requestFocus();
					}
				}
			}
		});
		txRoomNo.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txRoomNo.getText().toString().equalsIgnoreCase("")) {
						popup.show("", prefix + "ห้องเลขที่");
//						txRoomNo.requestFocus();
					}
				}
			}
		});
		txFloorNo.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txFloorNo.getText().toString().equalsIgnoreCase("")) {
						popup.show("", prefix + "ชั้นที่");
//						txFloorNo.requestFocus();
					}
				}
			}
		});
		txAddressNo.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txAddressNo.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError
								.getFieldMessage(ElementMessage.addressNoEmpty));
//						txAddressNo.requestFocus();
					}
				}
			}
		});
		txSoi.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txSoi.getText().toString().equalsIgnoreCase("")) {
						popup.show("", prefix + "ตรอก/ซอย");
//						txSoi.requestFocus();
					}
				}
			}
		});
		txVillage.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txVillage.getText().toString().equalsIgnoreCase("")) {
						popup.show("", prefix + "ชื่อหมู่บ้าน");
//						txVillage.requestFocus();
					}
				}
			}
		});
		txMooNo.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txMooNo.getText().toString().equalsIgnoreCase("")) {
						popup.show("", prefix + "ชื่อหมู่");
//						txMooNo.requestFocus();
					}
				}
			}
		});
		txStreet.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					String prefix = "โปรดใส่";
					if (txStreet.getText().toString().equalsIgnoreCase("")) {
						popup.show("", prefix + "ชื่อถนน");
//						txStreet.requestFocus();
					}
				}
			}
		});
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		String prefix = "โปรดใส่";
		if (btNext.equals(v)) {
			if (txCountryCode.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this,
//						prefix + "รหัสประเทศหนังสือเดินทาง (กรณีต่างชาติ)",
//						Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.passportNoEmpty));
				txCountryCode.requestFocus();
				return;
			} else if (txBuildName.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "ชื่ออาคาร",
//						Toast.LENGTH_SHORT).show();
				popup.show("", (prefix + "ชื่ออาคาร"));
				txBuildName.requestFocus();
			} else if (txRoomNo.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "ห้องเลขที่",
//						Toast.LENGTH_SHORT).show();
				popup.show("", prefix + "ห้องเลขที่");
				txRoomNo.requestFocus();
			} else if (txFloorNo.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "ชั้นที่",
//						Toast.LENGTH_SHORT).show();
				popup.show("", prefix + "ชั้นที่");
				txFloorNo.requestFocus();
			} else if (txAddressNo.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "บ้านเลขที่",
//						Toast.LENGTH_SHORT).show();
				popup.show("", messageError
						.getFieldMessage(ElementMessage.addressNoEmpty));
				txAddressNo.requestFocus();
				return;
			} else if (txSoi.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "ตรอก/ซอย",
//						Toast.LENGTH_SHORT).show();
				popup.show("", prefix + "ตรอก/ซอย");
				txSoi.requestFocus();
				return;
			} else if (txVillage.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "ชื่อหมู่บ้าน",
//						Toast.LENGTH_SHORT).show();
				popup.show("", prefix + "ชื่อหมู่บ้าน");
				txVillage.requestFocus();
				return;
			} else if (txMooNo.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "ชื่อหมู่",
//						Toast.LENGTH_SHORT).show();
				popup.show("", prefix + "ชื่อหมู่");
				txMooNo.requestFocus();
				return;
			} else if (txStreet.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(RegisterStep3.this, prefix + "ชื่อถนน",
//						Toast.LENGTH_SHORT).show();
				popup.show("", prefix + "ชื่อถนน");
				txStreet.requestFocus();
				return;
			} else {
				finish();
				// new registerProfileRequest().execute();
				Intent intent = new Intent(RegisterStep3.this,
						MainEFilling.class);
				intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
				startActivityForResult(intent, 0);
			}
		}
	}
}