package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.LinearLayout;

import com.revenuedepartment.customview.ButtonCustom;

public class MenuUser extends Activity implements OnClickListener {

	ButtonCustom btBack;
	LinearLayout lnUser;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setView();
	}

	public void setView() {
		setContentView(R.layout.menu_user);
		btBack = (ButtonCustom) findViewById(R.id.btBack);
		lnUser = (LinearLayout) findViewById(R.id.lnUser);
		btBack.setOnClickListener(this);
		lnUser.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btBack)) {
			finish();
			overridePendingTransition(0, 0);
		} else if (v.equals(lnUser)) {
			Intent intent = new Intent(MenuUser.this, UpdateProfile.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	}
}
