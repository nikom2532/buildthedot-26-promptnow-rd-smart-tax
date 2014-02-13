package com.promptnow.network.service;

import android.app.Activity;
import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnKeyListener;
import android.view.View.OnTouchListener;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
 

public class UtilTextWatcher implements TextWatcher {
    private EditText mEditText;
    private String TEXT_FINAL;
    private Activity activity;

    public UtilTextWatcher(EditText e, Activity act) { 
        mEditText = e;
        activity = act;
    	mEditText.setOnTouchListener(new OnTouchListener() {
			
			@Override
			public boolean onTouch(View v, MotionEvent event) {
				int cursorPosition = ((EditText)v).getSelectionStart();
				int lastPosition = ((EditText)v).getText().length();
				Log.i("Joe", "onTouch cursorPosition : "+cursorPosition);
				if(cursorPosition<lastPosition){ 
					((EditText)v).setSelection(lastPosition); 
//					((EditText)v).getText().setSpan(new StyleSpan(android.graphics.Typeface.BOLD), 0, (TEXT_FINAL.length() - 0), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
					
				}
				return false;
			}
		});
//        mEditText.setOnFocusChangeListener(new OnFocusChangeListener() {
//			
//			@Override
//			public void onFocusChange(View v, boolean hasFocus) {
//				if (hasFocus){
//					int cursorPosition = ((EditText)v).getSelectionStart();
//					log("onFocusChange cursorPosition : "+cursorPosition);
//					if(cursorPosition<TEXT_FINAL.length()){
//						log("mEditText.setSelection(TEXT_FINAL.length());");
//						((EditText)v).setSelected(true);
//						((EditText)v).setSelection(TEXT_FINAL.length());
////						((EditText)v).getText().setSpan(new StyleSpan(android.graphics.Typeface.BOLD), 0, (TEXT_FINAL.length() - 0), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
//						
//					}
//				}
//			}
//		});
        mEditText.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				
				int cursorPosition = ((EditText)v).getSelectionStart();
				int lastPosition = ((EditText)v).getText().length();
				if(cursorPosition<lastPosition){
					Log.i("Joe","onclick : "+cursorPosition+", "+lastPosition);
					((EditText)v).setSelection(lastPosition); 
		    	}
			}
		});
        
        mEditText.setOnKeyListener(new OnKeyListener() {
			
			@Override
			public boolean onKey(View v, int keyCode, KeyEvent event) {
				if (event.getKeyCode() == KeyEvent.KEYCODE_ENTER) {
					InputMethodManager imm = (InputMethodManager)activity.getSystemService(
						      Context.INPUT_METHOD_SERVICE);
						imm.hideSoftInputFromWindow(mEditText.getWindowToken(), 0);
	            }
	            return false;
			}
		});
    }

    public void beforeTextChanged(CharSequence s, int start, int count, int after) { 
    	TEXT_FINAL = s.toString();
    	int cursorPosition = mEditText.getSelectionStart();
		int lastPosition = mEditText.getText().length();
    	if(cursorPosition<lastPosition){ 
    		mEditText.setSelection(lastPosition);  
    		mEditText.setText(TEXT_FINAL);
    		mEditText.setSelection(TEXT_FINAL.length()); 
    	} else {
    		Log.i("Joe", "test");
    	}
    }

    public void onTextChanged(CharSequence s, int start, int before, int count) {
    	
    }

    public void afterTextChanged(Editable s) {  
    	String text = mEditText.getText().toString();
    	int length = text.length();
    	Log.i("Joe","text.endsWith(-) : "+text.endsWith("-"));
    	if(text.endsWith("-")) return;
    	if(length==2||length==7||length==13||length==16){
    		mEditText.setText(new StringBuilder(text).insert(length-1, "-"));
    		mEditText.setSelection(mEditText.getText().toString().length());
    	}
    }
     
}
