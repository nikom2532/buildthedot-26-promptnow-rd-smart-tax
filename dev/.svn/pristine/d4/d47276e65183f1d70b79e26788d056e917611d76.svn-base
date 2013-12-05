package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.widget.LinearLayout;

import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;

public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		TextViewCustom text = new TextViewCustom(MainActivity.this);
		text.setText("Android");
		text.setTextColor(Color.RED);
		text.setSize(20);
		text.setBolditalic();

		TextViewCustom text1 = new TextViewCustom(MainActivity.this);
		text1.setText("Android");
		text1.setTextColor(Color.RED);
		text1.setSize(20);
		text1.setNormal();

		EditTextCustom et1 = new EditTextCustom(MainActivity.this);
		et1.setHint(getString(R.string.app_name));
		et1.setSize(20);

		LinearLayout layoutMain = (LinearLayout) findViewById(R.id.layoutMain);
		layoutMain.addView(text);
		layoutMain.addView(text1);
		layoutMain.addView(et1);

		Intent intent = new Intent(MainActivity.this, Main1.class);
		startActivity(intent);
	}
}