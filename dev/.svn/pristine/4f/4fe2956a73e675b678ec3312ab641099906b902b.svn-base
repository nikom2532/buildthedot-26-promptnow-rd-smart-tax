package com.revenuedepartment.app;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_InstructionDetail;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.service.ConnectApi;

public class InstructionsDetail extends Activity implements OnClickListener {

	TextViewCustom txMessage;
	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		this.setView();

		new requestInstructions().execute();
	}

	public void setView() {
		setContentView(R.layout.instructions_detail);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_suggestion_topic));
		txMessage = (TextViewCustom) findViewById(R.id.txMessage);
	}

	@Override
	public void onClick(View v) {
	}

	private class requestInstructions extends AsyncTask<String, Void, P_InstructionDetail> {
		DialogProcess dialog = new DialogProcess(InstructionsDetail.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_InstructionDetail doInBackground(String... params) {
			P_InstructionDetail rs = new ConnectApi().requestInstructionDetail();
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
					txMessage.setText(result.getResponseData().getInstructions_message());
				}
			}
		}
	}
}
