package com.revenuedepartment.app;

import java.util.Calendar;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.google.gson.Gson;
import com.revenuedepartment.adapter.PrintFromAdapter;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.datapackages.P_Print;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.req_datamodels.ObjectRequestFormPrint;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.ConnectApi;

public class FormPrint extends Activity implements OnClickListener {

	ButtonCustom btBack, btLeft, btRight;
	ButtonCustom btForm, btReceipt;
	ListView lvFormReceipt;
	ObjectRequestFormPrint requestPrint = new ObjectRequestFormPrint();
	String type = "";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		this.setView();
		this.getData();

	}

	private void getData() {
		// Intent get = getIntent();
		// type = get.getExtras().getString("type");
		type = ConfigApp.F;
		new requestFormPrint(type).execute();
		requestPrint.setFormType(type);
		requestPrint.setFormCode(ConfigApp.PND91);
		Calendar c = Calendar.getInstance();
		int mYear = c.get(Calendar.YEAR);

		btLeft.setText(String.valueOf(mYear + 543));
		btRight.setText(String.valueOf((mYear - 1 + 543)));

	}

	private void setView() {
		setContentView(R.layout.print);
		lvFormReceipt = (ListView) findViewById(R.id.lvFormReceipt);
		btLeft = (ButtonCustom) findViewById(R.id.btLeft);
		btRight = (ButtonCustom) findViewById(R.id.btRight);
		btBack = (ButtonCustom) findViewById(R.id.btBack);
		btForm = (ButtonCustom) findViewById(R.id.btForm);
		btReceipt = (ButtonCustom) findViewById(R.id.btReceipt);
		btReceipt.setOnClickListener(this);
		btBack.setOnClickListener(this);
		btForm.setOnClickListener(this);
		btLeft.setOnClickListener(this);
		btRight.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btBack)) {
			finish();
			overridePendingTransition(0, 0);
		} else if (v.equals(btLeft)) {
			new requestFormPrint(type).execute();
		} else if (v.equals(btRight)) {
			new requestFormPrint(type).execute();
		} else if (v.equals(btForm)) {
			type = ConfigApp.F;
			new requestFormPrint(type).execute();
			requestPrint.setFormType(type);
			requestPrint.setFormCode(ConfigApp.PND91);
			requestPrint.setTaxYear(btLeft.getText().toString());
		} else if (v.equals(btReceipt)) {
			type = ConfigApp.R;
			new requestFormPrint(type).execute();
			requestPrint.setFormType(type);
			requestPrint.setFormCode(ConfigApp.PND91);
			requestPrint.setTaxYear(btLeft.getText().toString());
		}
	}

	private class requestFormPrint extends AsyncTask<String, Void, P_Print> {

		DialogProcess dialog = new DialogProcess(FormPrint.this);
		String type;

		public requestFormPrint(String type) {
			this.type = type;
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_Print doInBackground(String... params) {
			P_Print rs = new ConnectApi().requestPrint(new Gson()
					.toJson(requestPrint));
			return rs;
		}

		@Override
		protected void onPostExecute(P_Print result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {

			} else {
				if (result.getResponseStatus().equals(getString(R.string.OK))) {
					lvFormReceipt.setAdapter(new PrintFromAdapter(
							FormPrint.this, result.getResponseData()
									.getFormData(), type));

					lvFormReceipt
							.setOnItemClickListener(new OnItemClickListener() {

								@Override
								public void onItemClick(AdapterView<?> arg0,
										View arg1, int position, long arg3) {
									Intent i = new Intent(FormPrint.this,
											Readpdf.class);
									startActivityForResult(i, 0);
								}
							});
				}
			}
		}
	}
}
