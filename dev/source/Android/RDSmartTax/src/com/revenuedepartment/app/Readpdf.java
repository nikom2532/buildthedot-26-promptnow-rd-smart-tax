package com.revenuedepartment.app;

import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.PDFTools;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.graphics.Bitmap;
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
	TopBar topBar;

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
		topBar = (TopBar) findViewById(R.id.Topbar);
		topBar.setTitle(getString(R.string.label_print));

		
		webview.getSettings().setJavaScriptEnabled(true);
		webview.getSettings().setPluginState(PluginState.ON);
		webview.setWebViewClient(new Callback());
		pdfURL = "http://www.ub.uit.no/iportal/help/pdf.pdf";
		webview.loadUrl("http://docs.google.com/gview?embedded=false&url=" + pdfURL);

		btSavePDF.setOnClickListener(this);
		btSavePDF.setDefault();
		btSendEmail.setOnClickListener(this);
		btSendEmail.setDefault();
	}

	private class Callback extends WebViewClient {
		DialogProcess dialog = new DialogProcess(Readpdf.this);

		@Override
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			return (false);
		}

		@Override
		public void onPageFinished(WebView view, String url) {
			super.onPageFinished(view, url);
			dialog.dismiss();
		}

		@Override
		public void onPageStarted(WebView view, String url, Bitmap favicon) {
			super.onPageStarted(view, url, favicon);
			dialog.show();

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
