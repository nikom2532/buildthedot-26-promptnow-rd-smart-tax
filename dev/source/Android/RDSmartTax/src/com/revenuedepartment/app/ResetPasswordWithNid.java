package com.revenuedepartment.app;

import java.util.ArrayList;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionChangeOnlyPassword;
import com.revenuedepartment.datamodels.M_ResetPasswordQuestionConfirm;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.function.CheckLang;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.ElementMessage;
import com.revenuedepartment.service.GetMessageError;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

//ResetPasswordNoHaveEmail is Answer Question for get password
public class ResetPasswordWithNid extends Activity implements OnClickListener {
	EditText mEditTextResetOldPassword;
	EditText mEditTextResetNewPassword1;
	EditText mEditTextResetNewPassword2;
	ButtonCustom btHintOldPassword;
	ButtonCustom btHintPassword;
	ButtonCustom btHintPasswordAgain;
	ButtonCustom mbuttonResetPasswordWithNidSubmit;
	
	ArrayList<String> array_Question = new ArrayList<String>();
	
	TopBar topbar;
	
	PopupDialog popup = new PopupDialog(ResetPasswordWithNid.this);
	GetMessageError messageError;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
		messageError = new GetMessageError(ResetPasswordWithNid.this);
	}

	public void setView() {
		setContentView(R.layout.reset_password_withnid);
		mEditTextResetOldPassword = (EditText) findViewById(R.id.mEditTextResetOldPassword);
		mEditTextResetNewPassword1 = (EditText) findViewById(R.id.mEditTextResetNewPassword1);
		mEditTextResetNewPassword2 = (EditText) findViewById(R.id.mEditTextResetNewPassword2);
		
		mbuttonResetPasswordWithNidSubmit = (ButtonCustom) findViewById(R.id.mbuttonResetPasswordWithNidSubmit);
		mbuttonResetPasswordWithNidSubmit.setDefault();
		mbuttonResetPasswordWithNidSubmit.setOnClickListener(this);

		btHintOldPassword = (ButtonCustom) findViewById(R.id.btHintOldPassword);
		btHintOldPassword.setOnClickListener(this);
		btHintPassword = (ButtonCustom) findViewById(R.id.btHintPassword);
		btHintPassword.setOnClickListener(this);
		btHintPasswordAgain = (ButtonCustom) findViewById(R.id.btHintPasswordAgain);
		btHintPasswordAgain.setOnClickListener(this);
		
		mEditTextResetOldPassword.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
		mEditTextResetNewPassword1.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
		mEditTextResetNewPassword2.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
		// mEditTextResetNewPassword1.setInputType(InputType.TYPE_CLASS_TEXT |
		// InputType.TYPE_TEXT_VARIATION_PASSWORD);
		// mEditTextResetNewPassword2.setInputType(InputType.TYPE_CLASS_TEXT |
		// InputType.TYPE_TEXT_VARIATION_PASSWORD);
		
		topbar = (TopBar) findViewById(R.id.Topbar);
		topbar.setTitle(getString(R.string.label_change_password));
		
		setOnFocusChangeListener();
	}
	
	private void setOnFocusChangeListener(){
		mEditTextResetOldPassword.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					//do job here owhen Edittext lose focus 
					if (mEditTextResetOldPassword.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.oldPasswordEmpty));
//						mEditTextResetOldPassword.requestFocus();
					}
					else if (mEditTextResetOldPassword.getText().toString().length() != 8) {
						popup.show("", "โปรดใส่ รหัสผ่านเก่า ให้ครบ 8 หลัก");
//						mEditTextResetOldPassword.requestFocus();
					}
				}
			}
		});
		mEditTextResetNewPassword1.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					//do job here owhen Edittext lose focus 
					if (mEditTextResetNewPassword1.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.passwordEmpty));
