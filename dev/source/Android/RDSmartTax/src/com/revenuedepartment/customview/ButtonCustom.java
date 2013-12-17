package com.revenuedepartment.customview;

import android.content.Context;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.widget.Button;

import com.revenuedepartment.function.ConvertDpToPx;

public class ButtonCustom extends Button {
	Context context;

	public ButtonCustom(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		this.context = context;
		init();
	}

	public ButtonCustom(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.context = context;
		init();
	}

	public ButtonCustom(Context context) {
		super(context);
		this.context = context;
		init();
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

}
