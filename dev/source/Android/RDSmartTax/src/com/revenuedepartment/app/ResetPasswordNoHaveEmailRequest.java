package com.revenuedepartment.app;

import java.util.ArrayList;

import android.app.Activity;
import android.content.DialogInterface;
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

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionConfirm;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.service.ConnectApi;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordNoHaveEmailRequest extends Activity implements OnClickListener {
	Spinner mEditTextForgetPasswordNoHaveEmailQuestion;
	EditTextCustom mEditTextForgetPasswordNoHaveEmailAnswer;
	ButtonCustom mbuttonForgotPasswordNoHaveEmailSubmit;
	ButtonCustom mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion;
	ButtonCustom btHintAnswer;
	
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
		mEditTextForgetPasswordNoHaveEmailAnswer = (EditTextCustom) findViewById(R.id.mEditTextForgetPasswordNoHaveEmailAnswer);
		btHintAnswer = (ButtonCustom) findViewById(R.id.btHintAnswer);
		btHintAnswer.setOnClickListener(this);
		mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion = (ButtonCustom) findViewById(R.id.mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion);
		mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion.setOnClickListener(this);
		mbuttonForgotPasswordNoHaveEmailGotoForgetquesetion.setDefault();
		mbuttonForgotPasswordNoHaveEmailSubmit = (ButtonCustom) findViewById(R.id.mbuttonForgotPasswordNoHaveEmailSubmit);
		mbuttonForgotPasswordNoHaveEmailSubmit.setOnClickListener(this);
		mbuttonForgotPasswordNoHaveEmailSubmit.setDefault();
	}
	
	private void getSpinnerQuestion() {
		mEditTextForgetPasswordNoHaveEmailQuestion = (Spinner) findViewById(R.id.mEditTextForgetPasswordNoHaveEmailQuestion);
		ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, android.R.id.text1);
		spinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		mEditTextForgetPasswordNoHaveEmailQuestion.setAdapter(spinnerAdapter);
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question1));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question2));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question3));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question4));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question5));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question6));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question7));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question8));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question9));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question10));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question11));
		spinnerAdapter.add(getString(R.string.lang_th_forgetpassword_no_have_email_question12));
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
			Intent intent = new Intent(ResetPasswordNoHaveEmailRequest.this,
					ResetPasswordForgetquestionThai.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
		else if (btHintAnswer.equals(v)){
			PopupDialog popupPassword = new PopupDialog(ResetPasswordNoHaveEmailRequest.this);
			popupPassword.showMessage(getString(R.string.lang_th_forgetpassword_no_have_email_hint_answer),
				new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						// objCheck.get(i).edittext.requestFocus();
					}
				}
			);
		}
	}
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == Login_E_Filing.RESULT_RESETPASSWORD) {
			setResult(Login_E_Filing.RESULT_RESETPASSWORD);
			finish();
		}
	}
}