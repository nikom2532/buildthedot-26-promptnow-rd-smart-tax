package com.revenuedepartment.app;

import java.util.Calendar;
import java.util.Locale;
import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.TextView;


public class testDatePickerDialog2 extends Activity {
   private TextView tvDisplayDate;
   private DatePicker dpResult;
   private Button btnChangeDate; 
   private int year;
   private int month;
   private int day;
   private String str;
   public static long UTC (int year, int month, int day, int hour, int minute, int second) {
       return 1;
   }

   static final int DATE_DIALOG_ID = 999;

   //private static final  int August =4;

   @Override
   public void onCreate(Bundle savedInstanceState) {
       super.onCreate(savedInstanceState);
       setContentView(R.layout.test_datepickerdialog2);
       setCurrentDateOnView();
       addListenerOnButton();
   }

   // display current date
   public void setCurrentDateOnView() {

       tvDisplayDate = (TextView) findViewById(R.id.tvDate);
       dpResult = (DatePicker) findViewById(R.id.dpResult);

       final Calendar c = Calendar.getInstance();
       year = c.get(Calendar.YEAR);
       month = c.get(Calendar. MONTH);
       day = c.get(Calendar.DAY_OF_MONTH);
     str=c.getDisplayName(c.MONTH, 2, Locale.US);

              // set current date into textview
       tvDisplayDate.setText(new StringBuilder()
       // Month is 0 based, just add 1
       .append(month + 1).append("-").append(day).append("-")
       .append(year).append(" "));

       // set current date into datepicker
       dpResult.init(year, month, day, null);
   } 
   public void addListenerOnButton() {

       btnChangeDate = (Button) findViewById(R.id.btnChangeDate); 
       btnChangeDate.setOnClickListener(new OnClickListener() { 


           @SuppressWarnings("deprecation")
		public void onClick(View v) { 
               showDialog(DATE_DIALOG_ID);
           }
       });
   }

   @Override
   protected Dialog onCreateDialog(int id) {
       switch (id) {
           case DATE_DIALOG_ID:
               // set date picker as current date
               return new DatePickerDialog(this, datePickerListener,year, month,day);
       }
       return null;
   } 
   private DatePickerDialog.OnDateSetListener datePickerListener = new DatePickerDialog.OnDateSetListener() {

       // when dialog box is closed, below method will be called.
       public void onDateSet(DatePicker view, int selectedYear,int selectedMonth, int selectedDay) {
           year = selectedYear;
           month = selectedMonth;
           day = selectedDay;

           // set selected date into textview
           tvDisplayDate.setText(new StringBuilder().append(str + 1)
                   .append("-").append(day).append("-").append(year)
                   .append(" "));

           // set selected date into datepicker also
           dpResult.init(year, month, day, null);
       }
   };
   
}