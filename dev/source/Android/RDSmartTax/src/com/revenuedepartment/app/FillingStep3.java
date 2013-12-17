package com.revenuedepartment.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TextViewCustom;
import com.revenuedepartment.datamodels.M_Fields;
import com.revenuedepartment.datamodels.M_Forms;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.service.SavedInstance;
import com.revenuedepartment.service.TypeView;

public class FillingStep3 extends Activity {

	LinearLayout lbContent;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		P_Filling pFilling = (P_Filling) SavedInstance.map.get(SavedInstance.FILLING);
		drawForm(pFilling.getForms()[2]);
	}

	void setView() {
		setContentView(R.layout.filling);
		lbContent = (LinearLayout) findViewById(R.id.lbContent);
	}

	void drawForm(M_Forms forms) {
		TextViewCustom txText = new TextViewCustom(this);
		txText.setText(forms.getFormName());
		txText.setSize(20);
		lbContent.addView(txText);

		for (int i = 0; i < forms.getFormData().getFields().length; i++) {
			M_Fields fields = forms.getFormData().getFields()[i];
			if (fields.getHidden().equals("")) {

				LinearLayout layout = new LinearLayout(this);

				if (fields.getType().equals(TypeView.checkBox)) {
					CheckBox checkBox = new CheckBox(this);
					layout.addView(checkBox);

					TextViewCustom tx = new TextViewCustom(this);
					tx.setText(fields.getLabel());
					tx.setSize(14);
					layout.addView(tx);

					layout.setOrientation(LinearLayout.HORIZONTAL);
					layout.setLayoutParams(new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
				}

				if (fields.getType().equals(TypeView.textField)) {
					TextViewCustom tx = new TextViewCustom(this);
					tx.setText(fields.getLabel());
					tx.setSize(14);
					layout.addView(tx);

					EditTextCustom et = new EditTextCustom(this);
					et.setSize(14);
					layout.addView(et , new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
					
					layout.setOrientation(LinearLayout.VERTICAL);
					layout.setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT));
				}

				lbContent.addView(layout);
			}
		}
		Button btNext = new Button(this);
		btNext.setText("Next");
btNext.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(FillingStep3.this, FillingStep4.class);
				startActivityForResult(intent, 0);
			}
		});
		lbContent.addView(btNext);
	}
}
