package com.revenuedepartment.app;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import android.app.Activity;

public class ReadTextFromFile {
	
	public static String readTxt(Activity activity, int fileString)
	{
		InputStream inputStream;
		// if ("E".equals(lang))
		// inputStream = getResources().openRawResource(R.raw.reward_en);
		// else
		// inputStream = getResources().openRawResource(R.raw.reward_th);
		inputStream = activity.getResources().openRawResource(fileString);
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		int i;
		try
		{
			i = inputStream.read();
			while (i != -1)
			{
				byteArrayOutputStream.write(i);
				i = inputStream.read();
			}
			inputStream.close();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return byteArrayOutputStream.toString();
	}

}
