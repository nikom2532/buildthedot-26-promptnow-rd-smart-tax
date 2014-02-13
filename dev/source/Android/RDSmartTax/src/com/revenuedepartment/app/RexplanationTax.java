package com.revenuedepartment.app;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;

public class RexplanationTax extends Activity {

	private WebView webView;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.rexplanation_tax);

		webView = (WebView) findViewById(R.id.rexplanation_tax);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.loadUrl("http://www.rd.go.th ");
		finish();
	
//		String customHtml = "<html><body><h1>Hello, WebView</h1></body></html>";
//		webView.loadData(customHtml, "text/html", "UTF-8");

	}

}