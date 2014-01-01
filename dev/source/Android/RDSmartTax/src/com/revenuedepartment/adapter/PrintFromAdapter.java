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
import com.revenuedepartment.datamodels.M_FormData;
import com.revenuedepartment.function.CheckLang;
import com.revenuedepartment.service.ConfigApp;

public class PrintFromAdapter extends BaseAdapter {
	Activity activity;
	private LayoutInflater inflater = null;
	ArrayList<M_FormData> mPrintList;
	String type;

	public PrintFromAdapter(Activity activity) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	}

	public PrintFromAdapter(Activity activity, ArrayList<M_FormData> mPrintList, String type) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.mPrintList = mPrintList;
		this.type = type;
	}

	public int getCount() {
		return mPrintList.size();
	}

	public Object getItem(int position) {
		return position;
	}

	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		TextViewCustom labelRef, labelDate, labelTaxAmount;
		TextViewCustom txRef, txDate, txTaxAmount;
	}

	public View getView(final int position, View convertView, ViewGroup parent) {
		View vi = convertView;
		ViewHolder holder;
		if (convertView == null) {
			vi = inflater.inflate(R.layout.items_print, null);

			holder = new ViewHolder();
			holder.txRef = (TextViewCustom) vi.findViewById(R.id.txRef);
			holder.txDate = (TextViewCustom) vi.findViewById(R.id.txDate);
			holder.txTaxAmount = (TextViewCustom) vi.findViewById(R.id.txTaxAmount);

			holder.labelRef = (TextViewCustom) vi.findViewById(R.id.labelRef);
			holder.labelDate = (TextViewCustom) vi.findViewById(R.id.labelDate);
			holder.labelTaxAmount = (TextViewCustom) vi.findViewById(R.id.labelTaxAmount);

			vi.setTag(holder);
		} else {
			holder = (ViewHolder) vi.getTag();
		}

		if (type.equals(ConfigApp.F)) {
			holder.txRef.setText(mPrintList.get(position).getRefNo());
			holder.txDate.setText(mPrintList.get(position).getPayDate());
			holder.txTaxAmount.setText(mPrintList.get(position).getTaxAmount());
			holder.labelRef.setText(CheckLang.check(activity, activity.getString(R.string.txRef_th), activity.getString(R.string.txRef_en)));
		} else if (type.equals(ConfigApp.R)) {
			holder.labelRef
					.setText(CheckLang.check(activity, activity.getString(R.string.txReceipNo_th), activity.getString(R.string.txReceipNo_th)));
			holder.txRef.setText(mPrintList.get(position).getReceiptNo());
			holder.txDate.setText(mPrintList.get(position).getPayDate());
			holder.txTaxAmount.setText(mPrintList.get(position).getTaxAmount());
		}

		return vi;
	}
}