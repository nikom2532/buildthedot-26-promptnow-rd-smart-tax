package com.revenuedepartment.app;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ListView;

import com.google.gson.Gson;
import com.revenuedepartment.adapter.StatusAdapter;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_CheckStatus;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.service.ConnectApi;

public class CheckStatusFilling extends Activity implements OnClickListener {

	ListView lvStatus;
	TextViewCustom txMessage;

	ObjectRequestStatus objCheckStatus = new ObjectRequestStatus();

	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		this.setView();

		new requestCheckStatus().execute();
	}

	private void setView() {
		setContentView(R.layout.checkstatusfilling);
		lvStatus = (ListView) findViewById(R.id.lvCheckStatus);
		txMessage = (TextViewCustom) findViewById(R.id.txMessage);

		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_check_status));
		
		objCheckStatus.setAuthenKey("");
		objCheckStatus.setName("sssss");

	}

	@Override
	public void onClick(View v) {
	}

	private class requestCheckStatus extends AsyncTask<String, Void, P_CheckStatus> {
		DialogProcess dialog = new DialogProcess(CheckStatusFilling.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_CheckStatus doInBackground(String... params) {
			P_CheckStatus rs = new ConnectApi().requestCheckStatus();
			return rs;
		}

		@Override
		protected void onPostExecute(P_CheckStatus result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
			} else {
				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					txMessage.setText(result.getMessage());
					lvStatus.setVisibility(View.GONE);
					lvStatus.setAdapter(new StatusAdapter(CheckStatusFilling.this, result.getFormDetailList()));
				}
			}
		}
	}

	class ObjectRequestStatus {
		String nid;
		String authenKey;
		String name;
		String sername;

		public String getNid() {
			return nid;
		}

		public void setNid(String nid) {
			this.nid = nid;
		}

		public String getAuthenKey() {
			return authenKey;
		}

		public void setAuthenKey(String authenKey) {
			this.authenKey = authenKey;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getSername() {
			return sername;
		}

		public void setSername(String sername) {
			this.sername = sername;
		}
	}
}