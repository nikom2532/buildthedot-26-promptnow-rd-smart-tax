package com.revenuedepartment.app;

import java.util.ArrayList;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_ResetPasswordConfirm;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.ElementMessage;
import com.revenuedepartment.service.GetMessageError;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordForgetquestionThai extends Activity implements OnClickListener {
	EditText mEditTextForgetQuestionThaiName;
	EditText mEditTextForgetQuestionThaiSername;
	EditText mEditTextForgetQuestionThaiFathername;
	EditText mEditTextForgetQuestionThaiMothername;
	Button btHintThaiName;
	ButtonCustom btHintThaiSername;
	ButtonCustom btHintThaiFathername;
	ButtonCustom btHintThaiMothername;
	ButtonCustom mbuttonForgotPasswordHaveEmailSubmit;
	
	TopBar topBar;

	ArrayList<String> array_Question = new ArrayList<String>();
	
	PopupDialog popup = new PopupDialog(ResetPasswordForgetquestionThai.this);
	GetMessageError messageError;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
		messageError = new GetMessageError(ResetPasswordForgetquestionThai.this);
	}

	public void setView() {
		setContentView(R.layout.reset_password_forgetquestion_thai);
		mEditTextForgetQuestionThaiName = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiName);
		mEditTextForgetQuestionThaiSername = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiSername);
		mEditTextForgetQuestionThaiFathername = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiFathername);
		mEditTextForgetQuestionThaiMothername = (EditText) findViewById(R.id.mEditTextForgetQuestionThaiMothername);
		btHintThaiName = (Button) findViewById(R.id.btHintThaiName);
		btHintThaiName.setOnClickListener(this);
		btHintThaiSername = (ButtonCustom) findViewById(R.id.btHintThaiSername);
		btHintThaiSername.setOnClickListener(this);
		btHintThaiFathername = (ButtonCustom) findViewById(R.id.btHintThaiFathername);
		btHintThaiFathername.setOnClickListener(this);
		btHintThaiMothername = (ButtonCustom) findViewById(R.id.btHintThaiMothername);
		btHintThaiMothername.setOnClickListener(this);
		mbuttonForgotPasswordHaveEmailSubmit = (ButtonCustom) findViewById(R.id.mbuttonForgotPasswordHaveEmailSubmit);
		mbuttonForgotPasswordHaveEmailSubmit.setOnClickListener(this);
		mbuttonForgotPasswordHaveEmailSubmit.setDefault();
		
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.lang_th_forgetpassword_step1_topic));
		
		setOnFocusChangeListener();
	}
	
	private void setOnFocusChangeListener(){
		mEditTextForgetQuestionThaiName.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					//do job here owhen Edittext lose focus 
					if (mEditTextForgetQuestionThaiName.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.nameEmpty));
//						mEditTextForgetQuestionThaiName.requestFocus();
					}
				}
			}
		});
		mEditTextForgetQuestionThaiSername.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					//do job here owhen Edittext lose focus 
					if (mEditTextForgetQuestionThaiSername.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.surnameEmpty));
//						mEditTextForgetQuestionThaiSername.requestFocus();
					}
				}
			}
		});
		mEditTextForgetQuestionThaiFathername.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					//do job here owhen Edittext lose focus 
					if (mEditTextForgetQuestionThaiFathername.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.fatherNameEmpty));
//						mEditTextForgetQuestionThaiFathername.requestFocus();
					}
				}
			}
		});
		mEditTextForgetQuestionThaiMothername.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					//do job here owhen Edittext lose focus 
					if (mEditTextForgetQuestionThaiMothername.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.motherNameEmpty));
//						mEditTextForgetQuestionThaiMothername.requestFocus();
					}
				}
			}
		});
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

			// ### Make json request (nid) ###
			String mJsonRequest = "";
			// mJsonRequest += "{\"nid\":\"" +
			// mEditTextForgetPasswordNoHaveEmailQuestion.getText() +
			// "\",\"birthDate\":\"" +
			// mEditTextForgetPasswordNoHaveEmailAnswer.getText() +
			// "\",\"version\":\"1.0.0\"}";

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
		if (mbuttonForgotPasswordHaveEmailSubmit.equals(v)) {
			if (mEditTextForgetQuestionThaiName.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อ", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.nameEmpty));
				mEditTextForgetQuestionThaiName.requestFocus();
				return;
			} else if (mEditTextForgetQuestionThaiSername.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อสกุล", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.surnameEmpty));
				mEditTextForgetQuestionThaiSername.requestFocus();
				return;
			} else if (mEditTextForgetQuestionThaiFathername.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อสกุล คุณพ่อ", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.fatherNameEmpty));
				mEditTextForgetQuestionThaiFathername.requestFocus();
				return;
			} else if (mEditTextForgetQuestionThaiMothername.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(ResetPasswordForgetquestionThai.this, "โปรดใส่ ชื่อสกุล คุณแม่", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.motherNameEmpty));
				mEditTextForgetQuestionThaiMothername.requestFocus();
				return;
			} else {
				new ResetPasswordConfirm().execute();
			}
		} else if (btHintThaiName.equals(v)) {
			PopupDialog popupPassword = new PopupDialog(ResetPasswordForgetquestionThai.this);
			popupPassword.showMessage(getString(R.string.lang_th_forgetpassword_forgetquestion_message_btHintThaiName),
					new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface dialog, int which) {
							// objCheck.get(i).edittext.requestFocus();
						}
					});
		} else if (btHintThaiSername.equals(v)) {
			PopupDialog popupPassword = new PopupDialog(ResetPasswordForgetquestionThai.this);
			popupPassword.showMessage(getString(R.string.lang_th_forgetpassword_forgetquestion_message_btHintThaiSername),
					new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface dialog, int which) {
							// objCheck.get(i).edittext.requestFocus();
						}
					});
		} else if (btHintThaiFathername.equals(v)) {
			PopupDialog popupPassword = new PopupDialog(ResetPasswordForgetquestionThai.this);
			popupPassword.showMessage(getString(R.string.lang_th_forgetpassword_forgetquestion_message_btHintFatherName),
					new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface dialog, int which) {
							// objCheck.get(i).edittext.requestFocus();
						}
					});
		} else if (btHintThaiMothername.equals(v)) {
			PopupDialog popupPassword = new PopupDialog(ResetPasswordForgetquestionThai.this);
			popupPassword.showMessage(getString(R.string.lang_th_forgetpassword_forgetquestion_message_btHintMotherName),
					new DialogInterface.OnClickListener() {
						@Override
						public void onClick(DialogInterface dialog, int which) {
							// objCheck.get(i).edittext.requestFocus();
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