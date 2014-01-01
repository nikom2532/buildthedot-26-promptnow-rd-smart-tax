package com.revenuedepartment.function;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

import com.revenuedepartment.app.R;

public class PopupDialog {
	Context context;

	public PopupDialog(Context context) {
		this.context = context;
	}

	public void show(CharSequence charSequence) {
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
		alert.setMessage(charSequence);
		alert.setNegativeButton("OK", null);
		alert.show();
	}

	public void show(String title, String desc) {
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
		alert.setTitle(title);
		alert.setMessage(desc);
		alert.setNegativeButton("OK", null);
		alert.show();
	}

	public void show(CharSequence text, CharSequence textButton, DialogInterface.OnClickListener listerner) {
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
		alert.setMessage(text);
		alert.setNegativeButton(textButton, listerner);
		alert.show();
	}

	public void showMessage(CharSequence text, DialogInterface.OnClickListener listerner) {
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
//		alert.setTitle(CheckLang.check(context, context.getString(R.string.label_ok_th), context.getString(R.string.label_ok_en)), listerner);
		alert.setMessage(text);
		alert.setNegativeButton(CheckLang.check(context, context.getString(R.string.label_ok_th), context.getString(R.string.label_ok_en)), listerner);
		alert.show();
	}

	public void alert2Button(CharSequence textMessage, CharSequence textButtonLeft, CharSequence textButtonRight,
		DialogInterface.OnClickListener listernerLeft, DialogInterface.OnClickListener listernerRight) {
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
		alert.setMessage(textMessage);
		alert.setNegativeButton(textButtonRight, listernerRight);
		alert.setPositiveButton(textButtonLeft, listernerLeft);
		alert.show();
	}
}
