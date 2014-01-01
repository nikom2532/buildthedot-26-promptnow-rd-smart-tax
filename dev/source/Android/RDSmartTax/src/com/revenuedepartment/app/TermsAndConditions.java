package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class TermsAndConditions extends Activity implements OnClickListener{
	
	TextView tvTermsAndConditions;
	String body="TermsAndConditions";
	Button btAccept;
	Button btCancel;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	private void setView() {
		setContentView(R.layout.terms_and_conditions);
		tvTermsAndConditions = (TextView) findViewById(R.id.tvTermsAndConditions);
		tvTermsAndConditions.setText(body);
		btAccept = (Button) findViewById(R.id.btAccept);
		btAccept.setOnClickListener(this);
		btCancel = (Button) findViewById(R.id.btCancel);
		btCancel.setOnClickListener(this);
	}
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (btAccept.equals(v)){
			finish();
			Intent intent = new Intent(TermsAndConditions.this,
					MainEFilling.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
		else if(btCancel.equals(v)){
			finish();
			Intent intent = new Intent(TermsAndConditions.this,
					Login_E_Filing.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	}

}
