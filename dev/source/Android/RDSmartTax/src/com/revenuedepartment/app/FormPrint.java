package com.revenuedepartment.app;

import java.util.Calendar;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
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
import com.promptnow.network.model.pfupdateprofile.UpdateProfileResponse;
import com.promptnow.network.model.rqamphur.AmphurResponse;
import com.promptnow.network.model.rqprovince.ProvinceResponse;
import com.promptnow.network.service.AsyncTaskCompleteListener;
import com.promptnow.network.service.ServiceAsyn;
import com.revenuedepartment.adapter.PrintFromAdapter;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_DataPrint;
import com.revenuedepartment.datamodels.M_FormData;
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

public class FormPrint extends Activity implements OnClickListener, AsyncTaskCompleteListener {

	HorizontalPager pagerYear;
	ButtonCustom btLeft, btRight;
	ButtonCustom btForm, btReceipt;
	ListView lvFormReceipt;
	ObjectRequestFormPrint request = new ObjectRequestFormPrint();
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

		request.formType = type;
		request.formCode = ConfigApp.PND91;
		request.taxYear = btLeft.getText().toString();

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
			Log.i("FormPrint", "btLeft is pressed");
			request.taxYear = btLeft.getText().toString();
			
			request.sessionID = PromptnowCommandData.JSESSIONID; 
			request.deviceID = new GetDeviceID(FormPrint.this).getDeviceID();
			request.authenKey = mValue.getString(JSONElement.authenKey);
			request.nid = mValue.getString(JSONElement.nid);
			request.formType = type;
			callService("fl-print-formreceipt", request);
			
//			new requestFormPrint(type).execute();
			btLeft.setEnabled(false);
			btRight.setEnabled(true);
		} else if (v.equals(btRight)) {
			Log.i("FormPrint", "btRight is pressed");
			request.taxYear = btRight.getText().toString();
			
			request.sessionID = PromptnowCommandData.JSESSIONID; 
			request.deviceID = new GetDeviceID(FormPrint.this).getDeviceID();
			request.authenKey = mValue.getString(JSONElement.authenKey);
			request.nid = mValue.getString(JSONElement.nid);
			request.formType = type;
			callService("fl-print-formreceipt", request);
//			new requestFormPrint(type).execute();
			btLeft.setEnabled(true);
			btRight.setEnabled(false);
		} else if (v.equals(btForm)) {
			Log.i("FormPrint", "btForm is pressed");
			type = ConfigApp.F;
//			new requestFormPrint(type).execute();

			request.sessionID = PromptnowCommandData.JSESSIONID; 
			request.deviceID = new GetDeviceID(FormPrint.this).getDeviceID();
			request.authenKey = mValue.getString(JSONElement.authenKey);
			request.nid = mValue.getString(JSONElement.nid);
			request.formType = type;
			callService("fl-print-formreceipt", request);
			 
			request.formCode = ConfigApp.PND91;
			request.taxYear = btLeft.getText().toString();

			btForm.setEnabled(false);
			btReceipt.setEnabled(true);
		} else if (v.equals(btReceipt)) {
			Log.i("FormPrint", "btReceipt is pressed");
			type = ConfigApp.R;
//			new requestFormPrint(type).execute();
			
			request.sessionID = PromptnowCommandData.JSESSIONID; 
			request.deviceID = new GetDeviceID(FormPrint.this).getDeviceID();
			request.authenKey = mValue.getString(JSONElement.authenKey);
			request.nid = mValue.getString(JSONElement.nid);
			request.formType = type;
			callService("fl-print-formreceipt", request);
 
			request.formCode = ConfigApp.PND91;
			request.taxYear = btLeft.getText().toString();

			btForm.setEnabled(true);
			btReceipt.setEnabled(false);
		}
	}
	
	private void callService(String service, Object request) {
		Gson g = new Gson(); 
		String json = g.toJson(request); 
		Log.i("FormPrint", "request : "+json);
		new ServiceAsyn(this, json, service).execute(); 
	} 

	private class requestFormPrint extends AsyncTask<String, Void, P_Print> {

		String type;
		DialogProcess dialog = new DialogProcess(FormPrint.this);
		PopupDialog popup = new PopupDialog(FormPrint.this);
		ConnectApi connApi = new ConnectApi(FormPrint.this);
		String JSONObjSend;

		public requestFormPrint(String type) {

			this.type = type;
			request.deviceID = new GetDeviceID(FormPrint.this).getDeviceID();
			request.authenKey = mValue.getString(JSONElement.authenKey);
			request.nid = mValue.getString(JSONElement.nid);
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_Print doInBackground(String... params) {
			request.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(request);
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
				Log.i("FormPrint", "result : "+result.responseData);
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

	@Override
	public void onTaskComplete(String result, String service) {
		Log.i("FormPrint", "result : "+result); 
		try { 
			Gson g = new Gson(); 
			JSONObject jsonObject = new JSONObject(result); 
			if(service.equals("fl-print-formreceipt")){
				P_Print response = g.fromJson(result, P_Print.class);   
				Log.i("FormPrint", "response.responseCode : "+response.responseCode);
				if(response.responseCode.equals(CommonResponseRD.CODE_SUCCESS)){
					Log.i("FormPrint", "result.responseData : \n"+response.responseData);
					Log.i("FormPrint", "result.responseData.getFormData() : \n"+response.responseData.getFormData());
					Log.i("FormPrint", "result.responseData.getFormData() : \n"+response.responseData.getFormData().size());
					for(int index=0; index<response.responseData.getFormData().size(); index++){
						M_FormData formData = response.responseData.getFormData().get(index);
						Log.i("FormPrint", ""+formData.getRefNo());
					}
					lvFormReceipt.setAdapter(new PrintFromAdapter(FormPrint.this, response.responseData.getFormData(), type));
					lvFormReceipt.setOnItemClickListener(new OnItemClickListener() {
						
						@Override
						public void onItemClick(AdapterView<?> arg0, View arg1, int position, long arg3) {
							Intent i = new Intent(FormPrint.this, Readpdf.class);
							startActivityForResult(i, 0);
						}
					});
				}
			} else if(ServiceAsyn.haveKey(jsonObject, "responseMessage")){
				PopupDialog popup = new PopupDialog(this);
				UpdateProfileResponse response = g.fromJson(result, UpdateProfileResponse.class);
				Log.i("Joe", response.responseMessage); 
				popup.show(response.responseMessage);
			} 
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} 
	}
}
