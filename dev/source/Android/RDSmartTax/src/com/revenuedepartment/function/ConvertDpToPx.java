package com.revenuedepartment.function;

import android.content.Context;
import android.content.res.Resources;
import android.util.DisplayMetrics;

public class ConvertDpToPx {
	public static float convert(float dp, Context context) {
		Resources resources = context.getResources();
		DisplayMetrics metrics = resources.getDisplayMetrics();
		float px = dp * (metrics.densityDpi / 160f);
		return px;
	}
}
