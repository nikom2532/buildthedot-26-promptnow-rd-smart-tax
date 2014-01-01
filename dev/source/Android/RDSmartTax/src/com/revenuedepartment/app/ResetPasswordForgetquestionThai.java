package com.revenuedepartment.app;

import java.util.ArrayList;

import com.revenuedepartment.datamodels.M_ResetPasswordConfirm;
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
import android.widget.Toast;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordForgetquestionThai extends Activity implements OnClickListener {
	EditText mEditTextForgetQuestionThaiName;
	EditText mEditTextForgetQuestionThaiSername;
	EditText mEditTextForgetQuestionThaiFathername; 
	EditText mEditTextForgetQuestionThaiMothername;
	
	Button mbuttonForgotPasswordHaveEmailSubmit;
	Button btHintThaiName, btHintThaiSername, btHintThaiFathername, btHintThaiMothername;
	
	ArrayList<String> array_Question = new ArrayList<String>();
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.reset_password_forgetquestion_thai);
		mEditTextForgetQuestionThaiName = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiName);
		mEditTextForgetQuestionThaiSername = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiSername);
		mEditTextForgetQuestionThaiFathername = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiFathername);
		mEditTextForgetQuestionThaiMothername = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiMothername);
		mbuttonForgotPasswordHaveEmailSubmit = (Button) findViewById(R.id.mbuttonForgotPasswordHaveEmailSubmit);
		mbuttonForgotPasswordHaveEmailSubmit.setOnClickListener(this);
	}
	
	private class ResetPasswordConfirm extends AsyncTask<String, Void, M_ResetPasswordConfirm> {
		DialogProcess dialog = new DialogProcess(ResetPasswordForgetquestionThai.this);
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}
		@Override
		protected M_ResetPasswordConfirm doInBackground(String... params) {
			
			//### Make json request (nid) ###
			String mJsonRequest = "";
			//mJsonRequest += "{\"nid\":\"" + mEditTextForgetPasswordNoHaveEmailQuestion.getText() + "\",\"birthDate\":\"" + mEditTextForgetPasswordNoHaveEmailAnswer.getText() + "\",\"version\":\"1.0.0\"}";
			
			M_ResetPasswordConfirm mResetPasswordConfirm = new ConnectApi().mResetPasswordConfirm(mJsonRequest);
			
			return mResetPasswordConfirm;
		}
		@Override
		protected void onPostExecute(M_ResetPasswordConfirm result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				
			} else {
				
				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					finish();
					Intent intent = new Intent(ResetPasswordForgetquestionThai.this, Login_E_Filing.class);
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
		if (mbuttonForgotPasswordHaveEmailSubmit.equals(v)){
			if(mEditTextForgetQuestionThaiName.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อ", 
						Toast.LENGTH_SHORT).show();
			}
			else if(mEditTextForgetQuestionThaiSername.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อสกุล", 
						Toast.LENGTH_SHORT).show();
			}
			else if(mEditTextForgetQuestionThaiFathername.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อสกุล คุณพ่อ", 
						Toast.LENGTH_SHORT).show();
			}
			else if(mEditTextForgetQuestionThaiMothername.getText().toString().equalsIgnoreCase("")){
				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อสกุล คุณแม่", 
						Toast.LENGTH_SHORT).show();
			}
			else{
				new ResetPasswordConfirm().execute();
			}
		}
	}
}