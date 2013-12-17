package com.revenuedepartment.app;

import android.app.Activity;
import android.os.Bundle;
import android.widget.Button;

public class MainMenu extends Activity {
	public static Button mButton_MainMenu_1;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main_menu);
		onCreateMethod();
	}
	public void onCreateMethod() {
		mButton_MainMenu_1 = (Button)findViewById(R.id.button1);
	}
}