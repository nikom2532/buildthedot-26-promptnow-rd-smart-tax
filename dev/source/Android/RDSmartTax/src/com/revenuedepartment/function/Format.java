package com.revenuedepartment.function;

public class Format {

	public static String formatNid(String value) {
		if (value.length() == 13) {
			String temp[] = value.split("");
			String nidFormat = "";
			for (int i = 1; i < temp.length; i++) {
				if (i == 1) {
					nidFormat = nidFormat + temp[i] + "-";
				} else if (i == 5) {
					nidFormat = nidFormat + temp[i] + "-";
				} else if (i == 10) {
					nidFormat = nidFormat + temp[i] + "-";
				} else if (i == 12) {
					nidFormat = nidFormat + temp[i] + "-";
				} else {
					nidFormat = nidFormat + temp[i];
				}
			}
			return nidFormat;
		}
		return null;
	}

	public static String spitNid(String value) {
		String temp[] = value.split("-");
		String nid = "";
		for (int i = 0; i < temp.length; i++) {
			nid = nid + temp[i];
		}
		return nid;
	}
}
