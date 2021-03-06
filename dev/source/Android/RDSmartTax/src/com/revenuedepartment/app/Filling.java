package com.revenuedepartment.app;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.google.gson.Gson;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.model.CommonResponseRD;
import com.promptnow.network.model.lgauthen.AuthenResponse;
import com.promptnow.network.model.lgchecknewuser.CheckNewUserResponse;
import com.promptnow.network.service.AsyncTaskCompleteListener;
import com.promptnow.network.service.ServiceAsyn;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datamodels.M_Conditions;
import com.revenuedepartment.datamodels.M_DepenOnFields;
import com.revenuedepartment.datamodels.M_DependOn;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datamodels.M_Hidden;
import com.revenuedepartment.datamodels.M_ObjCheck;
import com.revenuedepartment.datamodels.M_Summary;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.function.ConvertDpToPx;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.FillingValidate;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.GetSizeDisplay;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.req_datamodels.MRequest_Filling;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.GetPnd91;
import com.revenuedepartment.service.JSONElement;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.SharedPref;
import com.revenuedepartment.service.checkOnline;

public class Filling extends Activity implements AsyncTaskCompleteListener {

	LinearLayout lbContent;
	Bundle mValue = new Bundle();
	List<M_ObjCheck> objCheck = new ArrayList<M_ObjCheck>();
	List<M_Hidden> objStatic = new ArrayList<M_Hidden>();
	boolean isAddLine = false;
	TopBar topbar;

	Bundle mValueTemp;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();

		mValue = (Bundle) SavedInstance.map.get(SavedInstance.VALUE);

		if (mValueTemp == null) {
			mValueTemp = new Bundle();
		}

