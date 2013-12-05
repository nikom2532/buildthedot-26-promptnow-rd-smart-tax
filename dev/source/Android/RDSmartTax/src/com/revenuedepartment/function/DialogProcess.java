package com.revenuedepartment.function;

import android.app.Dialog;
import android.content.Context;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.TextView;

import com.revenuedepartment.app.R;

public class DialogProcess extends Dialog {

	public DialogProcess(Context context) {
		super(context);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.process);
		Window window = getWindow();
		window.clearFlags(WindowManager.LayoutParams.FLAG_DIM_BEHIND);
		View v = getWindow().getDecorView();
		v.setBackgroundResource(android.R.color.transparent);
		setCancelable(false);
	}

	public void setMessage(String message) {
		TextView tvMessage = (TextView) findViewById(R.id.tvMessage);
		tvMessage.setText(message);
		tvMessage.setVisibility(View.VISIBLE);
	}
}
