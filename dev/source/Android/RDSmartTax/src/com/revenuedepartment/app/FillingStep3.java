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
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_Conditions;
import com.revenuedepartment.datamodels.M_DepenOnFields;
import com.revenuedepartment.datamodels.M_DependOn;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datamodels.M_Hidden;
import com.revenuedepartment.datamodels.M_ObjCheck;
import com.revenuedepartment.datamodels.M_Summary;
import com.revenuedepartment.datamodels.M_Validate;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.function.FillingValidate;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.SavedInstance;

public class FillingStep3 extends Activity {

	LinearLayout lbContent;

	List<M_ObjCheck> objCheck = new ArrayList<M_ObjCheck>();
	List<M_Hidden> objStatic = new ArrayList<M_Hidden>();

	Bundle mValue;

	PopupDialog popupDialog = new PopupDialog(FillingStep3.this);

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		P_Filling pFilling = (P_Filling) SavedInstance.map.get(SavedInstance.FILLING);
		drawForm(pFilling.getForms()[2], false);
		drawForm(pFilling.getForms()[3], true);
	}

	public void setView() {
		setContentView(R.layout.filling);
		lbContent = (LinearLayout) findViewById(R.id.lbContent);
		mValue = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);
	}

	public void drawForm(M_Forms forms, Boolean addButton) {
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
							writeLog.LogE("log size condition", "::: " + fields.getCondition().length);
							M_Conditions conditions = fields.getCondition()[j];
							if (conditions.getVlaues() != null) {
								for (int k = 0; k < conditions.getVlaues().length; k++) {
									// if (!conditions.getIdentify().equals(""))
									// {
									writeLog.LogE("log size identify", "::: " + mValue.getString(conditions.getIdentify()));
									writeLog.LogE("log size value", "::: " + conditions.getVlaues()[k]);
									if (mValue.getString(conditions.getIdentify()).equals(conditions.getVlaues()[k])) {
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
										objCheck.add(new M_ObjCheck(et, fields));
										layout.setOrientation(LinearLayout.VERTICAL);
										layout.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
										break;
									}
									// }
								}
							} else {

							}
						}
					}
				}
				if (fields.getType().equals(ConfigApp.typestatic)) {
					if (fields.getDependOn() != null) {
						for (int j = 0; j < fields.getDependOn().length; j++) {
							if (fields.getDependOn()[j].getIdentify() != null) {
								if (fields.getDependOn()[j].getOperate() != null) {
									if (fields.getDependOn()[j].getOperate().equals("not_null")) {
										if (mValue.getString(fields.getDependOn()[j].getIdentify()) != null
												&& !mValue.getString(fields.getDependOn()[j].getIdentify()).equals("")) {
											M_DependOn depenOn = fields.getDependOn()[j];
											for (int k = 0; k < depenOn.getFields().length; k++) {
												M_Summary[] summary = depenOn.getFields()[k].getSummary();
												mValue.putString(depenOn.getFields()[k].getIdentify(), summary[0].getValue());
											}
										}
									}
								}
							}
						}
					}
				}
				lbContent.addView(layout);
			} else {

				try {
					if (mValue.getString(fields.getIdentify()) == null || mValue.getString(fields.getIdentify()).equals("null"))
						mValue.putString(fields.getIdentify(), "");
				} catch (Exception e) {
					e.printStackTrace();
				}
				objStatic.add(new M_Hidden(fields.getType(), fields));
			}
		}
		ButtonCustom btNext = new ButtonCustom(this);
		btNext.setText("Next");
		btNext.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				FillingValidate fillingCheck = new FillingValidate(FillingStep3.this);
				i = 0;
				for (i = 0; i < objCheck.size(); i++) {
					try {
						if (mValue.getString(objCheck.get(i).fieldvalidate.getIdentify()) == null
								|| mValue.getString(objCheck.get(i).fieldvalidate.getIdentify()).equals("null"))
							mValue.putString(objCheck.get(i).fieldvalidate.getIdentify(), objCheck.get(i).edittext.getText().toString());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				for (i = 0; i < objCheck.size(); i++) {

					M_Validate[] valid = objCheck.get(i).fieldvalidate.getValidate();

					if (valid != null && valid.length > 0) {

						try {
							mValue.putString(objCheck.get(i).fieldvalidate.getIdentify(), objCheck.get(i).edittext.getText().toString());
						} catch (Exception e) {
							e.printStackTrace();
						}
						for (int j = 0; j < valid.length; j++) {

							for (int k = 0; k < objStatic.size(); k++) {
								M_Summary[] summary = objStatic.get(k).fieldvalidate.getSummary();
								if (summary != null && summary.length > 0) {
									double valueSum = 0;
									for (int l = 0; l < summary.length; l++) {
										try {
											if (mValue.getString(summary[l].getIdentify()) == null
													|| mValue.getString(summary[l].getIdentify()).equals("null")
													|| mValue.getString(summary[l].getIdentify()).equals("")) {
												mValue.putString(summary[l].getIdentify(), "0");
											}
											if (summary[l].getMaximum() == null) {
												if (summary[l].getValue().equals("+")) {
													valueSum = valueSum + Integer.parseInt(mValue.getString(summary[l].getIdentify()));
												} else if (summary[l].getValue().equals("-")) {
													valueSum = valueSum - Integer.parseInt(mValue.getString(summary[l].getIdentify()));
												} else if (summary[l].getValue().startsWith("*")) {
													valueSum = fillingCheck.plusValue(Double.parseDouble(mValue.getString(summary[l].getIdentify())),
															summary[l].getValue());
												}
											} else {
												double value1 = Double.parseDouble(mValue.getString(summary[l].getIdentify()));

												if (summary[l].getValue() != null) {
													value1 = fillingCheck.plusValue(value1, summary[l].getValue());
												}
												double vlaue2 = Double.parseDouble((summary[l].getMaximum()[0].getValue()));
												if (!summary[l].getMaximum()[0].getIdentify().equals("")) {
													vlaue2 = fillingCheck.plusValue(
															Double.parseDouble(mValue.getString(summary[l].getMaximum()[0].getIdentify())),
															summary[l].getValue());
												}
												if (value1 >= vlaue2) {
													valueSum = vlaue2;
												} else {
													valueSum = value1;
												}
											}
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
									writeLog.LogE(objStatic.get(k).fieldvalidate.getIdentify(), String.valueOf(valueSum));
									mValue.putString(objStatic.get(k).fieldvalidate.getIdentify(), String.valueOf(valueSum));
								}
							}

							if (valid[j].getOperate().equals("not_null")) {
								if (!fillingCheck.checkNotNull(valid[j].getOperate(), mValue.getString(objCheck.get(i).fieldvalidate.getIdentify()))) {
									popupDialog.showMessage(valid[j].getMessage() + String.valueOf(objCheck.get(i).fieldvalidate.getIdentify()),
											new DialogInterface.OnClickListener() {

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

										writeLog.LogE("check", String.valueOf(j) + " :: " + mValue.getString(valid[j].getV1()[0].getIdentify())
												+ valid[j].getOperate() + valid[j].getV2()[0].getValue() + " :: " + valid[j].getMessage());
										if (!fillingCheck.check(valid[j].getOperate(), mValue.getString(valid[j].getV1()[0].getIdentify()),
												valid[j].getV2()[0].getValue())) {
											popupDialog.showMessage(
													valid[j].getMessage() + String.valueOf(objCheck.get(i).fieldvalidate.getIdentify()),
													new DialogInterface.OnClickListener() {

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

										writeLog.LogE("check", String.valueOf(j) + " :: " + valid[j].getV1()[0].getIdentify() + valid[j].getOperate()
												+ mValue.getString(valid[j].getV2()[0].getIdentify()) + valid[j].getV2()[0].getValue() + " :: "
												+ valid[j].getMessage());
										if (!fillingCheck.check(valid[j].getOperate(), mValue.getString(valid[j].getV1()[0].getIdentify()),
												mValue.getString(valid[j].getV2()[0].getIdentify()), valid[j].getV2()[0].getValue())) {
											popupDialog.showMessage(
													valid[j].getMessage() + String.valueOf(objCheck.get(i).fieldvalidate.getIdentify()),
													new DialogInterface.OnClickListener() {

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
									}
								}
							}
						}
					}
				}
				SavedInstance.map.put(SavedInstance.VALUE, mValue);
				Intent intent = new Intent(FillingStep3.this, ResultTax.class);
				startActivityForResult(intent, 0);
			}
		});
		if (addButton)
			lbContent.addView(btNext);
	}

	int i = 0;

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
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == MainEFilling.RESULT_CLOSE) {
			setResult(MainEFilling.RESULT_CLOSE);
			finish();
		}
	}
}
