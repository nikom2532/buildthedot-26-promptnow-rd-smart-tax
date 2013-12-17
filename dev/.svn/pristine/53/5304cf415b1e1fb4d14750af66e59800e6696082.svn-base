package com.revenuedepartment.app;

import java.util.ArrayList;

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
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordNoHaveEmailRequest extends Activity implements OnClickListener {
	Spinner mEditTextForgetPasswordNoHaveEmailQuestion;
	EditText mEditTextForgetPasswordNoHaveEmailAnswer;
	Button mbuttonForgotPasswordNoHaveEmailSubmit;
	Button mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion;
	
	ArrayList<String> array_Question = new ArrayList<String>();
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
		getSpinnerQuestion();
	}

	public void setView() {
		setContentView(R.layout.reset_password_no_have_email);
		mEditTextForgetPasswordNoHaveEmailQuestion = (Spinner) findViewById(R.id.mEditTextForgetPasswordHaveEmailIdcityzen);
		mEditTextForgetPasswordNoHaveEmailAnswer = (EditText) findViewById(R.id.mEditTextForgetPasswordHaveEmailBirthdate);
		mbuttonForgotPasswordNoHaveEmailSubmit = (Button) findViewById(R.id.mbuttonForgotPasswordNoHaveEmailSubmit);
	}
	
	private void getSpinnerQuestion() {
		mEditTextForgetPasswordNoHaveEmailQuestion = (Spinner) findViewById(R.id.mEditTextForgetPasswordNoHaveEmailQuestion);
		ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, android.R.id.text1);
		spinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		mEditTextForgetPasswordNoHaveEmailQuestion.setAdapter(spinnerAdapter);
		spinnerAdapter.add("Q1");
		spinnerAdapter.add("Q2");
		spinnerAdapter.add("Q3");
		spinnerAdapter.add("Q4");
		spinnerAdapter.add("Q5");
		spinnerAdapter.notifyDataSetChanged();
		
		/*
		array_ForgetPasswordNoHaveEmailQuestion=new String[5];
		array_ForgetPasswordNoHaveEmailQuestion[0]="1";
		array_ForgetPasswordNoHaveEmailQuestion[1]="2";
		array_ForgetPasswordNoHaveEmailQuestion[2]="3";
		array_ForgetPasswordNoHaveEmailQuestion[3]="4";
		array_ForgetPasswordNoHaveEmailQuestion[4]="5";
        ArrayAdapter adapter = new ArrayAdapter(this,
        android.R.layout.reset_password_no_have_email, array_ForgetPasswordNoHaveEmailQuestion);
        mEditTextForgetPasswordNoHaveEmailQuestion.setAdapter(adapter);
        */
	}
	
	private class requestCheckPassword extends AsyncTask<String, Void, M_ResetPasswordRequest> {
		DialogProcess dialog = new DialogProcess(ResetPasswordNoHaveEmailRequest.this);
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}
		@Override
		protected M_ResetPasswordRequest doInBackground(String... params) {
			
			//### Make json request (nid) ###
			String mJsonRequest = "";
			//mJsonRequest += "{\"nid\":\"" + mEditTextForgetPasswordNoHaveEmailQuestion.getText() + "\",\"birthDate\":\"" + mEditTextForgetPasswordNoHaveEmailAnswer.getText() + "\",\"version\":\"1.0.0\"}";
			
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
							 Intent intent = new Intent(ResetPasswordNoHaveEmailRequest.this, RegisterStep1.class);
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
				
				// Intent intent = new Intent(Login_E_Filing.this,
				// UpdateProfile.class);
				// intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
				// startActivityForResult(intent, 0);
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (mbuttonForgotPasswordNoHaveEmailSubmit.equals(v)) {
			new requestCheckPassword().execute();
		}
		else if (mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion.equals(v)){
			// Intent intent = new Intent(Login_E_Filing.this,
			// UpdateProfile.class);
			// intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			// startActivityForResult(intent, 0);
		}
	}
}