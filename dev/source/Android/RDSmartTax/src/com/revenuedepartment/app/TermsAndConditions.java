package com.revenuedepartment.app;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class TermsAndConditions extends Activity implements OnClickListener {

	TextView tvTermsAndConditions;
	ButtonCustom btAccept;
	ButtonCustom btCancel;
	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	private void setView() {
		setContentView(R.layout.terms_and_conditions);
		tvTermsAndConditions = (TextView) findViewById(R.id.tvTermsAndConditions);
//		tvTermsAndConditions.setText(getString(R.string.lang_th_forgetpassword_termsandconditions_content));
		btAccept = (ButtonCustom) findViewById(R.id.btAccept);
		btAccept.setOnClickListener(this);
		btAccept.setDefault();
		btCancel = (ButtonCustom) findViewById(R.id.btCancel);
		btCancel.setDefault();
		btCancel.setOnClickListener(this);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.hideBack();
		topBar.setTitle(getString(R.string.label_condition));
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (btAccept.equals(v)) {
			finish();
			Intent intent = new Intent(TermsAndConditions.this, MainEFilling.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		} else if (btCancel.equals(v)) {
			finish();
			Intent intent = new Intent(TermsAndConditions.this, Login_E_Filing.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	}

}
