package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

import com.revenuedepartment.customview.ButtonCustom;

public class RegisterStep2 extends Activity implements OnClickListener {
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
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (btNext.equals(v)) {
			Intent intent = new Intent(RegisterStep2.this, RegisterStep3.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		 overridePendingTransition(0, 0);   
	}
}
