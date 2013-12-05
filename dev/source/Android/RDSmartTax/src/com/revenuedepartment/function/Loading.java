package com.revenuedepartment.function;

import android.content.Context;

public class Loading {
	DialogProcess dialog;
	Context context;

	public Loading(Context context) {
		this.context = context;
		dialog = new DialogProcess(context);
	}

	public void show() {
		dialog.show();
	}

	public void show(String message) {

		dialog.setMessage(message);
		dialog.show();
	}

	public void dismiss() {
		if (dialog.isShowing()) {
			dialog.dismiss();
		}
	}
}