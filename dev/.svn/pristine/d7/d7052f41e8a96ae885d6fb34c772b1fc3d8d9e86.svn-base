package com.revenuedepartment.app;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datamodels.M_ObjCheck;
import com.revenuedepartment.datamodels.M_Validate;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.function.ConvertDpToPx;
import com.revenuedepartment.function.FillingValidate;
import com.revenuedepartment.function.GetSizeDisplay;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.SavedInstance;

public class FillingStep2 extends Activity {

	LinearLayout lbContent;

	List<M_ObjCheck> objCheck = new ArrayList<M_ObjCheck>();

	Bundle mValue;
	Bundle mValueTemp;

	PopupDialog popupDialog = new PopupDialog(FillingStep2.this);

	boolean isAddLine = false;

	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		P_Filling pFilling = (P_Filling) SavedInstance.map.get(SavedInstance.FILLING);
		mValueTemp = (Bundle) SavedInstance.map.get(SavedInstance.TMEP_VALUE);
		if (mValueTemp == null) {
			mValueTemp = new Bundle();
		}
		
		drawForm(pFilling.getForms()[1]);

	}

	void setView() {
		setContentView(R.layout.filling);
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

	public void drawForm(M_Forms forms) {
		LinearLayout.LayoutParams layoutParamsLabel = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT);
		layoutParamsLabel.setMargins((int) ConvertDpToPx.convert(20, FillingStep2.this), (int) ConvertDpToPx.convert(10, FillingStep2.this), 0, 0);
		TextViewCustom txText = new TextViewCustom(this);
		txText.setText(forms.getFormName());
		txText.setTextSize(ConfigApp.size_font_topic);
		lbContent.addView(txText, layoutParamsLabel);

		for (int i = 0; i < forms.getFormData().getFields().length; i++) {
			isAddLine = false;
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

					LinearLayout.LayoutParams layoutParamset = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
							LinearLayout.LayoutParams.WRAP_CONTENT);
					layoutParamset.setMargins((int) ConvertDpToPx.convert(20, FillingStep2.this), (int) ConvertDpToPx.convert(7, FillingStep2.this),
							(int) ConvertDpToPx.convert(20, FillingStep2.this), (int) ConvertDpToPx.convert(5, FillingStep2.this));

					LinearLayout.LayoutParams layoutEdittext = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
							LinearLayout.LayoutParams.WRAP_CONTENT);
					layoutEdittext.setMargins((int) ConvertDpToPx.convert(20, FillingStep2.this), (int) ConvertDpToPx.convert(5, FillingStep2.this),
							(int) ConvertDpToPx.convert(20, FillingStep2.this), (int) ConvertDpToPx.convert(10, FillingStep2.this));

					LinearLayout layoutSub = new LinearLayout(this);
					TextViewCustom tx = new TextViewCustom(this);
					tx.setText(fields.getLabel());
					tx.setTextSize(ConfigApp.size_font_label);
					int temp = (int) GetSizeDisplay.getDisplayWidth(FillingStep2.this) - (int) ConvertDpToPx.convert(70, FillingStep2.this);
					layoutSub.addView(tx, temp, LayoutParams.WRAP_CONTENT);

					ImageView ivHint = new ImageView(this);
					ivHint.setImageResource(R.drawable.icon_hint);
					LinearLayout.LayoutParams paramstHint = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
							LinearLayout.LayoutParams.WRAP_CONTENT);
					LinearLayout layoutHint = new LinearLayout(this);
					layoutHint.setLayoutParams(paramstHint);
					layoutHint.setGravity(Gravity.RIGHT);
					layoutHint.addView(ivHint);
					layoutSub.addView(layoutHint);

					final EditTextCustom et = new EditTextCustom(this);
					et.setTextSize(ConfigApp.size_font_edittext);
					et.setBackgroundResource(R.drawable.textfield_line);
					et.setMessageHint(fields.getPlaceholder());
				
				

					if (fields.getFormat().equals("xxxxxxxxxxxxx")) {
						etTemp = et;
						// etTemp.addTextChangedListener(etNidFormat);
						et.setFormat(fields.getFormat());

					} else if (fields.getFormat().equals("decimal")) {
						et.setFormat(fields.getFormat());
						// et.addTextChangedListener(new NumberTextWatcher(et));
						et.setGravity(Gravity.RIGHT);
					} else {
						et.setFormat(fields.getFormat());
					}
					try {
						et.setText(mValueTemp.getString(fields.getIdentify()));
					} catch (Exception e) {
					}
					layout.addView(layoutSub, layoutParamset);
					layout.addView(et, layoutEdittext);
					objCheck.add(new M_ObjCheck(et, fields));
					layout.setOrientation(LinearLayout.VERTICAL);
					layout.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
					isAddLine = true;
				}

				lbContent.addView(layout);
				if (isAddLine) {
					View line = new View(this);
					line.setBackgroundResource(R.drawable.bg_list_line);
					lbContent.addView(line);
				}
			} else {

			}
		}
		ButtonCustom btNext = new ButtonCustom(this);
		LinearLayout.LayoutParams paramsButton = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT);
		paramsButton.setMargins((int) ConvertDpToPx.convert(20, FillingStep2.this), (int) ConvertDpToPx.convert(10, FillingStep2.this),
				(int) ConvertDpToPx.convert(20, FillingStep2.this), (int) ConvertDpToPx.convert(10, FillingStep2.this));
		btNext.setLayoutParams(paramsButton);
		btNext.setTextChangeLanguage(getString(R.string.label_next));
		btNext.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				FillingValidate fillingCheck = new FillingValidate(FillingStep2.this);

				for (i = 0; i < objCheck.size(); i++) {
					M_Validate[] valid = objCheck.get(i).fieldvalidate.getValidate();
					mValueTemp.putString(objCheck.get(i).fieldvalidate.getIdentify(), objCheck.get(i).edittext.getText().toString());
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
