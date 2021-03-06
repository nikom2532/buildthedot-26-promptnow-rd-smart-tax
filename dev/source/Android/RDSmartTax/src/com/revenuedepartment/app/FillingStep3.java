package com.revenuedepartment.app;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_Conditions;
import com.revenuedepartment.datamodels.M_DependOn;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datamodels.M_Hidden;
import com.revenuedepartment.datamodels.M_ObjCheck;
import com.revenuedepartment.datamodels.M_Summary;
import com.revenuedepartment.datamodels.M_Validate;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.function.ConvertDpToPx;
import com.revenuedepartment.function.FillingValidate;
import com.revenuedepartment.function.GetSizeDisplay;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.SavedInstance;

public class FillingStep3 extends Activity {

	TopBar topBar;
	LinearLayout lbContent;

	List<M_ObjCheck> objCheck = new ArrayList<M_ObjCheck>();
	List<M_Hidden> objStatic = new ArrayList<M_Hidden>();

	Bundle mValue;
	Bundle mValueTemp;

	PopupDialog popupDialog = new PopupDialog(FillingStep3.this);

	boolean isAddValue = false;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		P_Filling pFilling = (P_Filling) SavedInstance.map.get(SavedInstance.FILLING);
		for(int index=0; index<pFilling.getForms().length; index++){
			Log.i("FillingStep3", "pFilling.getForms()["+index+"] : "+pFilling.getForms()[index].getFormName());	
		}
		mValueTemp = (Bundle) SavedInstance.map.get(SavedInstance.TMEP_VALUE);
		if (mValueTemp == null) {
			mValueTemp = new Bundle();
		}

		drawForm(pFilling.getForms()[1], false);
		drawForm(pFilling.getForms()[2], true);
	}

