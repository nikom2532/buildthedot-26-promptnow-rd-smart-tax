package com.revenuedepartment.function;

import java.io.File;
import java.io.FileOutputStream;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.util.Log;
import android.widget.LinearLayout;

public class SaveScreen {
	Activity activity;

	public SaveScreen(Activity activity) {
		this.activity = activity;
	}

	public String save(LinearLayout layout, String fileName) {
		layout.setBackgroundColor(Color.WHITE);
		File cacheDir = null;
		try {
			if (android.os.Environment.getExternalStorageState().equals(android.os.Environment.MEDIA_MOUNTED)) {
				cacheDir = new File(android.os.Environment.getExternalStorageDirectory(), "CaptureScreen");
			} else {
				cacheDir = activity.getCacheDir();
			}

			if (!cacheDir.exists()) {
				cacheDir.mkdirs();
			}
		} catch (Exception e) {
			Log.e(getClass().getName(), e.toString());
		}

		String root = cacheDir.getPath();
		String path = fileName + ".jpg";

		File file = new File(root, path);
		Bitmap bmp = null;
		try {
			bmp = Bitmap.createBitmap(layout.getWidth(), layout.getHeight(), Bitmap.Config.ARGB_8888);
			Canvas canvas = new Canvas(bmp);
			layout.draw(canvas);

			FileOutputStream fos = null;

			fos = new FileOutputStream(file);

			if (fos != null) {
				bmp.compress(Bitmap.CompressFormat.JPEG, 90, fos);
				fos.close();
			}
			if (bmp != null) {
				bmp.recycle();// / destroy bitmap cycle, a lot of memory
				bmp = null;
			}
		} catch (Exception e) {
			if (bmp != null) {
				bmp.recycle();
				bmp = null;
			}
			Log.e(getClass().getName(), e.toString());
			e.printStackTrace();
			return null;
		} catch (OutOfMemoryError e) {
			if (bmp != null) {
				bmp.recycle();
				bmp = null;
			}
			Log.e(getClass().getName(), e.toString());
			e.printStackTrace();
			return null;
		}
		layout.setBackgroundColor(Color.TRANSPARENT);
		return root + "/" + path;
	}
}