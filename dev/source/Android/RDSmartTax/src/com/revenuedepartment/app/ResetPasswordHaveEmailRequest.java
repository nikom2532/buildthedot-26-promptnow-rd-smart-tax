package com.revenuedepartment.app;

import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.service.ConnectApi;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;

public class ResetPasswordHaveEmailRequest extends Activity implements OnClickListener {
	EditText mEditTextForgetPasswordHaveEmailIdcityzen;
	DatePicker mEditTextForgetPasswordHaveEmailBirthdate;
	Button mbuttonForgotPasswordHaveEmailSubmit;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.reset_password_have_email);
		mEditTextForgetPasswordHaveEmailIdcityzen = (EditText) findViewById(R.id.mEditTextForgetPasswordHaveEmailIdcityzen);
		mEditTextForgetPasswordHaveEmailBirthdate = (DatePicker) findViewById(R.id.mEditTextForgetPasswordHaveEmailBirthdate);
		mbuttonForgotPasswordHaveEmailSubmit = (Button) findViewById(R.id.mbuttonForgotPasswordHaveEmailSubmit);

	}
	
	private class requestCheckPassword extends AsyncTask<String, Void, M_ResetPasswordRequest> {
		DialogProcess dialog = new DialogProcess(ResetPasswordHaveEmailRequest.this);
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}
		@Override
		protected M_ResetPasswordRequest doInBackground(String... params) {
			
			//### Make json request (nid) ###
			String mJsonRequest = "";
			mJsonRequest += "{\"nid\":\"" + mEditTextForgetPasswordHaveEmailIdcityzen.getText() + "\",\"birthDate\":\"" + mEditTextForgetPasswordHaveEmailBirthdate.getDayOfMonth() + "\",\"version\":\"1.0.0\"}";
			M_ResetPasswordRequest mResetPasswordRequest = new ConnectApi().mResetPasswordRequest(mJsonRequest);
			
			return mResetPasswordRequest;
		}
		@Override
		protected void onPostExecute(M_ResetPasswordRequest result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				
				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					//writeLog.LogV("getResponseStatus=OK?", result.getResponseData().getStatus());
					if (result.getResponseData().getEmail().equals(getString(R.string.status_olduser))) {
						
						//Step 2. Validate Check is new user?
						if(result.getResponseData().getEmail()=="0"){
							 Intent intent = new Intent(ResetPasswordHaveEmailRequest.this, RegisterStep1.class);
							 intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
							 startActivityForResult(intent, 0);
						}
						else if(result.getResponseData().getEmail()=="1"){
							
						}
						//End Step 2. Validate Check is new user?
						
					} else {
						// Intent intent = new Intent(Login_E_Filing.this,
						// UpdateProfile.class);
						// intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
						// startActivityForResult(intent, 0);
					}
				} else {
					
				}
				
				// Intent intent = new Intent(Login_E_Filing.this,UpdateProfile.class);
				// intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
				// startActivityForResult(intent, 0);
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (mbuttonForgotPasswordHaveEmailSubmit.equals(v)) {
			new requestCheckPassword().execute();
		}
	}
	
}