package com.revenuedepartment.app;

import java.util.ArrayList;

import com.revenuedepartment.customview.ButtonCustom;
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
public class ResetPasswordNoHaveEmailRequestStep2 extends Activity implements OnClickListener {
	EditText mEditTextForgetPasswordNoHaveEmailStep2Password;
	EditText mEditTextForgetPasswordNoHaveEmailStep2PasswordAgain;
	ButtonCustom mbuttonForgotPasswordNoHaveEmailStep2Submit;
	Button btHintPassword, btHintPasswordAgain;

	ArrayList<String> array_Question = new ArrayList<String>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
	}

	public void setView() {
		setContentView(R.layout.reset_password_no_have_email_step2);
		mEditTextForgetPasswordNoHaveEmailStep2Password = (EditText) findViewById(R.id.mEditTextForgetPasswordNoHaveEmailStep2Password);
		mEditTextForgetPasswordNoHaveEmailStep2PasswordAgain = (EditText) findViewById(R.id.mEditTextForgetPasswordNoHaveEmailStep2PasswordAgain);
		mbuttonForgotPasswordNoHaveEmailStep2Submit = (ButtonCustom) findViewById(R.id.mbuttonForgotPasswordNoHaveEmailStep2Submit);
		mbuttonForgotPasswordNoHaveEmailStep2Submit.setDefault();

		btHintPassword = (Button) findViewById(R.id.btHintPassword);
		btHintPasswordAgain = (Button) findViewById(R.id.btHintPasswordAgain);
		mbuttonForgotPasswordNoHaveEmailStep2Submit.setOnClickListener(this);
		btHintPassword.setOnClickListener(this);
		btHintPasswordAgain.setOnClickListener(this);
		mEditTextForgetPasswordNoHaveEmailStep2Password.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
		mEditTextForgetPasswordNoHaveEmailStep2PasswordAgain.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
	}

	private class ChangeOnlyPassword extends AsyncTask<String, Void, M_ResetPasswordQuestionChangeOnlyPassword> {
		DialogProcess dialog = new DialogProcess(ResetPasswordNoHaveEmailRequestStep2.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected M_ResetPasswordQuestionChangeOnlyPassword doInBackground(String... params) {

			// ### Make json request (nid) ###
			String mJsonRequest = "";
			// mJsonRequest += "{\"nid\":\"" +
			// mEditTextForgetPasswordNoHaveEmailQuestion.getText() +
			// "\",\"birthDate\":\"" +
			// mEditTextForgetPasswordNoHaveEmailAnswer.getText() +
			// "\",\"version\":\"1.0.0\"}";

			M_ResetPasswordQuestionChangeOnlyPassword mResetPasswordQuestionChangeOnlyPassword = new ConnectApi()
					.mResetPasswordQuestionChangeOnlyPassword(mJsonRequest);

			return mResetPasswordQuestionChangeOnlyPassword;
		}

		@Override
		protected void onPostExecute(M_ResetPasswordQuestionChangeOnlyPassword result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				if (result.getResponseStatus().equals("OK")) {
					setResult(Login_E_Filing.RESULT_RESETPASSWORD);
					finish();
				} else {

				}
			}
		}
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		if (mbuttonForgotPasswordNoHaveEmailStep2Submit.equals(v)) {

			if (mEditTextForgetPasswordNoHaveEmailStep2Password.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(ResetPasswordNoHaveEmailRequestStep2.this, "โปรดใส่ รหัสผ่าน", Toast.LENGTH_SHORT).show();
			} else if (mEditTextForgetPasswordNoHaveEmailStep2PasswordAgain.getText().toString().equalsIgnoreCase("")) {
				Toast.makeText(ResetPasswordNoHaveEmailRequestStep2.this, "โปรดใส่ รหัสผ่านตัวที่ 2 อีกครั้ง", Toast.LENGTH_SHORT).show();
			} else if (!mEditTextForgetPasswordNoHaveEmailStep2Password.getText().toString()
					.equals(mEditTextForgetPasswordNoHaveEmailStep2PasswordAgain.getText().toString())) {
				Toast.makeText(ResetPasswordNoHaveEmailRequestStep2.this, "รหัสผ่าน2ตัว ไม่เหมือนกัน โปรดใส่อีกครั้ง", Toast.LENGTH_SHORT).show();
			} else {
				new ChangeOnlyPassword().execute();
			}
		} else if (btHintPassword.equals(v)) {
			PopupDialog popupPassword = new PopupDialog(ResetPasswordNoHaveEmailRequestStep2.this);
			popupPassword.showMessage("ใส่  Password", new DialogInterface.OnClickListener() {
				@Override
				public void onClick(DialogInterface dialog, int which) {
					// objCheck.get(i).edittext.requestFocus();
				}
			});

			/*
			 * PopupDialog popupPassword = new
			 * PopupDialog(ResetPasswordNoHaveEmailRequestStep2.this);
			 * popupPassword
			 * .alert2Button(CheckLang.check(ResetPasswordNoHaveEmailRequestStep2
			 * .this,
			 * 
			 * getString(R.string.label_want_logout_th),
			 * getString(R.string.label_want_logout_en)), CheckLang.check(
			 * ResetPasswordNoHaveEmailRequestStep2.this,
			 * getString(R.string.label_ok_th),
			 * getString(R.string.label_ok_en)), CheckLang.check(
			 * ResetPasswordNoHaveEmailRequestStep2.this,
			 * getString(R.string.label_cancel_th),
			 * getString(R.string.label_cancel_en)), new
			 * DialogInterface.OnClickListener() {
			 * 
			 * @Override public void onClick(DialogInterface dialog, int which)
			 * { finish(); } }, new DialogInterface.OnClickListener() {
			 * 
			 * @Override public void onClick(DialogInterface dialog, int which)
			 * {
			 * 
			 * } });
			 */
		} else if (btHintPasswordAgain.equals(v)) {
			PopupDialog popupPasswordAgain = new PopupDialog(ResetPasswordNoHaveEmailRequestStep2.this);
			popupPasswordAgain.showMessage("ใส่  Passwordอีกครั้ง", new DialogInterface.OnClickListener() {
				@Override
				public void onClick(DialogInterface dialog, int which) {

				}
			});
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