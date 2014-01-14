package com.revenuedepartment.function;

import android.content.Context;
import android.content.pm.PackageManager.NameNotFoundException;
import android.util.Log;

public class GetVersionApp {
	Context context;

	public GetVersionApp(Context context) {
		this.context = context;
	}

	public String getVersion() {
		try {
			String app_ver = context.getPackageManager().getPackageInfo(context.getPackageName(), 0).versionName;
			return app_ver;
		} catch (NameNotFoundException e) {
			Log.v(context.getPackageName(), e.getMessage());
			return null;
		}
	}
}
