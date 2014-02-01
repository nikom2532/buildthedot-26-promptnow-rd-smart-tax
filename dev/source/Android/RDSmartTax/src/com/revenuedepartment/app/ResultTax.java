package com.revenuedepartment.app;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.function.CheckLang;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.service.checkOnline;

public class ResultTax extends Activity implements OnClickListener {
	ButtonCustom btDetail, btFilling;
	LinearLayout lnNoPayment;
	CheckBox cbDonate, cbNoDonate, cbNoRefun, cbRefun;
	RelativeLayout lnDetail;
	TextViewCustom labelRefun, txRefen;
	LinearLayout lnRetrunFun;
	TopBar topbar;
	double amountReturn = 3;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setView();
		this.checkBox();
		this.checkReturnDisplay();
		
		if (!checkOnline.check(ResultTax.this)) {
			new PopupDialog(ResultTax.this).show("", getString(R.string.alert_no_network));
		} else {}
	}	

	private void setView() {
		setContentView(R.layout.result_tax);
		btDetail = (ButtonCustom) findViewById(R.id.btDetail);
		btFilling = (ButtonCustom) findViewById(R.id.btFilling);
		lnRetrunFun = (LinearLayout) findViewById(R.id.lnRetrunFun);
		lnDetail = (RelativeLayout) findViewById(R.id.lnDetail);
		topbar = (TopBar) findViewById(R.id.Topbar);
		labelRefun = (TextViewCustom) findViewById(R.id.labelRefun);
		lnNoPayment = (LinearLayout) findViewById(R.id.lnNoPayment);
		txRefen = (TextViewCustom) findViewById(R.id.txRefen);
		topbar.setTitle(getString(R.string.label_efilling));

		btFilling.setDefault();
		btDetail.setDefault();
		btDetail.setOnClickListener(this);
		btFilling.setOnClickListener(this);
		lnDetail.setOnClickListener(this);

		topbar.setImageRight(R.drawable.btn_logout, new OnClickListener() {

			@Override
			public void onClick(View v) {
				
			}
		});

	}

	private void checkReturnDisplay() {
		if (amountReturn == 0) {
			labelRefun.setTextChangeLanguage(getString(R.string.label_fun_payment));
			lnRetrunFun.setVisibility(View.GONE);
			lnNoPayment.setVisibility(View.GONE);
			txRefen.setText("0.00");
		} else if (amountReturn > 0) {
			labelRefun.setTextChangeLanguage(getString(R.string.label_fun_return));
			lnRetrunFun.setVisibility(View.VISIBLE);
		} else {
			labelRefun.setTextChangeLanguage(getString(R.string.label_fun_payment));
			lnRetrunFun.setVisibility(View.GONE);
		}

	}

	private void checkBox() {
		cbDonate = (CheckBox) findViewById(R.id.cbDonate);
		cbNoDonate = (CheckBox) findViewById(R.id.cbNoDonate);
		lnRetrunFun = (LinearLayout) findViewById(R.id.lnRetrunFun);

		cbDonate.setOnCheckedChangeListener(checkChangeDonate);
		cbNoDonate.setOnCheckedChangeListener(checkChangeDonate);

		cbRefun = (CheckBox) findViewById(R.id.cbRefun);
		cbNoRefun = (CheckBox) findViewById(R.id.cbNoRefun);
		cbNoRefun.setOnCheckedChangeListener(checkChangeRefun);
		cbRefun.setOnCheckedChangeListener(checkChangeRefun);
		topbar.setTitle(getString(R.string.label_efilling));
	}

	OnCheckedChangeListener checkChangeDonate = new OnCheckedChangeListener() {

		@Override
		public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
			cbDonate.setChecked(false);
			cbNoDonate.setChecked(false);
			if (isChecked) {
				buttonView.setChecked(true);
			} else {
				buttonView.setChecked(false);
			}

		}
	};

	OnCheckedChangeListener checkChangeRefun = new OnCheckedChangeListener() {

		@Override
		public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
			cbRefun.setChecked(false);
			cbNoRefun.setChecked(false);

			if (isChecked) {
				buttonView.setChecked(true);
			} else {
				buttonView.setChecked(false);
			}

		}
	};

	@Override
	public void onClick(View v) {
		if (btDetail.equals(v) || lnDetail.equals(v)) {

			Intent intent = new Intent(ResultTax.this, FillingDetail.class);
			startActivityForResult(intent, 0);
			overridePendingTransition(R.anim.slide_in_right, R.anim.fadeout);

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
		overridePendingTransition(0, R.anim.slide_out_right);
	}
}
