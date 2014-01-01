package com.revenuedepartment.customview;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Typeface;
import android.text.InputFilter;
import android.text.InputType;
import android.util.AttributeSet;
import android.widget.EditText;

import com.revenuedepartment.app.R;
import com.revenuedepartment.function.ConvertDpToPx;

public class EditTextCustom extends EditText {
	Context context;

	public EditTextCustom(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		this.context = context;
		init();
	}

	public EditTextCustom(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.context = context;
		init();
	}

	public EditTextCustom(Context context) {
		super(context);
		this.context = context;
		init();
	}

	private void init() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(), "fonts/PSL-Kittithada.ttf");
			setTypeface(tf);
		}
		setSingleLine(true);
		// setBackgroundResource(R.drawable.bg_input);
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

	public void setMaxLength(int length) {
		InputFilter[] FilterArray = new InputFilter[1];
		FilterArray[0] = new InputFilter.LengthFilter(length);
		this.setFilters(FilterArray);
	}

	public void setFormat(String format) {
		if (format.equals("decimal")) {
			this.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL);
		} else if (format.equals("xxxxxxxxxxxxx")) {
			setRawInputType(Configuration.KEYBOARD_QWERTY);
			setMaxLength(17);
		}
	}

	public void setMessageHint(String message) {
		this.setHint(message);
	}
}
