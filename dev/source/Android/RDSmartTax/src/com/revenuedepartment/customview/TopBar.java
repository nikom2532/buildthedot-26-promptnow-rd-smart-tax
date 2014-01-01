package com.revenuedepartment.customview;

//com.revenuedepartment.customview.TopBar
import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.revenuedepartment.app.R;

public class TopBar extends LinearLayout {
	Context context;
	private LayoutInflater mInflater;
	private LinearLayout bar;

	public TopBar(Context context, AttributeSet attrs) {
		super(context, attrs);

		this.context = context;

		mInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

		bar = (LinearLayout) mInflater.inflate(R.layout.top_bar, null);

		addView(bar);
	}
}
