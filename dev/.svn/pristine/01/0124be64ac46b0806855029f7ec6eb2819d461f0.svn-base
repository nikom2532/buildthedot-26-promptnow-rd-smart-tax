package com.revenuedepartment.app;

import com.revenuedepartment.service.ConfigApp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class MenuPrint extends Activity implements OnClickListener {

	Button btForm, btReceipt, btBack;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setView();
	}

	private void setView() {
		setContentView(R.layout.menu_print);
		btForm = (Button) findViewById(R.id.btForm);
		btForm.setOnClickListener(this);
		btReceipt = (Button) findViewById(R.id.btReceipt);
		btReceipt.setOnClickListener(this);
		btBack = (Button) findViewById(R.id.btBack);
		btBack.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btForm)) {
			Intent intent = new Intent(MenuPrint.this, FormPrint.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			Bundle data = new Bundle();
			data.putString("type", ConfigApp.F);
			intent.putExtras(data);
			startActivityForResult(intent, 0);
		} else if (v.equals(btReceipt)) {
			Intent intent = new Intent(MenuPrint.this, FormPrint.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			Bundle data = new Bundle();
			data.putString("type", ConfigApp.R);
			intent.putExtras(data);
			startActivityForResult(intent, 0);
		} else if (v.equals(btBack)) {
			finish();
			overridePendingTransition(0, 0);
		}
	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		overridePendingTransition(0, 0);
	}
}
