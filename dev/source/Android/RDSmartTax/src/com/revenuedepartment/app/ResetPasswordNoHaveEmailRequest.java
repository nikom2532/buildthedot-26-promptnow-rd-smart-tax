package com.revenuedepartment.app;

import java.util.ArrayList;

import com.revenuedepartment.datamodels.M_ResetPasswordQuestionConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.writeLog;
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
import android.widget.Toast;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordNoHaveEmailRequest extends Activity implements OnClickListener {
	Spinner mEditTextForgetPasswordNoHaveEmailQuestion;
	EditText mEditTextForgetPasswordNoHaveEmailAnswer;
	Button mbuttonForgotPasswordNoHaveEmailSubmit;
	Button mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion;
	Button btHintPassword, btHintPasswordAgain;
	
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
		mEditTextForgetPasswordNoHaveEmailQuestion = (Spinner) findViewById(R.id.mEditTextForgetPasswordNoHaveEmailQuestion);
		mEditTextForgetPasswordNoHaveEmailAnswer = (EditText) findViewById(R.id.mEditTextForgetPasswordNoHaveEmailAnswer);
		mbuttonForgotPasswordNoHaveEmailSubmit = (Button) findViewById(R.id.mbuttonForgotPasswordNoHaveEmailSubmit);
		btHintPassword = (Button) findViewById(R.id.btHintPassword);
		btHintPasswordAgain = (Button) findViewById(R.id.btHintPasswordAgain);
		mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion = (Button) findViewById(R.id.mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion);
		mbuttonForgotPasswordNoHaveEmailSubmit.setOnClickListener(this);
		mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion.setOnClickListener(this);
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
	
	private class CheckPasswordConfirm extends AsyncTask<String, Void, M_ResetPasswordQuestionConfirm> {
		DialogProcess dialog = new DialogProcess(ResetPasswordNoHaveEmailRequest.this);
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}
		@Override
		protected M_ResetPasswordQuestionConfirm doInBackground(String... params) {
			
			//### Make json request (nid) ###
			String mJsonRequest = "";
			//mJsonRequest += "{\"nid\":\"" + mEditTextForgetPasswordNoHaveEmailQuestion.getText() + "\",\"birthDate\":\"" + mEditTextForgetPasswordNoHaveEmailAnswer.getText() + "\",\"version\":\"1.0.0\"}";
			
			M_ResetPasswordQuestionConfirm mResetPasswordQuestionConfirm = new ConnectApi().mResetPasswordQuestionConfirm(mJsonRequest);
			
			return mResetPasswordQuestionConfirm;
		}
		@Override
		protected void onPostExecute(M_ResetPasswordQuestionConfirm result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				if(result.getResponseStatus().equals("OK")){
					finish();
					Intent intent = new Intent(ResetPasswordNoHaveEmailRequest.this, ResetPasswordNoHaveEmailRequestStep2.class);
					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					startActivityForResult(intent, 0);
				}
				else{
					
				}
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (mbuttonForgotPasswordNoHaveEmailSubmit.equals(v)) {
			//writeLog.LogV("Spinner", mEditTextForgetPasswordNoHaveEmailQuestion.getSelectedItem().toString());
			if (mEditTextForgetPasswordNoHaveEmailQuestion.getSelectedItem().toString().equalsIgnoreCase("")) {
				Toast.makeText(ResetPasswordNoHaveEmailRequest.this, "โปรดเลือก คำถาม", 
						Toast.LENGTH_SHORT).show();
			}
			if (mEditTextForgetPasswordNoHaveEmailAnswer.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(ResetPasswordNoHaveEmailRequest.this, "โปรดใส่ คำตอบ", 
						Toast.LENGTH_SHORT).show();
			}
			else{
				new CheckPasswordConfirm().execute();
			}
		}
		else if (mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion.equals(v)){
			finish();
			Intent intent = new Intent(ResetPasswordNoHaveEmailRequest.this,
					ResetPasswordForgetquestionThai.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
		else if (btHintPassword.equals(v)){
			
		}
	}
}