package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_Conditions;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.SavedInstance;

public class FillingStep4 extends Activity {

	LinearLayout lbContent;
	Bundle mValue;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		P_Filling pFilling = (P_Filling) SavedInstance.map.get(SavedInstance.FILLING);
		drawForm(pFilling.getForms()[3]);
	}

	void setView() {
		setContentView(R.layout.filling);
		lbContent = (LinearLayout) findViewById(R.id.lbContent);
		mValue = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);
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

				if (fields.getType().equals(ConfigApp.checkBox)) {
					CheckBox checkBox = new CheckBox(this);
					layout.addView(checkBox);

					TextViewCustom tx = new TextViewCustom(this);
					tx.setText(fields.getLabel());
					tx.setSize(14);
					layout.addView(tx);

					layout.setOrientation(LinearLayout.HORIZONTAL);
					layout.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
				}

				if (fields.getType().equals(ConfigApp.textField)) {
					if (fields.getCondition() != null) {
						for (int j = 0; j < fields.getCondition().length; j++) {
							M_Conditions conditions = fields.getCondition()[j];
							try {

								if (mValue.getString(conditions.getIdentify()).equals(conditions.getVlaues()[0])) {
									writeLog.LogI(writeLog.TAG, mValue.getString(conditions.getIdentify()));
									TextViewCustom tx = new TextViewCustom(this);
									tx.setText(fields.getLabel());
									tx.setSize(14);
									layout.addView(tx);

									EditTextCustom et = new EditTextCustom(this);
									et.setSize(14);

									et.setMessageHint(fields.getPlaceholder());
									if (fields.getFormat().equals("xxxxxxxxxxxxx")) {
										etTemp = et;
										etTemp.addTextChangedListener(etNidFormat);
										et.setFormat(fields.getFormat());
									} else {
										et.setFormat(fields.getFormat());
									}

									layout.addView(et, new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));

									layout.setOrientation(LinearLayout.VERTICAL);
									layout.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
								}
							} catch (Exception e) {
								// TODO: handle exception

							}
						}
					}
				}

				lbContent.addView(layout);
			}
		}
		Button btNext = new Button(this);
		btNext.setText("Next");
		btNext.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(FillingStep4.this, ResultTax.class);
				startActivityForResult(intent, 0);
			}
		});

		lbContent.addView(btNext);
	}

	// TextWatch is watch for make the validate for EditText, control how to key
	// in EditText
	EditText etTemp;
	int prevCursor = 0;
	TextWatcher etNidFormat = new TextWatcher() {
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			String text = etTemp.getText().toString();
			// writeLog.LogV("onTextChanged", "etNidFormat");
			if (prevCursor <= 1) {
				if (text.length() == 1) {
					String newtext = etTemp.getText().toString() + "-";
					etTemp.setText("");
					etTemp.append(newtext);
				}
			} else if (prevCursor <= 6) {
				if (text.length() == 6) {
					String newtext = etTemp.getText().toString() + "-";
					etTemp.setText("");
					etTemp.append(newtext);
				}
			} else if (prevCursor <= 12) {
				if (text.length() == 12) {
					String newtext = etTemp.getText().toString() + "-";
					etTemp.setText("");
					etTemp.append(newtext);
				}
			} else if (prevCursor <= 15) {
				if (text.length() == 15) {
					String newtext = etTemp.getText().toString() + "-";
					etTemp.setText("");
					etTemp.append(newtext);
				}
			}

			etTemp.requestFocus();
			prevCursor = text.length();
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {

		}

		@Override
		public void afterTextChanged(Editable s) {

		}
	};
}
