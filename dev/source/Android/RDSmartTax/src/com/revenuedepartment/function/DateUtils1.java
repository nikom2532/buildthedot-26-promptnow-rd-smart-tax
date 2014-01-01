package com.revenuedepartment.function;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;
import android.annotation.SuppressLint;
import android.util.Log;

public class DateUtils1 {
	@SuppressLint("SimpleDateFormat")
	private static final SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@SuppressLint("SimpleDateFormat")
	private static final SimpleDateFormat lmgTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final SimpleDateFormat dateTimeFormatNew = new SimpleDateFormat("dd/MM/yyy HH:mm:ss");
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private static final SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

	private static final SimpleDateFormat dateDMYFormat = new SimpleDateFormat("dd-MM-yyy");
	private static final SimpleDateFormat timeHSFormat = new SimpleDateFormat("HH:ss");

	private static final SimpleDateFormat DateMDy = new SimpleDateFormat("MMM dd, yyyy HH:mm a");
	private static final SimpleDateFormat DateMMMdd = new SimpleDateFormat("MMM dd");

	public static String getDateTimeFormat() {
		return dateTimeFormat.format(new Date());
	}

	public static String getDateFormat() {
		return dateFormat.format(new Date());
	}

	public static String getTimeFormat() {
		return timeFormat.format(new Date());
	}

	public static String getDateDMYFormat() {
		return dateDMYFormat.format(new Date());
	}

	public static String getTimeHSFormat() {
		return timeHSFormat.format(new Date());
	}

	public static String getTimeStamp(String day, String month, String year, String pubdate_time) {
		String[] time = new String[] {};
		time = pubdate_time.split(":");

		Date d = new Date(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day), Integer.parseInt(time[0]),
				Integer.parseInt(time[1]), Integer.parseInt(time[2]));
		return String.valueOf(d.getTime());
	}

	public static String getTimeStamp(String currentDateVersion) {
		String[] dateSplit = currentDateVersion.split("-");
		String[] timeSplit = dateSplit[2].split(":");
		String[] dayTimeSplit = timeSplit[0].toUpperCase().split("T");

		Date d = new Date(Integer.parseInt(dateSplit[0]), Integer.parseInt(dateSplit[1]), Integer.parseInt(dayTimeSplit[0]),
				Integer.parseInt(dayTimeSplit[1]), Integer.parseInt(timeSplit[1]), Integer.parseInt(timeSplit[2]));
		return String.valueOf(d.getTime());
	}

	public static boolean checkTimeStamp(String currentDateVersion, String lastDateVersion) {
		Log.i("DateUtils", currentDateVersion + "    " + lastDateVersion);
		boolean isMore = false;

		String[] currentDateSplit = currentDateVersion.split("-");
		String[] currentTimeSplit = currentDateSplit[2].split(":");
		String[] currentDayTimeSplit = currentTimeSplit[0].toUpperCase().split("T");

		Date currentDate = new Date(Integer.parseInt(currentDateSplit[0]), Integer.parseInt(currentDateSplit[1]),
				Integer.parseInt(currentDayTimeSplit[0]), Integer.parseInt(currentDayTimeSplit[1]), Integer.parseInt(currentTimeSplit[1]),
				Integer.parseInt(currentTimeSplit[2]));

		String[] lastDateSplit = lastDateVersion.split("-");
		String[] lastTimeSplit = lastDateSplit[2].split(":");
		String[] lastDayTimeSplit = lastTimeSplit[0].toUpperCase().split("T");

		Date lastDate = new Date(Integer.parseInt(lastDateSplit[0]), Integer.parseInt(lastDateSplit[1]), Integer.parseInt(lastDayTimeSplit[0]),
				Integer.parseInt(lastDayTimeSplit[1]), Integer.parseInt(lastTimeSplit[1]), Integer.parseInt(lastTimeSplit[2]));

		if (lastDate.after(currentDate))
			isMore = true;
		else
			isMore = false;

		return isMore;
	}

	public static String getDateMMMDDFormat() {
		return DateMMMdd.format(new Date());
	}

	public static String getDateAddMMMDDFormat(String date) {
		return DateMMMdd.format(date);
	}

	public static String getDateMDY() {
		return DateMDy.format(new Date());
	}

	public static String changeDateFormat(String lmgDateFormat) throws ParseException {
		return dateTimeFormatNew.format(lmgTimeFormat.parse(lmgDateFormat));
	}

	public static String changeTimeStarmToHM(int timestamp) {
		long ts = timestamp * 1000L;
		Date d = new java.util.Date(ts);
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		int min = cal.get(Calendar.MINUTE);
		int hour = cal.get(Calendar.HOUR_OF_DAY);

		String temp = pad(hour) + "." + pad(min);

		return temp;
	}

	public static String pad(int c) {
		if (c >= 10)
			return String.valueOf(c);
		else
			return "0" + String.valueOf(c);
	}
	public static int componentTimeToTimestamp(int year, int month, int day, int hour, int minute, int AM_PM) {

		Calendar c = Calendar.getInstance();
		c.setTimeZone(TimeZone.getTimeZone("GMT+7"));

		c.set(Calendar.AM_PM, Calendar.AM_PM);
		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, month);
		c.set(Calendar.DAY_OF_MONTH, day);
		c.set(Calendar.HOUR, hour);
		c.set(Calendar.MINUTE, minute);
		c.set(Calendar.SECOND, 0);
		c.set(Calendar.MILLISECOND, 0);
		int a = (int) (c.getTimeInMillis() / 1000L);
		c.clear();
		return a;
	}

	int tsToYmd(int timestamp, int endstamp) {

		int tempts = endstamp - timestamp;
		tempts = tempts / 60;
		long ts = tempts * 1000L;
		Date d = new java.util.Date(ts);
		// create a calendar object and set the time
		Calendar cal = Calendar.getInstance();
		cal.get(Calendar.HOUR);
		cal.setTime(d);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		int hour = cal.get(Calendar.HOUR);
		int min = cal.get(Calendar.MINUTE);

		String temp = year + "/" + month + "/" + day;
		return tempts;
	}

	public static String convertToTime(int timestamp) {
		// create a date object
		long ts = timestamp * 1000L;
		Date d = new java.util.Date(ts);
		// create a calendar object and set the time
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		String temp = cal.get(Calendar.HOUR_OF_DAY) + "." + cal.get(Calendar.MINUTE);
		return temp;
	}

	public static String convertToDate(int timestamp) {
		long ts = timestamp * 1000L;
		Date d = new java.util.Date(ts);
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		// String temp = year + "/" + month + "/" + day;
		String temp = day + " " + month;
		return temp;
	}

	public static int convertToMonth(int timestamp) {
		long ts = timestamp * 1000L;
		Date d = new java.util.Date(ts);
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		int month = cal.get(Calendar.MONTH) + 1;
		return month;
	}

	public static String convertToDayofMonth(int timestamp) {
		long ts = timestamp * 1000L;
		Date d = new java.util.Date(ts);
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		int day = cal.get(Calendar.DAY_OF_MONTH);
		return pad(day);
	}

	public static int convertToYear(int timestamp) {
		long ts = timestamp * 1000L;
		Date d = new java.util.Date(ts);
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		int year = cal.get(Calendar.YEAR);
		return year;
	}

	public static int getTimeStamp() {
		Calendar c = Calendar.getInstance();
		return DateUtils1.componentTimeToTimestamp(c.get(Calendar.YEAR), c.get(Calendar.MONTH), c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.HOUR),
				c.get(Calendar.MINUTE), c.get(Calendar.AM_PM));
	}
}