		if (!checkOnline.check(Filling.this)) {
			new PopupDialog(Filling.this).show("", getString(R.string.alert_no_network));
		} else {
//			new getPnd91().execute(); 
			MRequest_Filling request  = new MRequest_Filling();
			request.nid = mValue.getString(JSONElement.nid);
			request.authenKey = mValue.getString(JSONElement.authenKey);
			request.deviceID = new GetDeviceID(Filling.this).getDeviceID();
			request.sessionID = PromptnowCommandData.JSESSIONID;
			callService("fl-get-formpnd91", request);
		}
	}

	
	
	void setView() {
		setContentView(R.layout.filling);
		lbContent = (LinearLayout) findViewById(R.id.lbContent);
		topbar = (TopBar) findViewById(R.id.Topbar);
		topbar.setTitle(getString(R.string.label_efilling));
		
		
		NavigatorDynamic.setDynamicNavigate(this, 0);
		
		topbar.clickBack(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Log.i("Filling", "objCheck : "+objCheck.size());
				for (int i = 0; i < objCheck.size(); i++) {
					Log.i("Filling", "checkbox is checked : "+objCheck.get(i).checkbox.isChecked());
					if (objCheck.get(i).checkbox.isChecked()) { 
						if (objCheck.get(i).fieldvalidate == null) {
							writeLog.LogE("identify", objCheck.get(i).fieldsDependOn.getIdentify());
							mValueTemp.putString(objCheck.get(i).fieldsDependOn.getIdentify(), "1");
						} else {
							mValueTemp.putString(objCheck.get(i).fieldvalidate.getIdentify(), "1");
						}

					} else {

						if (objCheck.get(i).fieldvalidate == null) {
							mValueTemp.putString(objCheck.get(i).fieldsDependOn.getIdentify(), "0");
						} else {
							mValueTemp.putString(objCheck.get(i).fieldvalidate.getIdentify(), "0");
						}
					}
				}

				SavedInstance.map.put(SavedInstance.TMEP_VALUE, mValueTemp);
				finish();
			}
		});
	}

	private void callService(String service, Object request) { 
			Gson g = new Gson(); 
			String json = g.toJson(request); 
			new ServiceAsyn(this, json, service).execute();  
	} 
	
	PopupDialog popup = new PopupDialog(Filling.this);
	@Override
	public void onTaskComplete(String result, String service) {
		Log.i("response", "response : "+result); 
		try { 
			Gson g = new Gson(); 
			JSONObject jsonObject = new JSONObject(result); 
			Log.i("response", "service : "+service);
			if(service.equals("fl-get-formpnd91")){ 
				P_Filling response = g.fromJson(result, P_Filling.class);
				GetPnd91 pnd91 = new GetPnd91(); 
				response = pnd91.getPnd91(result);		// for put forms filing
				if (response.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
					mValueTemp = (Bundle) SavedInstance.map.get(SavedInstance.TMEP_VALUE);
					if (mValueTemp == null) {
						mValueTemp = new Bundle();
					}
					drawForm(response.getForms()[0]);
					SavedInstance.map.put(SavedInstance.FILLING, response);
				} else {
					popup.show(response.responseMessage);
				}
			}  
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NullPointerException e) {
			e.printStackTrace();
		} 
	} 

	FillingValidate fillingCheck = new FillingValidate(Filling.this);

	private void drawForm(M_Forms forms) {
		LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT);
		layoutParams.setMargins((int) ConvertDpToPx.convert(20, Filling.this), (int) ConvertDpToPx.convert(10, Filling.this),
				(int) ConvertDpToPx.convert(20, Filling.this), (int) ConvertDpToPx.convert(10, Filling.this));

		TextViewCustom txText = new TextViewCustom(this);
		txText.setText(forms.getFormName());
		txText.setTextSize(ConfigApp.size_font_topic);
		lbContent.addView(txText, layoutParams);

		for (int i = 0; i < forms.getFormData().getFields().length; i++) {
			isAddLine = false;
			M_Fields fields = forms.getFormData().getFields()[i];
			if (fields.getHidden().equals("")) {
				LinearLayout layout = new LinearLayout(this);
				if (fields.getType().equals(ConfigApp.dropdown)) {

					if (fields.getCondition() != null) {
						for (int j = 0; j < fields.getCondition().length; j++) {
							M_Conditions conditions = fields.getCondition()[j];
							if (conditions.getOperate() != null) {
								if (conditions.getV1() != null) {
									if (!fillingCheck.check(conditions.getOperate(), mValue.getString(conditions.getIdentify()),
											conditions.getV2()[0].getValue())) {
										mValue.putString(fields.getIdentify(), "");
									} else {
										mValue.putString(fields.getIdentify(), "1");
									}
								}
							}
						}

					}
					if (fields.getDependOn() != null) {
						for (int j = 0; j < fields.getDependOn().length; j++) {
							M_DependOn dependOn = fields.getDependOn()[j];
							LinearLayout.LayoutParams layoutParams_sub = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
									LinearLayout.LayoutParams.WRAP_CONTENT);
							layoutParams_sub.setMargins((int) ConvertDpToPx.convert(20, Filling.this), (int) ConvertDpToPx.convert(20, Filling.this),
									0, 0);
							TextViewCustom txBar = new TextViewCustom(this);
							txBar.setText(fields.getLabel());
							// txBar.setBackgroundColor(getResources().getColor(R.color.color_white));
							txBar.setTextSize(ConfigApp.size_font_label);
							layout.addView(txBar, new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
							layout.setOrientation(LinearLayout.HORIZONTAL);
							layout.setLayoutParams(layoutParams_sub);

							// No check conditions
							for (int k = 0; k < dependOn.getFields().length; k++) {
								if (dependOn.getFields()[k].getType().equals(ConfigApp.checkBox1)) {
									boolean isDisplay = false;
									M_DepenOnFields mDepenOnFields = dependOn.getFields()[k];
									if (mDepenOnFields.getConditions() != null) {
										for (int x = 0; x < mDepenOnFields.getConditions().length; x++) {
											M_Conditions conditions = mDepenOnFields.getConditions()[x];
											if (conditions.getIdentify() != null && !conditions.getIdentify().equals("")) {
												if (conditions.getOperate() != null) {
													if (conditions.getOperate().equals("equal")) {
														if (conditions.getVlaues() != null) {
															for (int y = 0; y < conditions.getVlaues().length; y++) {
//																Log.i("Filling", "mValue : "+mValue);
																if(mValueHasString(conditions, y)){
																	if (mValue.getString(conditions.getIdentify()).equals(conditions.getVlaues()[y])) {
																		isDisplay = true;
																	} else {
																		isDisplay = false;
																		break;
																	}
																}else{
																	isDisplay = false;
																	break;
																}
															}
														}
													} else if (conditions.getOperate().equals("not_null")) {
														if (mValue.getString(conditions.getIdentify()) != null
																&& !mValue.getString(conditions.getIdentify()).equals("")) {
															isDisplay = true;
														} else {
															isDisplay = false;
															break;
														}
													}
												}
											}
											if (!isDisplay) {
												break;
											}
										}
									}
									if (isDisplay) {
										LinearLayout layoutSub = new LinearLayout(this);
										TextViewCustom tx = new TextViewCustom(this);
										tx.setText(mDepenOnFields.getLabel());
										tx.setTextSize(ConfigApp.size_font_label);
										int temp = GetSizeDisplay.getDisplayWidth(Filling.this) / 4;
										temp = (int) (temp * 3);
										LinearLayout.LayoutParams layoutParams1 = new LinearLayout.LayoutParams(
												LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
										layoutParams1.setMargins(30, (int) ConvertDpToPx.convert(20, Filling.this), 0, 0);
										layoutSub.addView(tx, temp, LayoutParams.WRAP_CONTENT);

										CheckBox checkBox = new CheckBox(this);
										checkBox.setButtonDrawable(R.drawable.bg_checkbox);
										LinearLayout.LayoutParams paramstHint = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
												LinearLayout.LayoutParams.WRAP_CONTENT);
										LinearLayout layoutCheckBox = new LinearLayout(this);
										layoutCheckBox.setLayoutParams(paramstHint);
										// layoutCheckBox.setGravity(Gravity.RIGHT);
										layoutCheckBox.addView(checkBox, GetSizeDisplay.getDisplayWidth(Filling.this) - temp,
												LayoutParams.WRAP_CONTENT);
										layoutSub.addView(layoutCheckBox);

										layoutSub.setOrientation(LinearLayout.HORIZONTAL);
										layoutSub.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));

										layout.setOrientation(LinearLayout.VERTICAL);
										layout.addView(layoutSub, layoutParams1);
										objCheck.add(new M_ObjCheck(checkBox, null, mDepenOnFields));
										isAddLine = true;
									}
								}
							}
						}
					}
				} else if (fields.getType().equals(ConfigApp.checkBox)) {

					TextViewCustom tx = new TextViewCustom(Filling.this);
					tx.setSingleLine(true);
					tx.setText(fields.getLabel());
					tx.setTextSize(ConfigApp.size_font_label);

					// tx.setMaxLines(1);
					int temp = GetSizeDisplay.getDisplayWidth(Filling.this) / 4;
					temp = (int) (temp * 3);
					layout.addView(tx, temp, LayoutParams.WRAP_CONTENT);
					CheckBox checkBox = new CheckBox(this);
					checkBox.setButtonDrawable(R.drawable.bg_checkbox);
					layout.addView(checkBox, GetSizeDisplay.getDisplayWidth(Filling.this) - temp, LayoutParams.WRAP_CONTENT);

					layout.setOrientation(LinearLayout.HORIZONTAL);
					layout.setLayoutParams(layoutParams);
					objCheck.add(new M_ObjCheck(checkBox, fields, null));
					isAddLine = true;
				}
				lbContent.addView(layout);
				if (isAddLine) {
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

				for (int k = 0; k < objStatic.size(); k++) {
					M_Summary[] summary = objStatic.get(k).fieldvalidate.getSummary();
					if (summary != null && summary.length > 0) {
						double valueSum = 0;
						for (int l = 0; l < summary.length; l++) {
							try {
								if (mValue.getString(summary[l].getIdentify()) == null || mValue.getString(summary[l].getIdentify()).equals("null")
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
										vlaue2 = fillingCheck
												.plusValue(Double.parseDouble(mValue.getString(summary[l].getMaximum()[0].getIdentify())),
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
			}
		}

		ButtonCustom btNext = new ButtonCustom(this);
		LinearLayout.LayoutParams paramsButton = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT);
		paramsButton.setMargins((int) ConvertDpToPx.convert(20, Filling.this), (int) ConvertDpToPx.convert(10, Filling.this),
				(int) ConvertDpToPx.convert(20, Filling.this), (int) ConvertDpToPx.convert(10, Filling.this));
		btNext.setLayoutParams(paramsButton);
		btNext.setTextChangeLanguage(getString(R.string.label_next));
		btNext.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				for (int i = 0; i < objCheck.size(); i++) {
					if (objCheck.get(i).checkbox.isChecked()) {

						if (objCheck.get(i).fieldvalidate == null) {
							writeLog.LogE("identify", objCheck.get(i).fieldsDependOn.getIdentify());
							mValue.putString(objCheck.get(i).fieldsDependOn.getIdentify(), "1");
						} else {
							mValue.putString(objCheck.get(i).fieldvalidate.getIdentify(), "1");
						}

					} else {

						if (objCheck.get(i).fieldvalidate == null) {
							mValue.putString(objCheck.get(i).fieldsDependOn.getIdentify(), "0");
						} else {
							mValue.putString(objCheck.get(i).fieldvalidate.getIdentify(), "0");
						}
					}
				}
				SavedInstance.map.put(SavedInstance.VALUE, mValue);
				Intent intent = new Intent(Filling.this, FillingStep2.class);
				startActivityForResult(intent, 0);
			}
		});
		lbContent.addView(btNext);

		for (int i = 0; i < objCheck.size(); i++) {
			try {
				if (objCheck.get(i).fieldvalidate == null) {
					if (mValueTemp.getString(objCheck.get(i).fieldsDependOn.getIdentify()).equals("1")) {
						objCheck.get(i).checkbox.setChecked(true);
					}
				} else {
					if (mValueTemp.getString(objCheck.get(i).fieldvalidate.getIdentify()).equals("1")) {
						objCheck.get(i).checkbox.setChecked(true);
					}
				}
			} catch (Exception e) {
			}
		}
	}

	private boolean mValueHasString(M_Conditions conditions ,int y) {
		Log.i("Filling", "conditions iden : "+ conditions.getIdentify());
		Log.i("Filling", "conditions value : "+conditions.getVlaues()[y]); 
		Log.i("Filling", "getString iden : "+mValue.getString(conditions.getIdentify()));
//		mValue.getString(conditions.getIdentify()).equals(conditions.getVlaues()[y])
		if(conditions.getIdentify()!=null && conditions.getVlaues()[y]!=null && mValue.getString(conditions.getIdentify())!=null){
			return true;
		}else {
			return false;
		}

		
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode == MainEFilling.RESULT_CLOSE) {
			setResult(MainEFilling.RESULT_CLOSE);
			finish();
		}
	}
 
}
