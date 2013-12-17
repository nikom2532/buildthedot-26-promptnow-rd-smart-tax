package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.TypeView;

public class Filling extends Activity {

	LinearLayout lbContent;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		new getPnd91().execute();
	}

	void setView() {
		setContentView(R.layout.filling);
		lbContent = (LinearLayout) findViewById(R.id.lbContent);
	}

	private class getPnd91 extends AsyncTask<String, Void, P_Filling> {
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
		}

		@Override
		protected P_Filling doInBackground(String... params) {
			ConnectApi conApi = new ConnectApi();
			P_Filling rs = conApi.requestGetPnd91();
			return rs;
		}

		@Override
		protected void onPostExecute(P_Filling result) {
			super.onPostExecute(result);
			if (result == null) {

			} else {
				drawForm(result.getForms()[0]);
				SavedInstance.map.put(SavedInstance.FILLING, result);
			}
		}
	}

	void drawForm(M_Forms forms) {
		TextViewCustom txText = new TextViewCustom(this);
		txText.setText(forms.getFormName());
		txText.setSize(20);
		lbContent.addView(txText);

		for (int i = 0; i < forms.getFormData().getFields().length; i++) {
			M_Fields fields = forms.getFormData().getFields()[i];
			if (fields.getHidden().equals("")) {

				LinearLayout layout = new LinearLayout(this);

				if (fields.getType().equals(TypeView.checkBox)) {
					CheckBox checkBox = new CheckBox(this);
					layout.addView(checkBox);
					TextViewCustom tx = new TextViewCustom(this);
					tx.setText(fields.getLabel());
					tx.setSize(14);
					layout.addView(tx);
					layout.setOrientation(LinearLayout.HORIZONTAL);
					layout.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
				}

				lbContent.addView(layout);
			}
		}
		Button btNext = new Button(this);
		btNext.setText("Next");
		btNext.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(Filling.this, FillingStep2.class);
				startActivityForResult(intent, 0);
			}
		});
		lbContent.addView(btNext);
	}
}
