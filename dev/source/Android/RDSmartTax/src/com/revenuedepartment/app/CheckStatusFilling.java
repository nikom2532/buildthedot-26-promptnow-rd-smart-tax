package com.revenuedepartment.app;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ListView;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.adapter.StatusAdapter;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_CheckStatus;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.req_datamodels.MRequest_CheckStatus;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.checkOnline;

public class CheckStatusFilling extends Activity implements OnClickListener {

	ListView lvStatus;
	TextViewCustom txMessage;
	TopBar topBar;
	Bundle mValue = new Bundle();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		this.setView();

		mValue = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);

//		if (!checkOnline.check(CheckStatusFilling.this)) {
//			new PopupDialog(CheckStatusFilling.this).show("", getString(R.string.alert_no_network));
//		} else {
//			new requestCheckStatus().execute();
//		}

	}

	private void setView() {
		setContentView(R.layout.checkstatusfilling);
		lvStatus = (ListView) findViewById(R.id.lvCheckStatus);
		txMessage = (TextViewCustom) findViewById(R.id.txMessage);
		txMessage.setText("ทานไดยื่นแบบฯ มากกวา1 ฉบับ\nขณะนี้อยูระหวางการพิจารณาหากมีเงินภาษีชําระไวเกิน \nจะดําเนินการคืนภาษีใหทานตอไป");
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_check_status));

	}

	@Override
	public void onClick(View v) {
	}

	private class requestCheckStatus extends AsyncTask<String, Void, P_CheckStatus> {
		DialogProcess dialog = new DialogProcess(CheckStatusFilling.this);
		PopupDialog popup = new PopupDialog(CheckStatusFilling.this);
		ConnectApi connApi = new ConnectApi(CheckStatusFilling.this);
		MRequest_CheckStatus checkStatus = new MRequest_CheckStatus();
		String JSONObjSend;

		public requestCheckStatus() {
			checkStatus.deviceID = new GetDeviceID(CheckStatusFilling.this).getDeviceID();
			checkStatus.authenKey = mValue.getString(JSONElement.authenKey);
			checkStatus.nid = mValue.getString(JSONElement.nid);
			checkStatus.name = mValue.getString(JSONElement.name);
			checkStatus.surname = mValue.getString(JSONElement.surname);
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_CheckStatus doInBackground(String... params) {
			checkStatus.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(checkStatus);
			P_CheckStatus rs = connApi.requestCheckStatus(JSONObjSend);
			return rs;
		}

		@Override
		protected void onPostExecute(P_CheckStatus result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show(getString(R.string.system_error));
			} else {
				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					txMessage.setText(result.message);
					lvStatus.setVisibility(View.GONE);
					lvStatus.setAdapter(new StatusAdapter(CheckStatusFilling.this, result.formDetailList));
				} else {
					popup.show(result.responseMessage);
				}
			}
		}
	}

}