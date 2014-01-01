package com.revenuedepartment.app;

import java.util.ArrayList;

import com.revenuedepartment.datamodels.M_ResetPasswordQuestionChangeOnlyPassword;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.function.CheckLang;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.service.ConnectApi;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordWithNid extends Activity implements OnClickListener {
	EditText mEditTextResetNewPassword1;
	EditText mEditTextResetNewPassword2;
	Button mbuttonResetPasswordWithNidSubmit;
	Button btHintPassword, btHintPasswordAgain;
	
	ArrayList<String> array_Question = new ArrayList<String>();
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.reset_password_withnid);
		mEditTextResetNewPassword1 = (EditText) findViewById(R.id.mEditTextResetNewPassword1);
		mEditTextResetNewPassword2 = (EditText) findViewById(R.id.mEditTextResetNewPassword2);
		mbuttonResetPasswordWithNidSubmit = (Button) findViewById(R.id.mbuttonResetPasswordWithNidSubmit);
		btHintPassword = (Button) findViewById(R.id.btHintPassword);
		btHintPasswordAgain = (Button) findViewById(R.id.btHintPasswordAgain);
		mbuttonResetPasswordWithNidSubmit.setOnClickListener(this);
		btHintPassword.setOnClickListener(this);
		btHintPasswordAgain.setOnClickListener(this);
		mEditTextResetNewPassword1.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
		mEditTextResetNewPassword2.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
//		mEditTextResetNewPassword1.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
//		mEditTextResetNewPassword2.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
	}
	
	/*
	private class ChangeOnlyPassword extends AsyncTask<String, Void, M_ResetPasswordQuestionChangeOnlyPassword> {
		DialogProcess dialog = new DialogProcess(ResetPasswordWithNid.this);
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}
		@Override
		protected M_ResetPasswordQuestionChangeOnlyPassword doInBackground(String... params) {
			
			//### Make json request (nid) ###
			String mJsonRequest = "";
			//mJsonRequest += "{\"nid\":\"" + mEditTextForgetPasswordNoHaveEmailQuestion.getText() + "\",\"birthDate\":\"" + mEditTextForgetPasswordNoHaveEmailAnswer.getText() + "\",\"version\":\"1.0.0\"}";
			
			M_ResetPasswordQuestionChangeOnlyPassword mResetPasswordQuestionChangeOnlyPassword = new ConnectApi().mResetPasswordQuestionChangeOnlyPassword(mJsonRequest);
			
			return mResetPasswordQuestionChangeOnlyPassword;
		}
		@Override
		protected void onPostExecute(M_ResetPasswordQuestionChangeOnlyPassword result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				if(result.getResponseStatus().equals("OK")){
					finish();
					Intent intent = new Intent(ResetPasswordWithNid.this, Login_E_Filing.class);
					intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
					startActivityForResult(intent, 0);
				}
				else{
					
				}
			}
		}
	}
	*/
	
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		
		if (mbuttonResetPasswordWithNidSubmit.equals(v)) {
			if (mEditTextResetNewPassword1.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่าน", 
						Toast.LENGTH_SHORT).show();
			}
			else if(mEditTextResetNewPassword1.getText().toString().length() != 8){
				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่าน ให้ครบ 8 หลัก", 
						Toast.LENGTH_SHORT).show();
			}
			else if (mEditTextResetNewPassword2.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่านตัวที่ 2 อีกครั้ง", 
						Toast.LENGTH_SHORT).show();
			}
			else if(mEditTextResetNewPassword2.getText().toString().length() != 8){
				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่านอีกครั้ง ให้ครบ 8 หลัก", 
						Toast.LENGTH_SHORT).show();
			}
			else if (!mEditTextResetNewPassword1.getText().toString().equals(mEditTextResetNewPassword2.getText().toString())) {
				Toast.makeText(ResetPasswordWithNid.this, "รหัสผ่าน2ตัว ไม่เหมือนกัน โปรดใส่อีกครั้ง", 
						Toast.LENGTH_SHORT).show();
			}
			else{
//				new ChangeOnlyPassword().execute();
				
				Intent intent = new Intent(ResetPasswordWithNid.this, MainEFilling.class);
				startActivity(intent);
				finish();
			}
		}
		else if(btHintPassword.equals(v)){
			PopupDialog popupPassword = new PopupDialog(ResetPasswordWithNid.this);
			popupPassword.showMessage("โปรดใส่ Password ใหม่", new DialogInterface.OnClickListener() {
				@Override
				public void onClick(DialogInterface dialog, int which) {
//					objCheck.get(i).edittext.requestFocus();
				}
			});
			
			/*
			PopupDialog popupPassword = new PopupDialog(ResetPasswordNoHaveEmailRequestStep2.this);
			popupPassword.alert2Button(CheckLang.check(ResetPasswordNoHaveEmailRequestStep2.this,
					
			getString(R.string.label_want_logout_th),
			getString(R.string.label_want_logout_en)), CheckLang.check(
					ResetPasswordNoHaveEmailRequestStep2.this, getString(R.string.label_ok_th),
			getString(R.string.label_ok_en)), CheckLang.check(
					ResetPasswordNoHaveEmailRequestStep2.this, getString(R.string.label_cancel_th),
			getString(R.string.label_cancel_en)),
			new DialogInterface.OnClickListener() {

				@Override
				public void onClick(DialogInterface dialog, int which) {
					finish();
				}
			}, new DialogInterface.OnClickListener() {

				@Override
				public void onClick(DialogInterface dialog, int which) {

				}
			});
			*/
		
		}
		else if(btHintPasswordAgain.equals(v)){
			PopupDialog popupPasswordAgain = new PopupDialog(ResetPasswordWithNid.this);
			popupPasswordAgain.showMessage("โปรดใส่ Password ใหม่อีกครั้ง", new DialogInterface.OnClickListener() {
				@Override
				public void onClick(DialogInterface dialog, int which) {
					
				}
			});
		}
		
		
	}
}