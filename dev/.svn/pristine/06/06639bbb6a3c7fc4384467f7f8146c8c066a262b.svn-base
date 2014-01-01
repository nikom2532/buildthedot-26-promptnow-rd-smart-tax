package com.revenuedepartment.formvalidation;

public class testTextWatcher {
//test
/*
	//####################################################################################################################
	// TextWatch is watch for make the validate for EditText, control how to key
	// in EditText
	/*
	int prevCursorEtNid = 0;
	TextWatcher textWatcherEtNid = new TextWatcher() {
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count) {
			String text = etNid.getText().toString();
			// writeLog.LogV("onTextChanged", "etNidFormat");
			if (prevCursorEtNid <= 1) {
				if (text.length() == 1) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
			} else if (prevCursorEtNid <= 6) {
				if (text.length() == 6) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
			} else if (prevCursorEtNid <= 12) {
				if (text.length() == 12) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
			} 
			else if (prevCursorEtNid <= 15) {
				if (text.length() == 15) {
					String newtext = etNid.getText().toString() + "-";
					etNid.setText("");
					etNid.append(newtext);
				}
				else if(text.length() == 13 && prevCursorEtNid>text.length()){
					String newtext_changed = etNid.getText().toString();
					newtext_changed = newtext_changed.substring(0, newtext_changed.length()-1);
					etNid.setText("");
					etNid.append(newtext_changed);	
				}
				else if((text.length()==13 && prevCursorEtNid==13)){
					String lastChar = etNid.getText().toString();
					String oldString = lastChar.substring(0, lastChar.length()-1);
					lastChar = lastChar.substring(lastChar.length()-2, lastChar.length()-1);
					String newString = oldString+"-"+lastChar;
					etTelephone.setText("");
					etTelephone.append(newString);
				}
			}
			etNid.requestFocus();
			prevCursorEtNid = text.length();
		}

		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {
			String text = etNid.getText().toString();
			if (text.length() == 1 || text.length() == 6 || text.length() == 12 || text.length() == 15) {
				String newtext = etNid.getText().toString() + "-";
				etNid.setText("");
				etNid.append(newtext);
			}
		}

		@Override
		public void afterTextChanged(Editable s) {
			
		}
	};
	*/
	
	/*
	TextWatcher textWatcherEtNid = new TextWatcher() {
		String a;
		int keyDel;
		@Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {

            boolean flag = true;
            String eachBlock[] = etNid.getText().toString().split("-");
            for (int i = 0; i < eachBlock.length; i++) {
                if (eachBlock[i].length() > 4) {
                    flag = false;
                }
            }
            if (flag) {

            	etNid.setOnKeyListener(new OnKeyListener() {

                    @Override
                    public boolean onKey(View v, int keyCode, KeyEvent event) {

                        if (keyCode == KeyEvent.KEYCODE_DEL)
                            keyDel = 1;
                        return false;
                    }
                });

                if (keyDel == 0) {

                    if (((etNid.getText().length() + 1) % 5) == 0) {

                        if (etNid.getText().toString().split("-").length <= 3) {
                        	etNid.setText(etNid.getText() + "-");
                            etNid.setSelection(etNid.getText().length());
                        }
                    }
                    a = etNid.getText().toString();
                } else {
                    a = etNid.getText().toString();
                    keyDel = 0;
                }

            } else {
            	etNid.setText(a);
            }

        }

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count,
                int after) {
            // TODO Auto-generated method stub

        }

        @Override
        public void afterTextChanged(Editable s) {
        }
    };
    */

	
	//###########################################################################################################
//	textWatcherEtNid
	
	/*
	TextWatcher textWatcherEtNid = new TextWatcher() {
//		df = new DecimalFormat("#,###.##");
//	    df.setDecimalSeparatorAlwaysShown(true);
//	    dfnd = new DecimalFormat("#,###");
//	    hasFractionalPart = false;
	    this.etNid = et;
//		@SuppressWarnings("unused")
		private static final String TAG = "NumberTextWatcher";
	
		@Override
		public void afterTextChanged(Editable s){
		    et.removeTextChangedListener(this);
	
		    try {
		        int inilen, endlen;
		        inilen = et.getText().length();
	
		        String v = s.toString().replace(String.valueOf(df.getDecimalFormatSymbols().getGroupingSeparator()), "");
		        Number n = df.parse(v);
		        int cp = et.getSelectionStart();
		        if (hasFractionalPart) {
		            et.setText(df.format(n));
		        } else {
		            et.setText(dfnd.format(n));
		        }
		        endlen = et.getText().length();
		        int sel = (cp + (endlen - inilen));
		        if (sel > 0 && sel <= et.getText().length()) {
		            et.setSelection(sel);
		        } else {
		            // place cursor at the end?
		            et.setSelection(et.getText().length() - 1);
		        }
		    } catch (NumberFormatException nfe) {
		        // do nothing?
		    } catch (ParseException e) {
		        // do nothing?
		    }
	
		    et.addTextChangedListener(this);
		}
	
		@Override
		public void beforeTextChanged(CharSequence s, int start, int count, int after)
		{
			
		}
	
		@Override
		public void onTextChanged(CharSequence s, int start, int before, int count)
		{
		    if (s.toString().contains(String.valueOf(df.getDecimalFormatSymbols().getDecimalSeparator())))
		    {
		        hasFractionalPart = true;
		    } else {
		        hasFractionalPart = false;
		    }
		}
	};
	
	*/
	
}
