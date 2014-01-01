package com.revenuedepartment.app;

import java.util.ArrayList;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

import com.revenuedepartment.adapter.SatisfactionAdapter;
import com.revenuedepartment.customview.ButtonCustom;

public class SendSatisfaction extends Activity implements OnClickListener {

	ListView lvScore;
	ButtonCustom btSendScore;
	int score_current = -1;
	int[] score = new int[] { 5, 4, 3, 2, 1 };

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);

		this.setView();

		ArrayList<String> mValue = new ArrayList<String>();
		mValue.add("มากที่สด");
		mValue.add("มาก");
		mValue.add("ปานกลาง");
		mValue.add("น้อย");
		mValue.add("น้อยที่สุด");
		lvScore.setAdapter(new SatisfactionAdapter(SendSatisfaction.this, mValue));
	}

	public void setView() {
		setContentView(R.layout.send_satisfaction);

		lvScore = (ListView) findViewById(R.id.lvScore);
		lvScore.setOnItemClickListener(lvScroeClick);

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

	private class sendScore extends AsyncTask<String, Void, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
		}

		@Override
		protected String doInBackground(String... params) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		protected void onPostExecute(String result) {
			super.onPostExecute(result);
			finish();
		}
	}
}
