package com.revenuedepartment.function;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

public class Alert {
	Context context;

	public Alert(Context context) {
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

	public void show(CharSequence text, CharSequence textButton,
			DialogInterface.OnClickListener listerner) {
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
		alert.setMessage(text);
		alert.setNegativeButton(textButton, listerner);
		alert.show();
	}

	public void alert2Button(CharSequence textMessage,
			CharSequence textButtonLeft, CharSequence textButtonRight,
			DialogInterface.OnClickListener listernerLeft,
			DialogInterface.OnClickListener listernerRight) {
		AlertDialog.Builder alert = new AlertDialog.Builder(context);
		alert.setMessage(textMessage);
		alert.setNegativeButton(textButtonLeft, listernerLeft);
		alert.setPositiveButton(textButtonRight, listernerRight);
		alert.show();
	}
}
