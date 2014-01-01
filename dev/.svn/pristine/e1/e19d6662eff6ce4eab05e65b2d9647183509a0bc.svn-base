package com.revenuedepartment.function;

import android.content.Context;
import android.widget.Toast;

public class FillingValidate {

	Context context;

	public FillingValidate(Context context) {
		this.context = context;
	}

	public boolean checkNotNull(String operate, String v1) {
		if (operate.equals("not_null")) {
			if (v1 == null || v1.equals("")) {
				return false;
			}
		}
		return true;
	}

	public boolean check(String operate, String v1, String v2) {
		if (v2.indexOf("*") >= 0) {
			Toast.makeText(context, "*", Toast.LENGTH_SHORT).show();
		}
		if (v2.indexOf("+") >= 0) {
			return false;
		}
		if (operate.equals(">=")) {
			try {
				if (Double.parseDouble(v1) >= Double.parseDouble(v2)) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		} else if (operate.equals("<=")) {
			try {
				if (Double.parseDouble(v1) <= Double.parseDouble(v2)) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		} else if (operate.equals(">")) {
			try {
				if (Double.parseDouble(v1) > Double.parseDouble(v2)) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		} else if (operate.equals("<")) {
			try {
				if (Double.parseDouble(v1) < Double.parseDouble(v2)) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public boolean check(String operate, String v1, String valueIdentify, String v2) {
		String value = "";
		if (v2.startsWith("*")) {
			try {
				value = v2.substring(1, v2.length());
				valueIdentify = String.valueOf(Double.parseDouble(valueIdentify) * Double.parseDouble(value));
			} catch (Exception e) {

			}

		}
		if (operate.equals(">=")) {
			try {
				if (Double.parseDouble(v1) >= Double.parseDouble(valueIdentify)) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		} else if (operate.equals("<=")) {
			try {
				if (Double.parseDouble(v1) <= Double.parseDouble(valueIdentify)) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

	public double plusValue(double valueIdentify, String v2) {
		String value = "";
		double sumValue = 0;
		if (v2.startsWith("*")) {
			try {
				value = v2.substring(1, v2.length());
				sumValue = (valueIdentify * Double.parseDouble(value));
				return sumValue;
			} catch (Exception e) {
				return 0;
			}
		}
		return 0;
	}
	// public boolean GreaterThanEqual(String operate, String v1, String v2) {
	// if (operate.equals("not_null")) {
	// if (v1 == null || v1.equals("")) {
	// return false;
	// }
	// } else if (operate.equals(">=")) {
	// // try {
	// // if (Double.parseDouble(v1) >= Double.parseDouble(v2)) {
	// // return true;
	// // } else {
	// // return false;
	// // }
	// // } catch (Exception e) {
	// // return false;
	// // }
	// } else if (operate.equals("<=")) {
	//
	// }
	// return true;
	// }
}
