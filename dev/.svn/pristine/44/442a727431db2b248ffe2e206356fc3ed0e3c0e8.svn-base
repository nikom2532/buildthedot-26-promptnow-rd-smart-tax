package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.service.ConfigApp;

public class ResultFillingCase extends Activity implements OnClickListener {
	ButtonCustom btNext;
	TopBar topBar;
	TextViewCustom label_fun, txAmount, txFillingDate, txYear, txNoFilling;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.result_filling_case2);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_efilling));
	
		btNext = (ButtonCustom) findViewById(R.id.btNext);
		btNext.setDefault();
		btNext.setOnClickListener(this);

		label_fun = (TextViewCustom) findViewById(R.id.label_fun);
		txAmount = (TextViewCustom) findViewById(R.id.txAmount);
		txFillingDate = (TextViewCustom) findViewById(R.id.txFillingDate);
		txYear = (TextViewCustom) findViewById(R.id.txYear);
		txNoFilling = (TextViewCustom) findViewById(R.id.txNoFilling);

		try {
			Intent get = getIntent();
			if (get.getExtras().getString(ConfigApp.show_back).equals(ConfigApp.show_back)) {
				topBar.clickBack();
			} else {
				topBar.hideBack();
			}
		} catch (Exception e) {
			topBar.hideBack();
		}
		
		topBar.clickBack();

		int flag_test = 0;
		if (flag_test == 0) {
			txAmount.setText(String.format(getString(R.string.label_bath), "200.00"));
		}
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btNext)) {
			setResult(MainEFilling.RESULT_SENDSATISFACTION);
			finish();
			overridePendingTransition(0, 0);
		}
	}
}
