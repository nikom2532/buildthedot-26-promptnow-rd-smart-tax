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

import com.revenuedepartment.adapter.InstructionsAdapter;
import com.revenuedepartment.datapackages.P_Instructions;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.service.ConnectApi;

public class InstructionsList extends Activity implements OnClickListener {

	ListView lvInstructions;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		this.setView();

		new requestInstructions().execute();
	}

	public void setView() {
		setContentView(R.layout.instructions_list);
		lvInstructions = (ListView) findViewById(R.id.lvInstructions);
		lvInstructions.setOnItemClickListener(lvInstructionsClick);
	}

	OnItemClickListener lvInstructionsClick = new OnItemClickListener() {

		@Override
		public void onItemClick(AdapterView<?> arg0, View arg1, int position,
				long arg3) {
			Intent intent = new Intent(InstructionsList.this,
					InstructionsDetail.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	};

	@Override
	public void onClick(View v) {
	}

	private class requestInstructions extends
			AsyncTask<String, Void, P_Instructions> {
		DialogProcess dialog = new DialogProcess(InstructionsList.this);

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			dialog.show();
		}

		@Override
		protected P_Instructions doInBackground(String... params) {
			P_Instructions rs = new ConnectApi().requestInstructions();
			return rs;
		}

		@Override
		protected void onPostExecute(P_Instructions result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);
			dialog.dismiss();
			if (result == null) {
			} else {
				if (result.getResponseCode().equals(getString(R.string.value0))) {
					lvInstructions.setAdapter(new InstructionsAdapter(
							InstructionsList.this, result.getResponseData()));
				}
			}
		}
	}
}
