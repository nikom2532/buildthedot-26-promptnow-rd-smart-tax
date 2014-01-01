package com.revenuedepartment.app;

import com.revenuedepartment.customview.ButtonCustom;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

public class PreFilling extends Activity implements OnClickListener {

	ButtonCustom btFilling;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
	}

	private void setView() {
		setContentView(R.layout.pre_filling);
		btFilling = (ButtonCustom) findViewById(R.id.btFilling);
		btFilling.setDefault();
		btFilling.setOnClickListener(this);

	}

	@Override
	public void onClick(View v) {
		if (v.equals(btFilling)) {
			Intent intent = new Intent(PreFilling.this, Filling.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == MainEFilling.RESULT_CLOSE) {
			setResult(MainEFilling.RESULT_CLOSE);
			finish();
		}
	}
}
