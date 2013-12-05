package com.revenuedepartment.customview;

import com.revenuedepartment.function.ConvertDpToPx;

import android.content.Context;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.widget.TextView;

public class TextViewCustom extends TextView {
	Context context;

	public TextViewCustom(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		this.context = context;
		init();
	}

	public TextViewCustom(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.context = context;
		init();
	}

	public TextViewCustom(Context context) {
		super(context);
		this.context = context;
		init();
	}

	private void init() {
		if (!isInEditMode()) {
			Typeface tf = Typeface.createFromAsset(getContext().getAssets(),
					"fonts/PSL-Kittithada.ttf");
			setTypeface(tf);
		}
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
}
