package com.revenuedepartment.app;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datamodels.M_ObjCheck;
import com.revenuedepartment.datamodels.M_Validate;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.function.ConvertDpToPx;
import com.revenuedepartment.function.FillingValidate;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.SavedInstance;

public class FillingStep2 extends Activity {

	LinearLayout lbContent;

	List<M_ObjCheck> objCheck = new ArrayList<M_ObjCheck>();

	Bundle mValue;

	PopupDialog popupDialog = new PopupDialog(FillingStep2.this);

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		P_Filling pFilling = (P_Filling) SavedInstance.map.get(SavedInstance.FILLING);

		drawForm(pFilling.getForms()[1]);

		mValue = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);
	}

	void setView() {
		setContentView(R.layout.filling);
		lbContent = (LinearLayout) findViewById(R.id.lbContent);
	}

	public void drawForm(M_Forms forms) {
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

					LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
							LinearLayout.LayoutParams.WRAP_CONTENT);
					layoutParams.setMargins(0, (int) ConvertDpToPx.convert(20, FillingStep2.this), 0, 0);

					TextViewCustom tx = new TextViewCustom(this);
					tx.setText(fields.getLabel());
					tx.setSize(14);
					tx.setBold();
					layout.addView(tx, layoutParams);

					LinearLayout.LayoutParams layoutParamset = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
							LinearLayout.LayoutParams.WRAP_CONTENT);
					layoutParamset.setMargins(0, (int) ConvertDpToPx.convert(7, FillingStep2.this), 0, 0);

					final EditTextCustom et = new EditTextCustom(this);
					et.setSize(14);

					et.setMessageHint(fields.getPlaceholder());
					if (fields.getFormat().equals("xxxxxxxxxxxxx")) {
						etTemp = et;
						etTemp.addTextChangedListener(etNidFormat);
						et.setFormat(fields.getFormat());

					} else if (fields.getFormat().equals("decimal")) {
						et.setFormat(fields.getFormat());
						// et.addTextChangedListener(new TextWatcher() {
						//
						// @Override
						// public void onTextChanged(CharSequence s, int start,
						// int before, int count) {
						// String text = et.getText().toString();
						// int textlength = et.getText().length();
						//
						// if (text.endsWith(","))
						// return;
						//
						// if (text.indexOf(".") == 1)
						// return;
						//
						// if (textlength <= 1)
						// return;
						//
						// if ((textlength % 4) == 0) {
						// et.setText(new
						// StringBuilder(text).insert(text.length() - 3,
						// ",").toString());
						// et.setSelection(et.getText().length());
						// }
						// // if (text.indexOf(".") >= 0) {
						// // et.setMaxLength(textlength + 2);
						// // } else {
						// //
						// // }
						// }
						//
						// @Override
						// public void beforeTextChanged(CharSequence s, int
						// start, int count, int after) {
						// // TODO Auto-generated method stub
						//
						// }
						//
						// @Override
						// public void afterTextChanged(Editable s) {
						// // TODO Auto-generated method stub
						//
						// }
						// });
					} else {
						et.setFormat(fields.getFormat());
					}

					layout.addView(et, layoutParamset);
					objCheck.add(new M_ObjCheck(et, fields));
					layout.setOrientation(LinearLayout.VERTICAL);
					layout.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
				}

				lbContent.addView(layout);
			} else {

			}
		}
		ButtonCustom btNext = new ButtonCustom(this);
		btNext.setText("Next");
		btNext.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				FillingValidate fillingCheck = new FillingValidate(FillingStep2.this);

				for (i = 0; i < objCheck.size(); i++) {
					M_Validate[] valid = objCheck.get(i).fieldvalidate.getValidate();
					if (valid != null && valid.length > 0) {

						for (int j = 0; j < valid.length; j++) {
							if (valid[j].getOperate().equals("not_null")) {
								if (!fillingCheck.checkNotNull(valid[j].getOperate(), objCheck.get(i).edittext.getText().toString())) {
									popupDialog.showMessage(valid[j].getMessage(), new DialogInterface.OnClickListener() {

										@Override
										public void onClick(DialogInterface dialog, int which) {
											objCheck.get(i).edittext.requestFocus();
										}
									});
									return;
								} else {
									mValue.putString(objCheck.get(i).fieldvalidate.getIdentify(), objCheck.get(i).edittext.getText().toString());
								}
							} else if (valid[j].getOperate().equals(">=") || valid[j].getOperate().equals("<=")) {
								if (valid[j].getV1() != null && valid[j].getV2() != null) {
									if (valid[j].getV2()[0].getIdentify().equals("")) {
										if (!fillingCheck.check(valid[j].getOperate(), objCheck.get(i).edittext.getText().toString(),
												valid[j].getV2()[0].getValue())) {
											popupDialog.showMessage(valid[j].getMessage(), new DialogInterface.OnClickListener() {

												@Override
												public void onClick(DialogInterface dialog, int which) {
													objCheck.get(i).edittext.requestFocus();
												}
											});
											return;
										} else {
											mValue.putString(objCheck.get(i).fieldvalidate.getIdentify(), objCheck.get(i).edittext.getText()
													.toString());
										}
									} else {
										if (!fillingCheck.check(valid[j].getOperate(), objCheck.get(i).edittext.getText().toString(),
												mValue.getString(valid[j].getV2()[0].getIdentify()))) {
											popupDialog.showMessage(valid[j].getMessage(), new DialogInterface.OnClickListener() {

												public void onClick(DialogInterface dialog, int which) {
													objCheck.get(i).edittext.requestFocus();
												}
											});
											return;
										} else {
											mValue.putString(objCheck.get(i).fieldvalidate.getIdentify(), objCheck.get(i).edittext.getText()
													.toString());
										}
									}
								}
							}
						}
					}
				}

				SavedInstance.map.put(SavedInstance.VALUE, mValue);
				Intent intent = new Intent(FillingStep2.this, FillingStep3.class);
				startActivityForResult(intent, 0);
			}
		});
		lbContent.addView(btNext);
	}

	int i = 0;
	// TextWatch is watch for make the validate for EditText, control how to key
	// in EditText
	EditTextCustom etTemp;
	int prevCursor = 0;
	TextWatcher etNidFormat = new TextWatcher() {
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			// if (s.equals("0") || s.equals("1") || s.equals("2") ||
			// s.equals("3") || s.equals("4") || s.equals("5") || s.equals("6")
			// || s.equals("7")
			// || s.equals("8") || s.equals("9")) {
			// }

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

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == MainEFilling.RESULT_CLOSE) {
			setResult(MainEFilling.RESULT_CLOSE);
			finish();
		}
	}

}
