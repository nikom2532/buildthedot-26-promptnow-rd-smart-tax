package com.revenuedepartment.adapter;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;

import com.revenuedepartment.app.R;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_Instructions;

public class InstructionsAdapter extends BaseAdapter {
	Activity activity;
	private LayoutInflater inflater = null;
	ArrayList<M_Instructions> mInstructionsList;

	public InstructionsAdapter(Activity activity) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

	}

	public InstructionsAdapter(Activity activity, ArrayList<M_Instructions> mInstructionsList) {
		this.activity = activity;
		inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.mInstructionsList = mInstructionsList;
	}

	public int getCount() {
		return mInstructionsList.size();
	}

	public Object getItem(int position) {
		return position;
	}

	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		TextViewCustom txTitle;
		ImageView icInstructions;
	}

	public View getView(final int position, View convertView, ViewGroup parent) {
		View vi = convertView;
		ViewHolder holder;
		if (convertView == null) {
			vi = inflater.inflate(R.layout.items_instructions, null);

			holder = new ViewHolder();
			holder.txTitle = (TextViewCustom) vi.findViewById(R.id.txTitleName);
			holder.icInstructions = (ImageView) vi.findViewById(R.id.icInstructions);

			vi.setTag(holder);
		} else {
			holder = (ViewHolder) vi.getTag();
		}
		if (position == 0) {
			holder.icInstructions.setImageResource(R.drawable.icon_suggestion_efiling);
		} else if (position == 1) {
			holder.icInstructions.setImageResource(R.drawable.icon_suggestion_condition);
		} else if (position == 2) {
			holder.icInstructions.setImageResource(R.drawable.icon_suggestion_agreement);
		}
		holder.txTitle.setText(mInstructionsList.get(position).getInstructions_name());
		return vi;
	}
}