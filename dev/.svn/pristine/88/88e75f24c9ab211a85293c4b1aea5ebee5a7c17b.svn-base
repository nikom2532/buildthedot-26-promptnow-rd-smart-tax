package com.revenuedepartment.adapter;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.revenuedepartment.app.R;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_CheckStatus;

public class StatusAdapter extends BaseAdapter {
	Activity activity;
	private LayoutInflater inflater = null;
	ArrayList<M_CheckStatus> mCheckStatusList;

	public StatusAdapter(Activity activity) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

	}

	public StatusAdapter(Activity activity, ArrayList<M_CheckStatus> mCheckStatusList) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.mCheckStatusList = mCheckStatusList;
	}

	public int getCount() {
		return mCheckStatusList.size();
	}

	public Object getItem(int position) {
		return position;
	}

	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		TextViewCustom labelSequence, labelDate, labelOfficeName, labelType;
		TextViewCustom txSequence, txDate, txOfficeName, txType;
	}

	public View getView(final int position, View convertView, ViewGroup parent) {
		View vi = convertView;
		ViewHolder holder;
		if (convertView == null) {
			vi = inflater.inflate(R.layout.items_check_status, null);

			holder = new ViewHolder();
			holder.txSequence = (TextViewCustom) vi.findViewById(R.id.txSequence);
			holder.txDate = (TextViewCustom) vi.findViewById(R.id.txDate);
			holder.txOfficeName = (TextViewCustom) vi.findViewById(R.id.txOfficeName);
			holder.txType = (TextViewCustom) vi.findViewById(R.id.txType);

			holder.labelSequence = (TextViewCustom) vi.findViewById(R.id.labelSequence);
			holder.labelDate = (TextViewCustom) vi.findViewById(R.id.labelDate);
			holder.labelOfficeName = (TextViewCustom) vi.findViewById(R.id.labelOfficeName);
			holder.labelType = (TextViewCustom) vi.findViewById(R.id.labelType);

			vi.setTag(holder);
		} else {
			holder = (ViewHolder) vi.getTag();
		}

		holder.txSequence.setText(mCheckStatusList.get(position).getSeq());
		holder.txDate.setText(mCheckStatusList.get(position).getPayDate());
		holder.txOfficeName.setText(mCheckStatusList.get(position).getOfficeName());
		holder.txType.setText(mCheckStatusList.get(position).getFormType());

		return vi;
	}
}