//						mEditTextResetNewPassword1.requestFocus();
					}
					else if (mEditTextResetNewPassword1.getText().toString().length() != 8) {
						popup.show("", "โปรดใส่ รหัสผ่าน ให้ครบ 8 หลัก");
//						mEditTextResetNewPassword1.requestFocus();
					}
				}
			}
		});
		mEditTextResetNewPassword2.setOnFocusChangeListener(new OnFocusChangeListener() {
			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				if(!hasFocus){
					//do job here owhen Edittext lose focus 
					if (mEditTextResetNewPassword2.getText().toString().equalsIgnoreCase("")) {
						popup.show("", messageError.getFieldMessage(ElementMessage.newPasswordEmpty));
//						mEditTextResetNewPassword2.requestFocus();
					}
					else if (mEditTextResetNewPassword2.getText().toString().length() != 8) {
						popup.show("", "โปรดใส่ รหัสผ่านตัวที่ 2 อีกครั้ง ให้ครบ 8 หลัก");
//						mEditTextResetNewPassword2.requestFocus();
					}
					else if (!mEditTextResetNewPassword1.getText().toString().equals(mEditTextResetNewPassword2.getText().toString())) {
						popup.show("", messageError.getFieldMessage(ElementMessage.passwordNotEqual));
//						mEditTextResetNewPassword2.requestFocus();
					}
				}
			}
		});
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub

		if (mbuttonResetPasswordWithNidSubmit.equals(v)) {
			if (mEditTextResetOldPassword.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่านเก่า", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.oldPasswordEmpty));
				mEditTextResetOldPassword.requestFocus();
				return;
			} else if (mEditTextResetOldPassword.getText().toString().length() != 8) {
//				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่านเก่า ให้ครบ 8 หลัก", Toast.LENGTH_SHORT).show();
//				popup.show("", messageError.getFieldMessage(ElementMessage.oldPasswordWrong));
				popup.show("", "โปรดใส่ รหัสผ่านเก่า ให้ครบ 8 หลัก");
				mEditTextResetOldPassword.requestFocus();
				return;
			} else if (mEditTextResetNewPassword1.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่าน", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.passwordEmpty));
				mEditTextResetNewPassword1.requestFocus();
				return;
			} else if (mEditTextResetNewPassword1.getText().toString().length() != 8) {
//				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่าน ให้ครบ 8 หลัก", Toast.LENGTH_SHORT).show();
//				popup.show("", messageError.getFieldMessage(ElementMessage.passwordWrong));
				popup.show("", "โปรดใส่ รหัสผ่าน ให้ครบ 8 หลัก");
				mEditTextResetNewPassword1.requestFocus();
				return;
			} else if (mEditTextResetNewPassword2.getText().toString().equalsIgnoreCase("")) {
//				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่านตัวที่ 2 อีกครั้ง", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.newPasswordEmpty));
				mEditTextResetNewPassword2.requestFocus();
				return;
			} else if (mEditTextResetNewPassword2.getText().toString().length() != 8) {
//				Toast.makeText(ResetPasswordWithNid.this, "โปรดใส่ รหัสผ่านตัวที่ 2 อีกครั้ง ให้ครบ 8 หลัก", Toast.LENGTH_SHORT).show();
//				popup.show("", messageError.getFieldMessage(ElementMessage.newPasswordWrong));
				popup.show("", "โปรดใส่ รหัสผ่านตัวที่ 2 อีกครั้ง ให้ครบ 8 หลัก");
				mEditTextResetNewPassword2.requestFocus();
				return;
			} else if (!mEditTextResetNewPassword1.getText().toString().equals(mEditTextResetNewPassword2.getText().toString())) {
//				Toast.makeText(ResetPasswordWithNid.this, "รหัสผ่านใหม่ 2ตัว ไม่เหมือนกัน โปรดใส่อีกครั้ง", Toast.LENGTH_SHORT).show();
				popup.show("", messageError.getFieldMessage(ElementMessage.passwordNotEqual));
				mEditTextResetNewPassword2.requestFocus();
				return;
			} else {
				// new ChangeOnlyPassword().execute();
				Toast.makeText(ResetPasswordWithNid.this, "เปลี่ยนรหัส เสร็จสมบูรณ์", Toast.LENGTH_SHORT).show();
				setResult(Login_E_Filing.RESULT_RESETPASSWORD);
				finish();
			}
		} else if (btHintPassword.equals(v)) {
			PopupDialog popupPassword = new PopupDialog(ResetPasswordWithNid.this);
			popupPassword.showMessage("โปรดใส่ Password ใหม่ ใส่ได้ 6 ตัว อักษร", new DialogInterface.OnClickListener() {
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
			PopupDialog popupPasswordAgain = new PopupDialog(ResetPasswordWithNid.this);
			popupPasswordAgain.showMessage("โปรดใส่ Password ใหม่อีกครั้ง ใส่ได้ 6 ตัว อักษร", new DialogInterface.OnClickListener() {
				@Override
				public void onClick(DialogInterface dialog, int which) {
					
				}
			});
		} else if (btHintOldPassword.equals(v)) {
			PopupDialog popupPasswordAgain = new PopupDialog(ResetPasswordWithNid.this);
			popupPasswordAgain.showMessage("โปรดใส่ Password ตัวเก่า", new DialogInterface.OnClickListener() {
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
			finish();
		}
	}
}