package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

import com.promptnow.network.model.CommonRequestRD;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.service.SharedPref;

public class TermTax extends Activity implements OnClickListener {

	TextViewCustom tvhead_term_tax,tvtitle_term_tax;
	TopBar topBar;
	SharedPref pref;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		pref = new SharedPref(TermTax.this);
		setView();

	}

	private void setView() {
		CommonRequestRD.LANG = "th";
		setContentView(R.layout.term_tax);
		tvhead_term_tax= (TextViewCustom) findViewById(R.id.tvhead_term_tax);
		tvhead_term_tax.setText(R.string.tvheadterm_tax);
		tvtitle_term_tax = (TextViewCustom) findViewById(R.id.tvtitle_term_tax);
		tvtitle_term_tax.setText(R.string.tvtitleterm_tax);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_suggestion_topic));
//		tvhead_term_tax.setText(ReadTextFromFile.readTxt(TermTax.this, R.raw.head_term_tax));
//		tvtitle_term_tax.setText(ReadTextFromFile.readTxt(TermTax.this, R.raw.title_term_tax));
	}
	
	


	@Override
	public void onClick(View v) {}


	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		setResult(99);
		finish();
	}
}
