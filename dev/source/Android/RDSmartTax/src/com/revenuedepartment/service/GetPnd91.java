package com.revenuedepartment.service;

import java.io.File;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.revenuedepartment.datamodels.M_Conditions;
import com.revenuedepartment.datamodels.M_DepenOnFields;
import com.revenuedepartment.datamodels.M_DependOn;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datamodels.M_FormsData;
import com.revenuedepartment.datamodels.M_Keys;
import com.revenuedepartment.datamodels.M_ObjSummary;
import com.revenuedepartment.datamodels.M_Summary;
import com.revenuedepartment.datamodels.M_Validate;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.function.writeLog;

public class GetPnd91 {

	public P_Filling getPnd91(String responseText) {
		P_Filling pFilling = new P_Filling();
		try {
			JSONObject objBig = new JSONObject(responseText);
			JSONObject obj = null;
			if (hasElement(objBig, JSONElement.responseData)) {
				obj = objBig.getJSONObject(JSONElement.responseData);
				pFilling.setApiRefNo(getJsonString(obj, JSONElement.apiRefNo));

				if (hasElement(obj, JSONElement.keys)) {
					JSONObject objKeys = obj.getJSONObject(JSONElement.keys);
					pFilling.setKeys(getObjKeys(objKeys));
				}

				if (hasElement(obj, JSONElement.forms)) {

					JSONArray formsArr = obj.getJSONArray(JSONElement.forms);
					if (formsArr != null && formsArr.length() > 0) {
						M_Forms[] mFormsArr = new M_Forms[formsArr.length()];
						for (int i = 0; i < formsArr.length(); i++) {
							JSONObject objFormsData = formsArr.getJSONObject(i);
							mFormsArr[i] = new M_Forms();
							mFormsArr[i] = getObjForms(objFormsData);
						}
						pFilling.setForms(mFormsArr);
					}
				}
			}
			return pFilling;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return null;
	}

	private M_Keys getObjKeys(JSONObject obj) {
		M_Keys mKeys = new M_Keys();

		return null;
	}

	private M_Forms getObjForms(JSONObject obj) {
		M_Forms forms = new M_Forms();
		forms.setFormName(getJsonString(obj, JSONElement.formName));

		try {

			JSONArray formDataArr = obj.getJSONArray(JSONElement.formData);
			if (formDataArr != null && formDataArr.length() > 0) {
				M_FormsData formsData = new M_FormsData();
				for (int i = 0; i < formDataArr.length(); i++) {
					JSONObject objFormData = formDataArr.getJSONObject(i);
					formsData.setHeader(getJsonString(objFormData, JSONElement.header));
					JSONArray ojbFielsArr = objFormData.getJSONArray(JSONElement.fields);

					if (ojbFielsArr != null && ojbFielsArr.length() > 0) {
						M_Fields[] mFieldsArr = new M_Fields[ojbFielsArr.length()];
						for (int j = 0; j < ojbFielsArr.length(); j++) {
							JSONObject objFields = ojbFielsArr.getJSONObject(j);
							mFieldsArr[j] = new M_Fields();
							M_Fields fields = new M_Fields();
							fields.setHidden(getJsonString(objFields, JSONElement.hidden));
							fields.setIdentify(getJsonString(objFields, JSONElement.identify));
							fields.setLabel(getJsonString(objFields, JSONElement.label));
							fields.setType(getJsonString(objFields, JSONElement.type));
							fields.setSecure(getJsonString(objFields, JSONElement.secure));
							fields.setKeyboardType(getJsonString(objFields, JSONElement.keyboardType));
							fields.setPlaceholder(getJsonString(objFields, JSONElement.placeholder));
							fields.setFormat(getJsonString(objFields, JSONElement.format));
							mFieldsArr[j] = fields;

							if (hasElement(objFields, JSONElement.conditions)) {
								JSONArray objConditions = objFields.getJSONArray(JSONElement.conditions);
								fields.setCondition(getConditions(objConditions));
							}

							if (hasElement(objFields, JSONElement.summary)) {
								JSONArray objSummaryArr = objFields.getJSONArray(JSONElement.summary);
								fields.setSummary(getObjSummary(objSummaryArr));
							}

							if (hasElement(objFields, JSONElement.dependOn)) {
								JSONArray objDepenOn = objFields.getJSONArray(JSONElement.dependOn);
								fields.setDependOn(getObjDepenOn(objDepenOn));
							}

							if (hasElement(objFields, JSONElement.validate)) {
								JSONArray objValidate = objFields.getJSONArray(JSONElement.validate);
								fields.setValidate(getObjValidate(objValidate));
							}

						}
						formsData.setFields(mFieldsArr);

					}
					forms.setFormData(formsData);
				}

				return forms;
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}

		return null;
	}

	public M_Summary[] getObjSummary(JSONArray obj) {

		if (obj != null && obj.length() > 0) {
			M_Summary[] mSummaryArr = new M_Summary[obj.length()];
			for (int i = 0; i < obj.length(); i++) {
				try {
					JSONObject objSummary = obj.getJSONObject(i);
					mSummaryArr[i] = new M_Summary();
					mSummaryArr[i].setIdentify(getJsonString(objSummary, JSONElement.identify));
					mSummaryArr[i].setValue(getJsonString(objSummary, JSONElement.value));
					if (hasElement(objSummary, JSONElement.maximum)) {
						JSONObject objMaximum = objSummary.getJSONObject(JSONElement.maximum);
						mSummaryArr[i].setMaximum(getObjConSummaryMax(objMaximum));
					}

				} catch (JSONException e) {
					e.printStackTrace();
				}
			}
			return mSummaryArr;
		}
		return null;
	}

	public M_ObjSummary[] getObjConSummary(JSONArray obj) {

		if (obj != null && obj.length() > 0) {
			M_ObjSummary[] mSummaryArr = new M_ObjSummary[obj.length()];
			for (int i = 0; i < obj.length(); i++) {
				try {
					JSONObject objSummary = obj.getJSONObject(i);
					mSummaryArr[i] = new M_ObjSummary();
					mSummaryArr[i].setIdentify(getJsonString(objSummary, JSONElement.identify));
					mSummaryArr[i].setValue(getJsonString(objSummary, JSONElement.value));

				} catch (JSONException e) {
					e.printStackTrace();
				}
			}
			return mSummaryArr;
		}
		return null;
	}

	public M_ObjSummary[] getObjConSummaryMax(JSONObject obj) {

		JSONArray objSummary;
		M_ObjSummary[] rs = null;
		try {
			objSummary = obj.getJSONArray(JSONElement.summary);
			rs = getObjConSummary(objSummary);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public M_Validate[] getObjValidate(JSONArray obj) {

		if (obj != null && obj.length() > 0) {
			M_Validate[] mValidateArr = new M_Validate[obj.length()];
			for (int i = 0; i < obj.length(); i++) {
				try {
					JSONObject objValidate = obj.getJSONObject(i);
					mValidateArr[i] = new M_Validate();
					mValidateArr[i].setMessage(getJsonString(objValidate, JSONElement.message));
					mValidateArr[i].setOperate(getJsonString(objValidate, JSONElement.operate));

					if (hasElement(objValidate, JSONElement.v1)) {
						JSONObject objV1 = objValidate.getJSONObject(JSONElement.v1);
						JSONArray objSummary = objV1.getJSONArray(JSONElement.summary);
						mValidateArr[i].setV1(getObjSummary(objSummary));
					}
					if (hasElement(objValidate, JSONElement.v2)) {
						JSONObject objV1 = objValidate.getJSONObject(JSONElement.v2);
						JSONArray objSummary = objV1.getJSONArray(JSONElement.summary);
						mValidateArr[i].setV2(getObjSummary(objSummary));
					}

				} catch (JSONException e) {
					e.printStackTrace();
				}
			}

			return mValidateArr;
		}
		return null;
	}

	public M_DependOn[] getObjDepenOn(JSONArray obj) {
		if (obj != null && obj.length() > 0) {
			M_DependOn[] mDepenOnArr = new M_DependOn[obj.length()];
			for (int i = 0; i < obj.length(); i++) {
				mDepenOnArr[i] = new M_DependOn();
				try {
					JSONObject objDepenOn = obj.getJSONObject(i);
					mDepenOnArr[i].setIdentify(getJsonString(objDepenOn, JSONElement.identify));
					mDepenOnArr[i].setOperate(getJsonString(objDepenOn, JSONElement.operate));
					
					JSONArray objFieldsArr = objDepenOn.getJSONArray(JSONElement.fields);
					if (objFieldsArr != null && objFieldsArr.length() > 0) {
						M_DepenOnFields[] mDepenOnFieldsArr = new M_DepenOnFields[objFieldsArr.length()];
						for (int j = 0; j < objFieldsArr.length(); j++) {
							JSONObject objFields = objFieldsArr.getJSONObject(j);
							M_DepenOnFields mDepenOnFields = new M_DepenOnFields();
							mDepenOnFieldsArr[j] = new M_DepenOnFields();
							mDepenOnFieldsArr[j] = mDepenOnFields;

							mDepenOnFields.setTitle(getJsonString(objFields, JSONElement.title));
							mDepenOnFields.setHidden(getJsonString(objFields, JSONElement.hidden));

							mDepenOnFields.setIdentify(getJsonString(objFields, JSONElement.identify));
							mDepenOnFields.setLabel(getJsonString(objFields, JSONElement.label));
							mDepenOnFields.setType(getJsonString(objFields, JSONElement.type));
							mDepenOnFields.setKeyboardType(getJsonString(objFields, JSONElement.keyboardType));
							mDepenOnFields.setSecure(getJsonString(objFields, JSONElement.secure));
							mDepenOnFields.setFormat(getJsonString(objFields, JSONElement.format));

							if (hasElement(objFields, JSONElement.conditions)) {
								JSONArray objConditions = objFields.getJSONArray(JSONElement.conditions);
								mDepenOnFields.setConditions(getConditions(objConditions));
							}
							
							if (hasElement(objFields, JSONElement.summary)) {
								JSONArray objSummaryArr = objFields.getJSONArray(JSONElement.summary);
								mDepenOnFields.setSummary(getObjSummary(objSummaryArr));
							}
							mDepenOnArr[i].setFields(mDepenOnFieldsArr);
						}
					}

				} catch (JSONException e) {
					e.printStackTrace();
				}

				return mDepenOnArr;
			}

		}

		return null;
	}

	public M_Conditions[] getConditions(JSONArray obj) {
		JSONArray objConArr = obj;
		if (objConArr != null && objConArr.length() > 0) {
			M_Conditions[] conArr = new M_Conditions[objConArr.length()];
			for (int k = 0; k < conArr.length; k++) {
				JSONObject objCon;
				try {
					objCon = objConArr.getJSONObject(k);

					conArr[k] = new M_Conditions();
					conArr[k].setIdentify(getJsonString(objCon, JSONElement.identify));
					conArr[k].setOperate(getJsonString(objCon, JSONElement.operate));
					if (hasElement(objCon, JSONElement.values)) {
						JSONArray objValuesArr = objCon.getJSONArray(JSONElement.values);
						String[] values = new String[objValuesArr.length()];
						for (int l = 0; l < objValuesArr.length(); l++) {
							values[l] = objValuesArr.getString(l).toString();
						}
						conArr[k].setVlaues(values);
					}

					if (hasElement(objCon, JSONElement.v1)) {
						JSONObject objV1 = objCon.getJSONObject(JSONElement.v1);
						JSONArray objSummary = objV1.getJSONArray(JSONElement.summary);
						conArr[k].setV1(getObjConSummary(objSummary));
					}
					if (hasElement(objCon, JSONElement.v2)) {
						JSONObject objV1 = objCon.getJSONObject(JSONElement.v2);
						JSONArray objSummary = objV1.getJSONArray(JSONElement.summary);
						conArr[k].setV2(getObjConSummary(objSummary));
					}
				} catch (JSONException e) {
					e.printStackTrace();
				}
			}
			return conArr;
		}
		return null;

	}

	public static int getJsonInt(JSONObject obj, String name) {
		try {
			return obj.get(name) != null ? obj.getInt(name) : 0;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public static boolean hasElement(JSONObject obj, String name) {
		if (obj.has(name))
			return true;
		return false;
	}

	public static String getJsonString(JSONObject obj, String name) {
		try {
			if (hasElement(obj, name)) {
				writeLog.LogD(writeLog.TAG, (obj.get(name) != null ? obj.getString(name) : ""));
				return (obj.get(name) != null ? obj.getString(name) : "");
			} else {
				writeLog.LogD(writeLog.TAG, "");
				return "";
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static boolean getJsonBoolean(JSONObject obj, String name) {
		try {
			return obj.get(name) != null ? obj.getBoolean(name) : false;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return false;
	}
}
