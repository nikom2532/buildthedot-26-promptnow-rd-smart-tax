package com.revenuedepartment.app;

import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.customview.TopBar;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

public class MenuUser extends Activity implements OnClickListener {

	RelativeLayout rlUser, rlTemplate;
	TopBar topBar;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setView();
	}

	public void setView() {
		setContentView(R.layout.menu_user);
		rlUser = (RelativeLayout) findViewById(R.id.rlUser);
		rlUser.setOnClickListener(this);
		rlTemplate = (RelativeLayout) findViewById(R.id.rlTemplate);
		rlTemplate.setOnClickListener(this);
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_user));
	}

	@Override
	public void onClick(View v) {
		if (v.equals(rlUser)) {
			setSelector(rlUser, R.id.icUser, R.id.txUser, R.drawable.icon_userprofile);
			Intent intent = new Intent(MenuUser.this, UpdateProfile.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		} else if (v.equals(rlTemplate)) {
			setSelector(rlTemplate, R.id.icTemplate, R.id.txTemplate, R.drawable.icon_template);
			Intent intent = new Intent(MenuUser.this, CreateTemplate.class);
			intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
			startActivityForResult(intent, 0);
		}
	}

	private void setSelector(RelativeLayout view, int icon, int text, int background) {
		((ImageView) (ImageView) findViewById(icon)).setImageResource(background);
		((TextViewCustom) (TextViewCustom) findViewById(text)).setTextColor(getResources().getColor(R.color.color_white));
		view.setBackgroundColor(getResources().getColor(R.color.color_bar_top));
	}

	private void setNormal(RelativeLayout view, int icon, int text, int background) {
		((ImageView) (ImageView) findViewById(icon)).setImageResource(background);
		((TextViewCustom) (TextViewCustom) findViewById(text)).setTextColor(getResources().getColor(R.color.color_gray));
		view.setBackgroundColor(0);
	}

	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		setNormal(rlUser, R.id.icUser, R.id.txUser, R.drawable.icon_userprofile);
		setNormal(rlTemplate, R.id.icTemplate, R.id.txTemplate, R.drawable.icon_template);
	}
}
