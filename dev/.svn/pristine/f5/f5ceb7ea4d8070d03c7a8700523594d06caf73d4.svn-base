package com.revenuedepartment.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.revenuedepartment.app.R;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_Bank;

public class ChanellFillingAdapter extends BaseAdapter {
	Activity activity;
	private LayoutInflater inflater = null;
	M_Bank[] data;

	public ChanellFillingAdapter(Activity activity) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

	}

	public ChanellFillingAdapter(Activity activity, M_Bank[] data) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.data = data;
	}

	public int getCount() {
		return data.length;
	}

	public Object getItem(int position) {
		return position;
	}

	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		TextViewCustom txNameChanall;

	}

	public View getView(final int position, View convertView, ViewGroup parent) {
		View vi = convertView;
		ViewHolder holder;
		if (convertView == null) {
			vi = inflater.inflate(R.layout.items_chanall, null);

			holder = new ViewHolder();
			holder.txNameChanall = (TextViewCustom) vi.findViewById(R.id.txNameChanall);

			vi.setTag(holder);
		} else {
			holder = (ViewHolder) vi.getTag();
		}

		holder.txNameChanall.setText(data[position].getLabel());

		return vi;
	}
}