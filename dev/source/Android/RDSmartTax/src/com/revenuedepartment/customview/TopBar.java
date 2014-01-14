package com.revenuedepartment.customview;

//com.revenuedepartment.customview.TopBar
import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.revenuedepartment.app.R;

public class TopBar extends RelativeLayout {
	Context context;
	private LayoutInflater mInflater;
	private RelativeLayout bar;

	private ButtonCustom btBack;
	private TextViewCustom txTitle;
	private ImageView icLogo;

	public TopBar(Context context, AttributeSet attrs) {
		super(context, attrs);

		this.context = context;

		mInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

		bar = (RelativeLayout) mInflater.inflate(R.layout.top_bar, null);

		icLogo = (ImageView) bar.findViewById(R.id.icLogo);

		txTitle = (TextViewCustom) bar.findViewById(R.id.labelTitle);

		btBack = (ButtonCustom) bar.findViewById(R.id.btTopBack);
	
		clickBack();

		setLogo();

		addView(bar, new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));

	}

	public void setLogo() {
		icLogo.setVisibility(View.VISIBLE);
		txTitle.setVisibility(View.GONE);
	}

	public void setTitle(String message) {
		txTitle.setVisibility(View.VISIBLE);
		icLogo.setVisibility(View.INVISIBLE);
		txTitle.setTextChangeLanguage(message);
	}

	public void setButtonRight(int imageResource, String text, OnClickListener listener) {
		ButtonCustom btRight = (ButtonCustom) bar.findViewById(R.id.btRight);
		btRight.setVisibility(View.VISIBLE);
		if (imageResource != 0) {
			btRight.setBackgroundResource(imageResource);
		} else {
			btRight.setText(text);
		}
		btRight.setOnClickListener(listener);
	}

	public void setImageRight(int imageResource, OnClickListener listener) {
		ImageView ivRight = (ImageView) bar.findViewById(R.id.ivRight);
		ivRight.setVisibility(View.VISIBLE);
		if (imageResource != 0) {
			ivRight.setBackgroundResource(imageResource);
		}
		ivRight.setOnClickListener(listener);
	}

	public void clickBack() {
		btBack.setVisibility(View.VISIBLE);
		btBack.setOnClickListener(backListener);
	}

	public void clickBack(OnClickListener listener) {
		btBack.setVisibility(View.VISIBLE);
		btBack.setOnClickListener(listener);
	}

	public void hideBack() {
		btBack.setVisibility(View.GONE);
		btBack.setOnClickListener(null);
	}

	OnClickListener backListener = new OnClickListener() {

		@Override
		public void onClick(View v) {
			((Activity) context).finish();
			((Activity) context).overridePendingTransition(0, R.anim.slide_out_right);
		}
	};
}
