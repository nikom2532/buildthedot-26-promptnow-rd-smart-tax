package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class SplashScreen extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();

		// For View in another activity for development
		// Intent intent = new Intent(this, MainMenu.class);
//		Intent intent = new Intent(this, MainEFilling.class);
		Intent intent = new Intent(this, ResetPasswordStep1.class);
//		Intent intent = new Intent(this, SendSatisfaction.class);
//		Intent intent = new Intent(this, UpdateProfile.class);
//		Intent intent = new Intent(this, MainEFilling.class);
//		Intent intent = new Intent(this, ResetPasswordStep1.class);
//		Intent intent = new Intent(this, ResetPasswordNoHaveEmailRequestStep2.class);
		 
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
		intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
		startActivity(intent);
		finish();
	}

	void setView() {
		setContentView(R.layout.splashscreen);
	}
}