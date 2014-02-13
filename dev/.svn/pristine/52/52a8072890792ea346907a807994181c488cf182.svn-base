package com.revenuedepartment.app;

import java.util.Calendar;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.LinearLayout;
import android.widget.ListView;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.adapter.PrintFromAdapter;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_Print;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.HorizontalPager;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.req_datamodels.ObjectRequestFormPrint;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.checkOnline;

public class FormPrint extends Activity implements OnClickListener {

	HorizontalPager pagerYear;
	ButtonCustom btLeft, btRight;
	ButtonCustom btForm, btReceipt;
	ListView lvFormReceipt;
	ObjectRequestFormPrint requestPrint = new ObjectRequestFormPrint();
	String type = "";
	TopBar topBar;

	int[] layoutYear = new int[] { R.layout.items_page, R.layout.items_page };

	Bundle mValue = new Bundle();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		mValue = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);

		this.setView();
		this.getData();
		this.setBarYear();
	}

	private void getData() {

		type = ConfigApp.F;

		Calendar c = Calendar.getInstance();
		int mYear = c.get(Calendar.YEAR);

		btRight.setText(String.valueOf((mYear + 543) - 1));
		btLeft.setText(String.valueOf(((mYear - 2) + 543)));

		requestPrint.formType = type;
		requestPrint.formCode = ConfigApp.PND91;
		requestPrint.taxYear = btLeft.getText().toString();

//		if (!checkOnline.check(FormPrint.this)) {
//			new PopupDialog(FormPrint.this).show("", getString(R.string.alert_no_network));
//		} else {
//			new requestFormPrint(type).execute();
//		}
	}

	private void setView() {
		setContentView(R.layout.print);
		lvFormReceipt = (ListView) findViewById(R.id.lvFormReceipt);
		btLeft = (ButtonCustom) findViewById(R.id.btLeft);
		btRight = (ButtonCustom) findViewById(R.id.btRight1);
		btForm = (ButtonCustom) findViewById(R.id.btForm);
		btReceipt = (ButtonCustom) findViewById(R.id.btReceipt);
		pagerYear = (HorizontalPager) findViewById(R.id.pagerYear);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_print));

		btReceipt.setOnClickListener(this);
		btForm.setOnClickListener(this);
		btLeft.setOnClickListener(this);
		btRight.setOnClickListener(this);

		btForm.setEnabled(false);
		btReceipt.setEnabled(true);
		btLeft.setEnabled(true);
		btRight.setEnabled(false);
	}

	LayoutInflater layoutInflater;

	private void setBarYear() {
		layoutInflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
		for (int i = 0; i < layoutYear.length; i++) {
			LinearLayout page = (LinearLayout) layoutInflater.inflate(layoutYear[i], null);
			pagerYear.addView(page);
		}
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btLeft)) {

			requestPrint.taxYear = btLeft.getText().toString();
//			new requestFormPrint(type).execute();
			btLeft.setEnabled(false);
			btRight.setEnabled(true);
		} else if (v.equals(btRight)) {

			requestPrint.taxYear = btRight.getText().toString();
//			new requestFormPrint(type).execute();
			btLeft.setEnabled(true);
			btRight.setEnabled(false);
		} else if (v.equals(btForm)) {
			type = ConfigApp.F;
//			new requestFormPrint(type).execute();

			requestPrint.formType = type;
			requestPrint.formCode = ConfigApp.PND91;
			requestPrint.taxYear = btLeft.getText().toString();

			btForm.setEnabled(false);
			btReceipt.setEnabled(true);
		} else if (v.equals(btReceipt)) {
			type = ConfigApp.R;
//			new requestFormPrint(type).execute();

			requestPrint.formType = type;
			requestPrint.formCode = ConfigApp.PND91;
			requestPrint.taxYear = btLeft.getText().toString();

			btForm.setEnabled(true);
			btReceipt.setEnabled(false);
		}
	}

	private class requestFormPrint extends AsyncTask<String, Void, P_Print> {

		String type;
		DialogProcess dialog = new DialogProcess(FormPrint.this);
		PopupDialog popup = new PopupDialog(FormPrint.this);
		ConnectApi connApi = new ConnectApi(FormPrint.this);
		String JSONObjSend;

		public requestFormPrint(String type) {

			this.type = type;
			requestPrint.deviceID = new GetDeviceID(FormPrint.this).getDeviceID();
			requestPrint.authenKey = mValue.getString(JSONElement.authenKey);
			requestPrint.nid = mValue.getString(JSONElement.nid);
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_Print doInBackground(String... params) {
			requestPrint.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(requestPrint);
			P_Print rs = connApi.requestPrint(JSONObjSend);
			return rs;
		}

		@Override
		protected void onPostExecute(P_Print result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show(getString(R.string.system_error));
			} else {

				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					lvFormReceipt.setAdapter(new PrintFromAdapter(FormPrint.this, result.responseData.getFormData(), type));

					lvFormReceipt.setOnItemClickListener(new OnItemClickListener() {

						@Override
						public void onItemClick(AdapterView<?> arg0, View arg1, int position, long arg3) {
							Intent i = new Intent(FormPrint.this, Readpdf.class);
							startActivityForResult(i, 0);
						}
					});
				} else {
					popup.show(result.responseMessage);
				}
			}
		}
	}
}
