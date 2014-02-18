package com.revenuedepartment.app;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.widget.ImageView;

public class NavigatorDynamic {
	static List<ImageView> steps = new ArrayList<ImageView>(); 
	public static void setDynamicNavigate(Activity act, int currentNavigate) {
		steps.clear();
		ImageView step0 = (ImageView) act.findViewById(R.id.step0);
		ImageView step1 = (ImageView) act.findViewById(R.id.step1);
		ImageView step2 = (ImageView) act.findViewById(R.id.step2);
		ImageView step3 = (ImageView) act.findViewById(R.id.step3);
		steps.add(step0);
		steps.add(step1);
		steps.add(step2);
		steps.add(step3);
		for(int index=0; index<steps.size(); index++){
			if(index==currentNavigate){
				steps.get(index).setImageResource(R.drawable.icon_current_status);
			}else {
				steps.get(index).setImageResource(R.drawable.icon_status);
			}
		}
	}
}
