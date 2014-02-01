package com.revenuedepartment.adapter;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;

import com.revenuedepartment.app.R;
import com.revenuedepartment.customview.TextViewCustom;

public class SatisfactionAdapter extends BaseAdapter {
	Activity activity;
	private LayoutInflater inflater = null;
	ArrayList<String> value;

	public SatisfactionAdapter(Activity activity) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	}

	public SatisfactionAdapter(Activity activity, ArrayList<String> value) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.value = value;
	}

	public int getCount() {
		return value.size();
	}

	public Object getItem(int position) {
		return position;
	}

	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		TextViewCustom txScore;
		LinearLayout lnScore;
	}

	public View getView(final int position, View convertView, ViewGroup parent) {
		View vi = convertView;
		ViewHolder holder;
		if (convertView == null) {
			vi = inflater.inflate(R.layout.items_satisfaction, null);

			holder = new ViewHolder();
			holder.txScore = (TextViewCustom) vi.findViewById(R.id.txScore);
			holder.lnScore = (LinearLayout) vi.findViewById(R.id.lnScore);
			vi.setTag(holder);
		} else {
			holder = (ViewHolder) vi.getTag();
		}

		holder.txScore.setText(value.get(position));

		return vi;
	}
}