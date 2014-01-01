package com.revenuedepartment.app;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.function.CheckLang;
import com.revenuedepartment.function.PopupDialog;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

public class ResultTax extends Activity implements OnClickListener {
	ButtonCustom btBack, btDetail, btFilling;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
	}

	private void setView() {
		setContentView(R.layout.result_tax);
		btBack = (ButtonCustom) findViewById(R.id.btBack);
		btDetail = (ButtonCustom) findViewById(R.id.btDetail);
		btFilling = (ButtonCustom) findViewById(R.id.btFilling);

		btFilling.setDefault();
		btDetail.setDefault();
		btBack.setOnClickListener(this);
		btDetail.setOnClickListener(this);
		btFilling.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		if (btBack.equals(v)) {
			finish();
			overridePendingTransition(0, 0);
		} else if (btDetail.equals(v)) {

			Intent intent = new Intent(ResultTax.this, FillingDetail.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);

		} else if (btFilling.equals(v)) {
			PopupDialog dialog = new PopupDialog(ResultTax.this);
			dialog.alert2Button(CheckLang.check(ResultTax.this, getString(R.string.confirm_filling_th), getString(R.string.confirm_filling_en)),
					CheckLang.check(ResultTax.this, getString(R.string.label_cancel_th), getString(R.string.label_cancel_en)),
					CheckLang.check(ResultTax.this, getString(R.string.label_ok_th), getString(R.string.label_ok_en)),
					new DialogInterface.OnClickListener() {

						@Override
						public void onClick(DialogInterface dialog, int which) {
							dialog.dismiss();
						}
					}, new DialogInterface.OnClickListener() {

						@Override
						public void onClick(DialogInterface dialog, int which) {
							setResult(MainEFilling.RESULT_CLOSE);
							finish();

						}
					});
		}
	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		finish();
		overridePendingTransition(0, 0);
	}
}
