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

public class TaxInstructions extends Activity implements OnClickListener {

	TextViewCustom tvhead_instruction,tvtitle_instruction;
	TopBar topBar;
	SharedPref pref;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		pref = new SharedPref(TaxInstructions.this);
		setView();

	}

	private void setView() {
		CommonRequestRD.LANG = "th";
		setContentView(R.layout.tax_instructions);
		tvhead_instruction= (TextViewCustom) findViewById(R.id.tvhead_instruction);
		tvtitle_instruction = (TextViewCustom) findViewById(R.id.tvtitle_instruction);
		tvhead_instruction.setText(R.string.tvheadtax_instructions);
		tvtitle_instruction.setText(R.string.tvtitletax_instructions);
		
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_suggestion_topic));
//		tvhead_instruction.setText(ReadTextFromFile.readTxt(TaxInstructions.this, R.raw.head_instruction));
//		tvtitle_instruction.setText(ReadTextFromFile.readTxt(TaxInstructions.this, R.raw.title_instruction));
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
