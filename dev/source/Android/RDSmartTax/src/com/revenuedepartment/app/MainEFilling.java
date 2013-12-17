package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class MainEFilling extends Activity implements OnClickListener {

	Button btFilling, btUserProfile;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	private void setView() {
		setContentView(R.layout.mainefilling);
		btFilling = (Button) findViewById(R.id.btFilling);
		btUserProfile = (Button) findViewById(R.id.btUserProfile);
		
		btFilling.setOnClickListener(this);
		btUserProfile.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btFilling)) {
			Intent intent = new Intent(MainEFilling.this, Filling.class);
			startActivityForResult(intent, 0);
		} else if (v.equals(btUserProfile)) {
			Intent intent = new Intent(MainEFilling.this, UpdateProfile.class);
			startActivityForResult(intent, 0);
		}
	}
}
