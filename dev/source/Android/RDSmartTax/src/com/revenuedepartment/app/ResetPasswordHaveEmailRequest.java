package com.revenuedepartment.app;

import java.util.ArrayList;

import com.revenuedepartment.datamodels.M_ResetPasswordEmailConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.SharedPref;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordHaveEmailRequest extends Activity implements OnClickListener {
	Button mButtonForgotPasswordHaveEmailSubmit;
	TextView mButtonForgotPasswordHaveEmailEmail;
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.reset_password_have_email);
		mButtonForgotPasswordHaveEmailSubmit = (Button) findViewById(R.id.mButtonForgotPasswordHaveEmailSubmit);
		mButtonForgotPasswordHaveEmailSubmit.setOnClickListener(this);
		mButtonForgotPasswordHaveEmailEmail = (TextView) findViewById(R.id.mButtonForgotPasswordHaveEmailEmail);
		makeHiddenEmail();
	}
	public void makeHiddenEmail() {
		SharedPref pref = new SharedPref(ResetPasswordHaveEmailRequest.this);
		String Email = pref.getString("ResetPasswordStep1_email");
		
		StringBuilder EmailHidden = new StringBuilder(Email.length());
	    for (int i = 0; i < Email.length(); i++) {
	    	if(i == 0){
	    		EmailHidden.append(Email.charAt(0));
	    	}
	    	else if(i==1){
	    		EmailHidden.append(Email.charAt(1));
	    	}
	    	else if(i==2){
	    		EmailHidden.append(Email.charAt(2));
	    	}
	    	else if(Email.charAt(i) == '@'){
	    		EmailHidden.append('@');
	    	}
	    	else{
	    		EmailHidden.append('*');
	    	}
	    }
		mButtonForgotPasswordHaveEmailEmail.setText(EmailHidden.toString());
	}
	
	private class CheckPasswordConfirm extends AsyncTask<String, Void, M_ResetPasswordEmailConfirm> {
		DialogProcess dialog = new DialogProcess(ResetPasswordHaveEmailRequest.this);
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}
		@Override
		protected M_ResetPasswordEmailConfirm doInBackground(String... params) {
			
			//### Make json request (nid) ###
			String mJsonRequest = "";
			//mJsonRequest += "{\"nid\":\"" + mEditTextForgetPasswordNoHaveEmailQuestion.getText() + "\",\"birthDate\":\"" + mEditTextForgetPasswordNoHaveEmailAnswer.getText() + "\",\"version\":\"1.0.0\"}";
			
			M_ResetPasswordEmailConfirm mResetPasswordEmailConfirm = new ConnectApi().mResetPasswordEmailConfirm(mJsonRequest);
			
			return mResetPasswordEmailConfirm;
		}
		@Override
		protected void onPostExecute(M_ResetPasswordEmailConfirm result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				finish();
				//writeLog.LogV("getResponseStatus=OK?", result.getResponseStatus());
				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					finish();
					Intent intent = new Intent(ResetPasswordHaveEmailRequest.this, Login_E_Filing.class);
					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					startActivityForResult(intent, 0);
				} else {
					
				}
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (mButtonForgotPasswordHaveEmailSubmit.equals(v)) {
			new CheckPasswordConfirm().execute();
		}
	}
}