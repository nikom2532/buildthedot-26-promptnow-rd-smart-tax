package com.revenuedepartment.app;

import java.util.ArrayList;

import android.app.Activity;
import android.content.DialogInterface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.adapter.SatisfactionAdapter;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.req_datamodels.MRequest_Satisfaction;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;

public class SendSatisfaction extends Activity implements OnClickListener {

	ListView lvScore;
	ButtonCustom btSendScore;
	int score_current = -1;
	int[] score = new int[] { 5, 4, 3, 2, 1 };
	TopBar topBar;

	SeekBar skBar;
	TextViewCustom txScore;

	ArrayList<String> mValue = new ArrayList<String>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);

		this.setView();

		mValue.add("มากที่สด");
		mValue.add("มาก");
		mValue.add("ปานกลาง");
		mValue.add("น้อย");
		mValue.add("น้อยที่สุด");
		lvScore.setAdapter(new SatisfactionAdapter(SendSatisfaction.this, mValue));
		skBar.setProgress(50);
		display_score(50);
		skBar.setOnSeekBarChangeListener(new OnSeekBarChangeListener() {

			@Override
			public void onStopTrackingTouch(SeekBar arg0) {

			}

			@Override
			public void onStartTrackingTouch(SeekBar arg0) {

			}

			@Override
			public void onProgressChanged(SeekBar arg0, int arg1, boolean arg2) {
				int value1 = arg0.getProgress();
				display_score(value1);
			}
		});
	}

	public void display_score(int value1) {
		if (value1 > 80) {
			score_current = 5;
			txScore.setTextChangeLanguage(mValue.get(0));
		} else if (value1 > 60) {
			score_current = 4;
			txScore.setTextChangeLanguage(mValue.get(1));
		} else if (value1 > 40) {
			score_current = 3;
			txScore.setTextChangeLanguage(mValue.get(2));
		} else if (value1 > 20) {
			score_current = 2;
			txScore.setTextChangeLanguage(mValue.get(3));
		} else {
			score_current = 1;
			txScore.setTextChangeLanguage(mValue.get(4));
		}
	}

	public void setView() {
		setContentView(R.layout.send_satisfaction);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.hideBack();
		topBar.setTitle(getString(R.string.label_satisfaction));
		lvScore = (ListView) findViewById(R.id.lvScore);
		lvScore.setOnItemClickListener(lvScroeClick);
		skBar = (SeekBar) findViewById(R.id.skBar);
		txScore = (TextViewCustom) findViewById(R.id.txScore);

		btSendScore = (ButtonCustom) findViewById(R.id.btSendScore);
		btSendScore.setDefault();
		btSendScore.setOnClickListener(this);

	}

	OnItemClickListener lvScroeClick = new OnItemClickListener() {

		@Override
		public void onItemClick(AdapterView<?> arg0, View arg1, int position, long arg3) {
			score_current = score[position];
		}
	};

	@Override
	public void onClick(View v) {
		if (btSendScore.equals(v)) {
			new sendScore().execute();
		}
	}

	private class sendScore extends AsyncTask<String, Void, CommonResponseRD> {

		PopupDialog popup = new PopupDialog(SendSatisfaction.this);
		DialogProcess dialog = new DialogProcess(SendSatisfaction.this);
		ConnectApi connApi = new ConnectApi(SendSatisfaction.this);
		MRequest_Satisfaction requestSend = new MRequest_Satisfaction();
		String JSONObjSend;

		public sendScore() {
			Bundle value = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);
			requestSend.nid = value.getString(JSONElement.nid);
			requestSend.authenKey = value.getString(JSONElement.authenKey);
			requestSend.deviceID = new GetDeviceID(SendSatisfaction.this).getDeviceID();
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected CommonResponseRD doInBackground(String... params) {
			requestSend.sessionID = PromptnowCommandData.JSESSIONID;
			JSONObjSend = new Gson().toJson(requestSend);
			CommonResponseRD rs = connApi.sendSatisfication(JSONObjSend);
			return rs;
		}

		@Override
		protected void onPostExecute(CommonResponseRD result) {
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
				popup.show("", getString(R.string.system_error));
			} else {
				if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					new PopupDialog(SendSatisfaction.this).showMessage(getString(R.string.alert_thank_satisfaction),
							new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface dialog, int which) {
									finish();
									overridePendingTransition(0, R.anim.slide_out_right);
								}
							});
					return;
				} else {
					popup.show(result.responseMessage);
				}
			}
		}
	}
}