//	List<ImageView> steps = new ArrayList<ImageView>();
//	private void setDynamicNavigate(int currentNavigate) {
//		ImageView step0 = (ImageView) findViewById(R.id.step0);
//		ImageView step1 = (ImageView) findViewById(R.id.step1);
//		ImageView step2 = (ImageView) findViewById(R.id.step2);
//		ImageView step3 = (ImageView) findViewById(R.id.step3);
//		steps.add(step0);
//		steps.add(step1);
//		steps.add(step2);
//		steps.add(step3);
//		for(int index=0; index<steps.size(); index++){
//			if(index==currentNavigate){
//				steps.get(index).setImageResource(R.drawable.icon_current_status);
//			}else {
//				steps.get(index).setImageResource(R.drawable.icon_status);
//			}
//		}
//	}
	public void setView() {
		setContentView(R.layout.filling);
		
		NavigatorDynamic.setDynamicNavigate(this, 2);
		lbContent = (LinearLayout) findViewById(R.id.lbContent);
		mValue = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_efilling));
		topBar.clickBack(new OnClickListener() {

			@Override
			public void onClick(View v) {
				for (i = 0; i < objCheck.size(); i++) {
					mValueTemp.putString(objCheck.get(i).fieldvalidate.getIdentify(), objCheck.get(i).edittext.getText().toString());
				}
				SavedInstance.map.put(SavedInstance.TMEP_VALUE, mValueTemp);
				finish();
				overridePendingTransition(0, 0);
			}
		});
	}

	public void drawForm(M_Forms forms, Boolean addButton) {

		LinearLayout.LayoutParams layoutParamsLabel = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT);
		layoutParamsLabel.setMargins((int) ConvertDpToPx.convert(20, FillingStep3.this), (int) ConvertDpToPx.convert(10, FillingStep3.this), 0, 0);
		TextViewCustom txText = new TextViewCustom(this);
		Log.i("FillingStep3", "form : "+forms); 
		if(forms!=null){
			Log.i("FillingStep3", "form name : "+forms.getFormName());
			txText.setText(forms.getFormName());
			txText.setSize(20);
			txText.setTextSize(ConfigApp.size_font_topic);
			lbContent.addView(txText, layoutParamsLabel); 
		
		

			for (int i = 0; i < forms.getFormData().getFields().length; i++) {
				isAddValue = true;
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
	
					if (fields.getType().equals(ConfigApp.textField) || fields.getType().equals(ConfigApp.typestatic)) {
						if (fields.getCondition() != null) {
							for (int j = 0; j < fields.getCondition().length; j++) {
								isAddValue = false;
								M_Conditions conditions = fields.getCondition()[j];
								if (conditions.getVlaues() != null) {
	
									for (int k = 0; k < conditions.getVlaues().length; k++) {
										isAddValue = false;
										try {
											if (mValue.getString(conditions.getIdentify()).equals(conditions.getVlaues()[k])) {
	
												LinearLayout.LayoutParams layoutParamset = new LinearLayout.LayoutParams(
														LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
												layoutParamset.setMargins((int) ConvertDpToPx.convert(20, FillingStep3.this),
														(int) ConvertDpToPx.convert(7, FillingStep3.this),
														(int) ConvertDpToPx.convert(20, FillingStep3.this),
														(int) ConvertDpToPx.convert(5, FillingStep3.this));
	
												LinearLayout.LayoutParams layoutEdittext = new LinearLayout.LayoutParams(
														LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
												layoutEdittext.setMargins((int) ConvertDpToPx.convert(20, FillingStep3.this),
														(int) ConvertDpToPx.convert(7, FillingStep3.this),
														(int) ConvertDpToPx.convert(20, FillingStep3.this),
														(int) ConvertDpToPx.convert(10, FillingStep3.this));
	
												LinearLayout layoutSub = new LinearLayout(this);
												TextViewCustom tx = new TextViewCustom(this);
												tx.setText(fields.getLabel());
												tx.setTextSize(ConfigApp.size_font_label);
												int temp = (int) GetSizeDisplay.getDisplayWidth(FillingStep3.this)
														- (int) ConvertDpToPx.convert(70, FillingStep3.this);
												layoutSub.addView(tx, temp, LayoutParams.WRAP_CONTENT);
												layoutSub.setLayoutParams(layoutParamset);
	
												ImageView ivHint = new ImageView(this);
												ivHint.setImageResource(R.drawable.icon_hint);
												LinearLayout.LayoutParams paramstHint = new LinearLayout.LayoutParams(
														LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
												LinearLayout layoutHint = new LinearLayout(this);
												layoutHint.setLayoutParams(paramstHint);
												layoutHint.setGravity(Gravity.RIGHT);
												layoutHint.addView(ivHint);
												layoutSub.addView(layoutHint);
	
												EditTextCustom et = new EditTextCustom(this);
												et.setTextSize(ConfigApp.size_font_edittext);
	
												if (fields.getType().equals(ConfigApp.typestatic)) {
													et.setText(mValue.getString(fields.getSummary()[0].getIdentify()));
													et.setEnabled(false);
													et.setBackgroundResource(0);
												} else {
													et.setMessageHint(fields.getPlaceholder());
													try {
														et.setText(mValueTemp.getString(fields.getIdentify()));
													} catch (Exception e) {
													}
												}
	
												if (fields.getFormat().equals("xxxxxxxxxxxxx")) {
													etTemp = et;
													etTemp.addTextChangedListener(etNidFormat);
													et.setFormat(fields.getFormat());
												} else {
													et.setFormat(fields.getFormat());
												}
	
												layout.addView(layoutSub, layoutParamset);
												layout.addView(et, layoutEdittext);
												objCheck.add(new M_ObjCheck(et, fields));
												layout.setOrientation(LinearLayout.VERTICAL);
												layout.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
												isAddValue = true;
												break;
											}
										} catch (Exception e) {
											e.printStackTrace();
										}
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
					if (isAddValue) {
						View line = new View(this);
						line.setBackgroundResource(R.drawable.bg_list_line);
						lbContent.addView(line);
					}
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
		}
		ButtonCustom btNext = new ButtonCustom(this);
		LinearLayout.LayoutParams paramsButton = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT);
		paramsButton.setMargins((int) ConvertDpToPx.convert(20, FillingStep3.this), (int) ConvertDpToPx.convert(10, FillingStep3.this),
				(int) ConvertDpToPx.convert(20, FillingStep3.this), (int) ConvertDpToPx.convert(10, FillingStep3.this));
		btNext.setLayoutParams(paramsButton);
		btNext.setTextChangeLanguage(getString(R.string.label_next));
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
