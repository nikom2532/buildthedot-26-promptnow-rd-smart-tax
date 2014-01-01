package com.revenuedepartment.app;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class FillingSitting extends Activity implements OnClickListener {

	Button btBack;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		this.setView();
	}

	private void setView() {
		setContentView(R.layout.filling_setting);
		btBack = (Button) findViewById(R.id.btBack);
		btBack.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btBack)) {
			finish();
			overridePendingTransition(0, 0);
		}
	}
}