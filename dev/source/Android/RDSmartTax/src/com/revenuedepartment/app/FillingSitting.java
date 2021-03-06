package com.revenuedepartment.app;

import android.app.Activity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;

import com.promptnow.network.model.CommonRequestRD;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.service.SharedPref;

public class FillingSitting extends Activity implements OnClickListener {

	ButtonCustom btThai, btEng;
	SharedPref pref;
	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setView();
		pref = new SharedPref(FillingSitting.this);
	}

	private void setView() {
		setContentView(R.layout.filling_setting);
		btThai = (ButtonCustom) findViewById(R.id.btThai);
		btEng = (ButtonCustom) findViewById(R.id.btEng);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_setting));
		btThai.setDefault();
		btThai.setOnClickListener(this);
		btEng.setDefault();
		btEng.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btThai)) {
			pref.setLang("th");
			CommonRequestRD.LANG = pref.getLang().toUpperCase();
			setView();
		} else if (v.equals(btEng)) {
			pref.setLang("en");
			CommonRequestRD.LANG = pref.getLang().toUpperCase();
			setView();
		}
	}
	
	@Override
	public void onBackPressed() {
		finish();
		return;
	}
	
}