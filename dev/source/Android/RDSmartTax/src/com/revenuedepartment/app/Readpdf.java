package com.revenuedepartment.app;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.renderscript.Element;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.webkit.WebSettings.PluginState;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.google.gson.Gson;
import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.customview.ButtonCustom;
import com.revenuedepartment.customview.EditTextCustom;
import com.revenuedepartment.customview.TopBar;
import com.revenuedepartment.datapackages.P_CheckUpdateVersion;
import com.revenuedepartment.function.DialogProcess;
import com.revenuedepartment.function.GetDeviceID;
import com.revenuedepartment.function.GetVersionApp;
import com.revenuedepartment.function.PDFTools;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.PopupDialog;
import com.revenuedepartment.function.Validate;
import com.revenuedepartment.function.writeLog;
import com.revenuedepartment.req_datamodels.MRequest_CheckVersion;
import com.revenuedepartment.req_datamodels.MRequest_SendEmail;
import com.revenuedepartment.service.ConnectApi;
import com.revenuedepartment.service.ElementMessage;
import com.revenuedepartment.service.GetMessageError;

public class Readpdf extends Activity implements OnClickListener {
	WebView webview;
	ButtonCustom btSavePDF, btSendEmail;
	String pdfURL = "";
	TopBar topBar;
	GetMessageError messageError;
	PopupDialog popupMessage;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setView();
		messageError = new GetMessageError(Readpdf.this);
		popupMessage = new PopupDialog(Readpdf.this);
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
		// webview.loadUrl("http://docs.google.com/gview?embedded=false&url=" +
		// pdfURL);

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
			EmailDialog emailDialog = new EmailDialog(Readpdf.this);
			emailDialog.show();
		}
	}

	private class EmailDialog extends Dialog implements OnClickListener {
		ButtonCustom btSend;
		EditTextCustom etEmail;

		public EmailDialog(Context context) {
			super(context);
			requestWindowFeature(Window.FEATURE_NO_TITLE);
			setContentView(R.layout.email_dialog);
			btSend = (ButtonCustom) findViewById(R.id.btSend);
			btSend.setDefault();
			btSend.setOnClickListener(this);
			etEmail = (EditTextCustom) findViewById(R.id.etEmail);
		}

		@Override
		public void onClick(View v) {
			if (btSend.equals(v)) {
				if (!Validate.checkBlank(etEmail.getText().toString())) {
					popupMessage.show(messageError.getFieldMessage(ElementMessage.emailEmpty));
					return;
				}
				if (!Validate.isValidEmail(etEmail.getText().toString())) {
					popupMessage.show(messageError.getFieldMessage(ElementMessage.emailWrong));
					return;
				} else {
//					new sendEmail().execute();
				}
			}
		}

		private class sendEmail extends AsyncTask<String, Void, CommonResponseRD> {
			PopupDialog popup = new PopupDialog(Readpdf.this);
			DialogProcess dialog = new DialogProcess(Readpdf.this);
			ConnectApi connApi = new ConnectApi(Readpdf.this);
			MRequest_SendEmail sendEmail = new MRequest_SendEmail();
			String JSONObjSend;

			public sendEmail() {
				sendEmail.deviceID = new GetDeviceID(Readpdf.this).getDeviceID();
				sendEmail.email_to = etEmail.getText().toString();
				sendEmail.pdf_link = pdfURL;
			}

			@Override
			protected void onPreExecute() {
				super.onPreExecute();
				dialog.show();
			}

			@Override
			protected CommonResponseRD doInBackground(String... params) {
				JSONObjSend = new Gson().toJson(sendEmail);
				CommonResponseRD rs = connApi.checkUpdateVersion(JSONObjSend);
				return rs;
			}

			@Override
			protected void onPostExecute(CommonResponseRD result) {
				super.onPostExecute(result);
				dialog.dismiss();
				if (result == null) {
					popup.show("", getString(R.string.system_error));
					writeLog.LogV("error", "error");
				} else {
					if (result.responseCode.equals(CommonResponseRD.CODE_SUCCESS)) {
						popup.show(getString(R.string.label_email_success));
					} else {
						popup.show(result.responseMessage);
					}
				}
			}
		}
	}
}
