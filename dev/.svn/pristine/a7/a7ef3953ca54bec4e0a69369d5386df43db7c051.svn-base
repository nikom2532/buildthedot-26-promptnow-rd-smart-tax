package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Toast;

import com.revenuedepartment.customview.ButtonCustom;

public class RegisterStep2 extends Activity implements OnClickListener {
	EditText etEmail, etAnswer;
	DatePicker dpBirthdate;
	ButtonCustom btNext;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.registerstep2);
		btNext = (ButtonCustom) findViewById(R.id.btNext);
		btNext.setOnClickListener(this);
		etEmail = (EditText) findViewById(R.id.etEmail);
		etAnswer = (EditText) findViewById(R.id.etAnswer);
		dpBirthdate = (DatePicker) findViewById(R.id.dpBirthdate);
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		String vEtEmail, vEtAnswer;
		vEtEmail = etEmail.getText().toString();
		vEtAnswer = etAnswer.getText().toString();
		if (btNext.equals(v)) {
			if(vEtEmail.equalsIgnoreCase("")){
				Toast.makeText(RegisterStep2.this, "โปรดใส่ E-mail", 
						Toast.LENGTH_SHORT).show();
			}
			if(vEtAnswer.equalsIgnoreCase("")){
				Toast.makeText(RegisterStep2.this, "โปรดใส่คำตอบ", 
						Toast.LENGTH_SHORT).show();
			}
			else{
				Intent intent = new Intent(RegisterStep2.this, RegisterStep3.class);
				intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
				startActivityForResult(intent, 0);
			}
		}
	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		 overridePendingTransition(0, 0);   
	}
}
