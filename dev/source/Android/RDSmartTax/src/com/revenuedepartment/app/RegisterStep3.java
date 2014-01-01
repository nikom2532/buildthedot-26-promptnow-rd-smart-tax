package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class RegisterStep3 extends Activity implements OnClickListener {
	EditText txCountryCode, txBuildName, txRoomNo, txFloorNo;
	EditText txAddressNo, txSoi, txVillage, txMooNo, txStreet, txProvince;
	EditText txAmphur, txTambol, txPostcode;
	Button btNext;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.registerstep3);
		txCountryCode = (EditText) findViewById(R.id.txCountryCode);
		txBuildName = (EditText) findViewById(R.id.txBuildName);
		txRoomNo = (EditText) findViewById(R.id.txRoomNo);
		txFloorNo = (EditText) findViewById(R.id.txFloorNo);
		txAddressNo = (EditText) findViewById(R.id.txAddressNo);
		txSoi = (EditText) findViewById(R.id.txSoi);
		txVillage = (EditText) findViewById(R.id.txVillage);
		txMooNo = (EditText) findViewById(R.id.txMooNo);
		txStreet= (EditText) findViewById(R.id.txStreet);
		txProvince = (EditText) findViewById(R.id.txProvince);
		txAmphur = (EditText) findViewById(R.id.txAmphur);
		txTambol = (EditText) findViewById(R.id.txTambol);
		txPostcode = (EditText) findViewById(R.id.txPostcode);
		btNext = (Button) findViewById(R.id.btNext);
		btNext.setOnClickListener(this);
		
		txFloorNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		txAddressNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		txMooNo.setRawInputType(Configuration.KEYBOARD_QWERTY);
		txPostcode.setRawInputType(Configuration.KEYBOARD_QWERTY);
	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		overridePendingTransition(0, 0);
	}
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		String prefix="โปรดใส่";
		if (btNext.equals(v)) {
			if(txCountryCode.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"รหัสประเทศหนังสือเดินทาง (กรณีต่างชาติ)", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txBuildName.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ชื่ออาคาร", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txRoomNo.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ห้องเลขที่", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txFloorNo.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ชั้นที่", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txAddressNo.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"บ้านเลขที่", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txSoi.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ตรอก/ซอย", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txVillage.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ชื่อหมู่บ้าน", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txMooNo.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ชื่อหมู่บ้าน", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txStreet.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ชื่อหมู่บ้าน", 
						Toast.LENGTH_SHORT).show();
			}
			else if(txStreet.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(RegisterStep3.this, prefix+"ชื่อหมู่บ้าน", 
						Toast.LENGTH_SHORT).show();
			}
			else{
				finish();
				//new registerProfileRequest().execute();
				Intent intent = new Intent(RegisterStep3.this, MainEFilling.class);
				intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
				startActivityForResult(intent, 0);
			}
		}
	}
}