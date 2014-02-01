package com.revenuedepartment.customview;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.widget.Button;
import android.widget.LinearLayout;

import com.revenuedepartment.app.FillingStep2;
import com.revenuedepartment.app.R;
import com.revenuedepartment.function.ConvertDpToPx;
import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.SharedPref;

public class ButtonCustom extends Button {
	Context context;

	public ButtonCustom(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		this.context = context;
		init(attrs);
	}

	public ButtonCustom(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.context = context;
		init(attrs);
		checkLanguage(getText().toString());
	}

	public ButtonCustom(Context context) {
		super(context);
		this.context = context;
		setDefault();
		init();
		checkLanguage(getText().toString());
	}

	public void setDefault() {
		setTextSize(ConfigApp.size_font_button);
		setBold();
		setTextColor(Color.WHITE);
		setBackgroundResource(R.drawable.btn_green);
	}

	@Override
	public void setBackgroundResource(int resid) {
		// TODO Auto-generated method stub
		super.setBackgroundResource(resid);
	}

	public void setTextChangeLanguage(String message) {
		this.setText(checkLanguageSetText(message));
	}

	private void init(AttributeSet attrs) {
		TypedArray a = context.getTheme().obtainStyledAttributes(attrs, R.styleable.TextViewCustom, 0, 0);
		try {
			String style = a.getString(R.styleable.TextViewCustom_textstyle);
			if (style == null) {
				setNormal();
			} else {
				if (style.equals("bold|italic")) {
					setBolditalic();
				} else if (style.equals("bold")) {
					setBold();
				} else if (style.equals("italic")) {
					// setItalic();
				} else {
					setNormal();
				}
			}

		} finally {
			a.recycle();
		}

	}

	private void init() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(), "fonts/PSL-Kittithada.ttf");
			setTypeface(tf);
		}
	}

	public void setBold() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(), "fonts/PSL-KittithadaBold.ttf");
			setTypeface(tf);
		}
	}

	public void setNormal() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(), "fonts/PSL-Kittithada.ttf");
			setTypeface(tf);
		}
	}

	public void setBolditalic() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(), "fonts/PSL-KittithadaBoldItalic.ttf");
			setTypeface(tf);
		}
	}

	public void setBoldItalic() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(), "fonts/PSL-KittithadaItalic.ttf");
			setTypeface(tf);
		}
	}

	public void setSize(int dp) {
		setTextSize(ConvertDpToPx.convert(dp, context));
	}

	@Override
	public void setTextSize(float size) {
		super.setTextSize(TypedValue.COMPLEX_UNIT_SP, size);
	}

	public void checkLanguage(String txt) {
		try {
			String[] temp = txt.split(",.");
			String value = new SharedPref(context).getLang();
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

}
