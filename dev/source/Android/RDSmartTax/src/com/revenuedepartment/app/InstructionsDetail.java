package com.revenuedepartment.app;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datapackages.P_InstructionDetail;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.service.ConnectApi;

public class InstructionsDetail extends Activity implements OnClickListener {

	TextViewCustom txMessage;
	ButtonCustom btBack;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		this.setView();

		new requestInstructions().execute();
	}

	public void setView() {
		setContentView(R.layout.instructions_detail);
		txMessage = (TextViewCustom) findViewById(R.id.txMessage);
		btBack = (ButtonCustom) findViewById(R.id.btBack);

		btBack.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btBack)) {
			finish();
			overridePendingTransition(0, 0);
		}
	}

	private class requestInstructions extends
			AsyncTask<String, Void, P_InstructionDetail> {
		DialogProcess dialog = new DialogProcess(InstructionsDetail.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_InstructionDetail doInBackground(String... params) {
			P_InstructionDetail rs = new ConnectApi()
					.requestInstructionDetail();
			return rs;
		}

		@Override
		protected void onPostExecute(P_InstructionDetail result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
			} else {
				if (result.getResponseCode().equals(getString(R.string.value0))) {
					txMessage.setText(result.getResponseData()
							.getInstructions_message());
				}
			}
		}
	}
}
