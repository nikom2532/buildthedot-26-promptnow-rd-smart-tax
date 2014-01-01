package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.revenuedepartment.adapter.ChanellFillingAdapter;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.datapackages.P_UpdateTaxCal;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.service.ConnectApi;

public class ResultFilling extends Activity implements OnClickListener {

	ListView lvChanall;
	ButtonCustom btBack , btBarCode;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();

		new reqUpdateCalTax().execute();
	}

	public void setView() {
		setContentView(R.layout.result_filling);
		lvChanall = (ListView) findViewById(R.id.lvchanall);
		btBack = (ButtonCustom) findViewById(R.id.btBack);
		btBarCode = (ButtonCustom) findViewById(R.id.btBarCode);
		btBarCode.setDefault();
		btBack.setOnClickListener(this);
	}

	private class reqUpdateCalTax extends AsyncTask<String, Void, P_UpdateTaxCal> {
		DialogProcess dialog = new DialogProcess(ResultFilling.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_UpdateTaxCal doInBackground(String... params) {
			P_UpdateTaxCal rs = new ConnectApi().updatePnd91CalTax();
			return rs;
		}

		@Override
		protected void onPostExecute(final P_UpdateTaxCal result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
			} else {
				lvChanall.setAdapter(new ChanellFillingAdapter(ResultFilling.this, result.getResponseData().getFields()));
				lvChanall.setOnItemClickListener(new OnItemClickListener() {

					@Override
					public void onItemClick(AdapterView<?> arg0, View arg1, int position, long arg3) {

						Bundle bundle = new Bundle();
						if (result.getResponseData().getFields()[position].getPath() != null) {
							bundle.putString("path", result.getResponseData().getFields()[position].getPath());
						} else {
							bundle.putString("path", "-1");
						}
						bundle.putStringArray("logos", result.getResponseData().getFields()[position].getLogos());

						Intent intent = new Intent(ResultFilling.this, ChanallFilling.class);
						intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
						intent.putExtras(bundle);
						startActivityForResult(intent, 0);
					}
				});
			}
		}
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btBack)) {
			setResult(MainEFilling.RESULT_SENDSATISFACTION);
			finish();
		}
	}
}
