package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;

public class ChanallFilling extends Activity implements OnClickListener {
	GridView gvLogo;

	String[] logos;
	ButtonCustom btPaySlip;
	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setView();
		Intent get = getIntent();
		String path = get.getExtras().getString("path");
		logos = get.getExtras().getStringArray("logos");

		if (path.equals("-1")) {
			btPaySlip.setVisibility(View.INVISIBLE);
		} else {

		}
		gvLogo.setAdapter(new ImageAdapter(ChanallFilling.this));
	}

	private void setView() {
		setContentView(R.layout.chanall_filling);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_chanall));
		gvLogo = (GridView) findViewById(R.id.gvLogo);
		btPaySlip = (ButtonCustom) findViewById(R.id.btPaySlip);
		btPaySlip.setDefault();
	}

	public class ImageAdapter extends BaseAdapter {
		private Context mContext;
		int image = 0;

		public ImageAdapter(Context c) {
			mContext = c;
		}

		public int getCount() {
			return logos.length;
		}

		public Object getItem(int position) {
			return null;
		}

		public long getItemId(int position) {
			return 0;
		}

		public View getView(int position, View convertView, ViewGroup parent) {
			ImageView imageView;
			if (convertView == null) {
				imageView = new ImageView(mContext);
				imageView.setLayoutParams(new GridView.LayoutParams(80, 80));

			} else {
				imageView = (ImageView) convertView;
			}
			if (logos[position].equals("002")) {
				image = R.drawable.p002;
			} else if (logos[position].equals("004")) {
				image = R.drawable.p004;
			} else if (logos[position].equals("006")) {
				image = R.drawable.p006;
			} else if (logos[position].equals("008")) {
				image = R.drawable.p008;
			} else if (logos[position].equals("010")) {
				image = R.drawable.p010;
			} else if (logos[position].equals("011")) {
				image = R.drawable.p011;
			} else if (logos[position].equals("014")) {
				image = R.drawable.p014;
			} else if (logos[position].equals("017")) {
				image = R.drawable.p017;
			} else if (logos[position].equals("018")) {
				image = R.drawable.p018;
			} else if (logos[position].equals("020")) {
				image = R.drawable.p020;
			} else if (logos[position].equals("022")) {
				image = R.drawable.p022;
			} else if (logos[position].equals("024")) {
				image = R.drawable.p024;
			} else if (logos[position].equals("025")) {
				image = R.drawable.p025;
			} else if (logos[position].equals("027")) {
				image = R.drawable.p027;
			} else if (logos[position].equals("030")) {
				image = R.drawable.p030;
			} else if (logos[position].equals("031")) {
				image = R.drawable.p031;
			} else if (logos[position].equals("034")) {
				image = R.drawable.p034;
			} else if (logos[position].equals("039")) {
				image = R.drawable.p039;
			} else if (logos[position].equals("045")) {
				image = R.drawable.p045;
			} else if (logos[position].equals("065")) {
				image = R.drawable.p065;
			} else if (logos[position].equals("067")) {
				image = R.drawable.p067;
			} else if (logos[position].equals("711")) {
				image = R.drawable.p711;
			} else if (logos[position].equals("914")) {
				image = R.drawable.p914;
			}
			imageView.setImageResource(image);
			return imageView;
		}

	}

	@Override
	public void onClick(View v) {

	}

	@Override
	public void onBackPressed() {
		super.onBackPressed();
		finish();
		overridePendingTransition(0, 0);
	}
}
