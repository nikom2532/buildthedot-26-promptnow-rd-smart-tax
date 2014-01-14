package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import com.promptnow.network.model.CommonRequestRD;
import com.revenuedepartment.service.SharedPref;

public class SplashScreen extends Activity {
	int SPLASH_TIME_OUT = 2000;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
		
		CommonRequestRD.LANG = new SharedPref(SplashScreen.this).getLang().toUpperCase();
		
		// For View in another activity for development
		// Intent intent = new Intent(this, MainMenu.class);
		// Intent intent = new Intent(this, MainEFilling.class);
		// Intent intent = new Intent(this, Login_E_Filing.class);
		// Intent intent = new Intent(this, SendSatisfaction.class);
		// Intent intent = new Intent(this, UpdateProfile.class);
		// Intent intent = new Intent(this, MainEFilling.class);
		// Intent intent = new Intent(this, Filling.class);
		// Intent intent = new Intent(this, RegisterStep1.class);
		// Intent intent = new Intent(this, .class);
		// Intent intent = new Intent(this, ResetPasswordStep1.class);
		// Intent intent = new Intent(this, testDatePickerDialog2.class);
		// Intent intent = new Intent(this, Login_E_Filing.class);
		// Intent intent = new Intent(this,
		// ResetPasswordNoHaveEmailRequestStep2.class);

		// Intent intent = new Intent(this, TermsAndConditions.class);
		// Intent intent = new Intent(this, RegisterStep3.class);
		// Intent intent = new Intent(this,
		// ResetPasswordHaveEmailRequest.class);
		// Intent intent = new Intent(this,
		// ResetPasswordNoHaveEmailRequest.class);
		// Intent intent = new Intent(this,
		// ResetPasswordForgetquestionThai.class);
		// Intent intent = new Intent(this,
		// ResetPasswordForgetquestionInternational.class);
		// intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
		// startActivity(intent);
		// finish();

		new Handler().postDelayed(new Runnable() {

			@Override
			public void run() {
				Intent i = new Intent(SplashScreen.this, Login_E_Filing.class);
				startActivity(i);
				finish();
			}
		}, SPLASH_TIME_OUT);
	}

	void setView() {
		setContentView(R.layout.splashscreen);
	}
}