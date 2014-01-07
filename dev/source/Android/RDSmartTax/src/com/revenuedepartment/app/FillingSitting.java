package com.revenuedepartment.app;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.service.SharedPref;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

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
		btThai.setOnClickListener(this);
		btEng.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btThai)) {
			pref.setLang("th");
		} else if (v.equals(btEng)) {
			pref.setLang("en");
		}
	}
}