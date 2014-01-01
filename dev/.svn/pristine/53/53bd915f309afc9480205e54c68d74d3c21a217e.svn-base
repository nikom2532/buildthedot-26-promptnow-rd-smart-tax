package com.revenuedepartment.app;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.function.PDFTools;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.WebSettings.PluginState;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class Readpdf extends Activity implements OnClickListener {
	WebView webview;
	ButtonCustom btSavePDF, btSendEmail;
	String pdfURL = "";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();

	}

	@SuppressWarnings("deprecation")
	@SuppressLint("SetJavaScriptEnabled")
	public void setView() {
		setContentView(R.layout.read_pdf);
		webview = (WebView) findViewById(R.id.webViewPdf);
		btSavePDF = (ButtonCustom) findViewById(R.id.btSavePDF);
		btSendEmail = (ButtonCustom) findViewById(R.id.btSendEmail);

		webview.getSettings().setJavaScriptEnabled(true);
		webview.getSettings().setPluginState(PluginState.ON);
		webview.setWebViewClient(new Callback());
		pdfURL = "http://www.ub.uit.no/iportal/help/pdf.pdf";
		webview.loadUrl("http://docs.google.com/gview?embedded=false&url="
				+ pdfURL);

		btSavePDF.setOnClickListener(this);
		btSendEmail.setOnClickListener(this);
	}

	private class Callback extends WebViewClient {
		@Override
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			return (false);
		}
	}

	@Override
	public void onClick(View v) {
		if (v.equals(btSavePDF)) {
			PDFTools.downloadAndOpenPDF(Readpdf.this, pdfURL);
		} else if (v.equals(btSendEmail)) {

		}
	}
}
