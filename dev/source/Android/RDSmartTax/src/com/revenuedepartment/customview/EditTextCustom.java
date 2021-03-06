package com.revenuedepartment.customview;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Color;
import android.graphics.Typeface;
import android.text.InputFilter;
import android.text.InputType;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.widget.EditText;

import com.revenuedepartment.app.R;
import com.revenuedepartment.function.ConvertDpToPx;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.service.SharedPref;

public class EditTextCustom extends EditText {
	Context context;

	public EditTextCustom(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		this.context = context;
		init();
		try {
			if (getInputType() == 129) {
				setMessageHint(checkLanguageSetText(getHint().toString()));
				init();
			} else {
				checkLanguage(getText().toString());
			}
		} catch (Exception e) {
			writeLog.LogE(writeLog.TAG, e.toString());
		}

	}

	public EditTextCustom(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.context = context;
		init();

		try {

			if (getInputType() == 129) {
				setMessageHint(checkLanguageSetHint(getHint().toString()));
				init();
			} else {
				checkLanguage(getText().toString());
			}
		} catch (Exception e) {
			writeLog.LogE(writeLog.TAG, e.toString());
		}
	}

	public EditTextCustom(Context context) {
		super(context);
		this.context = context;
		setTextColor(Color.BLACK);
		init();

		checkLanguage(getText().toString());

	}

	public void setTextChangeLanguage(String message) {
		this.setText(checkLanguageSetText(message));
	}

	private void init() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(),
					"fonts/PSL-Kittithada.ttf");
			setTypeface(tf);
		}
//		setBold();
		setSingleLine(true);
		setBackgroundResource(R.drawable.textfield_line);
	}

	public void setBold() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(),
					"fonts/PSL-KittithadaBold.ttf");
			setTypeface(tf);
		}
	}

	public void setNormal() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(),
					"fonts/PSL-Kittithada.ttf");
			setTypeface(tf);
		}
	}

	public void setBolditalic() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(),
					"fonts/PSL-KittithadaBoldItalic.ttf");
			setTypeface(tf);
		}
	}

	public void setBoldItalic() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(),
					"fonts/PSL-KittithadaItalic.ttf");
			setTypeface(tf);
		}
	}

	public void setSize(int dp) {
		setTextSize(ConvertDpToPx.convert(dp, context));
	}

	public void setMaxLength(int length) {
		InputFilter[] FilterArray = new InputFilter[1];
		FilterArray[0] = new InputFilter.LengthFilter(length);
		this.setFilters(FilterArray);
	}

	public void setFormat(String format) {
		if (format.equals("decimal")) {
			this.setInputType(InputType.TYPE_CLASS_NUMBER
					| InputType.TYPE_NUMBER_FLAG_DECIMAL);
		} else if (format.equals("xxxxxxxxxxxxx")) {
			setRawInputType(Configuration.KEYBOARD_QWERTY);
			setMaxLength(17);
		}
	}

	public void setMessageHint(String message) {
		this.setHint(message);
	}

	@Override
	public void setTextSize(float size) {
		super.setTextSize(TypedValue.COMPLEX_UNIT_SP, size);
	}

	public void checkLanguage(String txt) {
		try {
			String[] temp = txt.split(",.");
			String value = "th";
			if (value.equals("th")) {
				setText(temp[0]);
			} else {
				setText(temp[1]);
			}
		} catch (Exception e) {
			setText(txt);
		}
	}

	// text format ,.
	public String checkLanguageSetText(String txt) {
		try {
			String[] temp = txt.split(",.");
			String value = new SharedPref(context).getLang();
			if (value.equals("th")) {
				setText(temp[0]);
				return temp[0];
			} else {
				setText(temp[1]);
				return temp[1];
			}
		} catch (Exception e) {
			setText(txt);
			return null;
		}
	}

	public String checkLanguageSetHint(String txt) {
		try {
			String[] temp = txt.split(",.");
			String value = new SharedPref(context).getLang();
			if (value.equals("th")) {
				return temp[0];
			} else {
				return temp[1];
			}
		} catch (Exception e) {
			return "";
		}
	}

}
