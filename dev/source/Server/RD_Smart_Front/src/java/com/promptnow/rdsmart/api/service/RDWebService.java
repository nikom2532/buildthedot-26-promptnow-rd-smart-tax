/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.service;



import com.google.gson.Gson;
import com.promptnow.framework.vulcan.VulcanCore;
import com.promptnow.rdsmart.api.model.AuthenticateUserIdInputModel;
import com.promptnow.rdsmart.api.model.AuthenticateUserIdOutputModel;
import com.promptnow.rdsmart.api.model.ChangePasswordInputModel;
import com.promptnow.rdsmart.api.model.ChangePasswordOutputModel;
import com.promptnow.rdsmart.api.model.CheckNewUserInputModel;
import com.promptnow.rdsmart.api.model.CheckNewUserOutputModel;
import com.promptnow.rdsmart.api.model.CheckTempTaxFormInputModel;
import com.promptnow.rdsmart.api.model.CheckTempTaxFormOutputModel;
import com.promptnow.rdsmart.api.model.CommonAPIInputModel;
import com.promptnow.rdsmart.api.model.ConfirmRegisterationInputModel;
import com.promptnow.rdsmart.api.model.ConfirmRegisterationOutputModel;
import com.promptnow.rdsmart.api.model.GetFormPnd91InputModel;
import com.promptnow.rdsmart.api.model.GetFormPnd91OutputModel;
import com.promptnow.rdsmart.api.model.GetPnd91CalTaxInputModel;
import com.promptnow.rdsmart.api.model.GetPnd91CalTaxOutputModel;
import com.promptnow.rdsmart.api.model.PrintFormReceiptInputModel;
import com.promptnow.rdsmart.api.model.PrintFormReceiptOutputModel;
import com.promptnow.rdsmart.api.model.ResetPasswordConfirmInputModel;
import com.promptnow.rdsmart.api.model.ResetPasswordConfirmOutputModel;
import com.promptnow.rdsmart.api.model.ResetPasswordRequestInputModel;
import com.promptnow.rdsmart.api.model.ResetPasswordRequestOutputModel;
import com.promptnow.rdsmart.api.model.SaveRegisterationFormInputModel;
import com.promptnow.rdsmart.api.model.SaveRegisterationFormOutputModel;
import com.promptnow.rdsmart.api.model.SendSatisfactionInputModel;
import com.promptnow.rdsmart.api.model.SendSatisfactionOutputModel;
import com.promptnow.rdsmart.api.model.UpdatePnd91CalTaxInputModel;
import com.promptnow.rdsmart.api.model.UpdatePnd91CalTaxOutputModel;
import com.promptnow.rdsmart.api.model.UpdateTaxPayerProfileInputModel;
import com.promptnow.rdsmart.api.model.UpdateTaxPayerProfileOutputModel;
import com.promptnow.rdsmart.model.MaskFieldModel;
import java.io.IOException;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;



/**
 *
 * @author Promptnow11
 */
public class RDWebService {
    
    private String apiVersion = "";
    private Gson gson;

    private static int CONNECTION_TIMEOUT = 60000; // millis
    private static int SOCKET_TIMEOUT = 60000; //Millis
    private static String USER_AGENT = "Susanoo/1.0";
    private static String TEMP_RESPONSE_ERROR = "{\"responseStatus\":\"ERROR\",\"responseError\":\"%s\"}";
    
    
    public RDWebService() {
        apiVersion = VulcanCore.getConfig("API_VERSION");
        gson = new Gson();
    }
   
    // <editor-fold defaultstate="collapsed" desc="HTTP Post"> 
    public String callPostService(String data, String url){
        //HTTP.callHTTPPostData(data, data);
        String result = "";
        
        try{
            VulcanCore.logTransaction.info(maskData(data));
            VulcanCore.log.debug("HTTP Request : " + data);
            VulcanCore.log.debug("Call");
            HttpClient  httpClient = new DefaultHttpClient();
            httpClient.getParams().setParameter(CoreProtocolPNames.USER_AGENT, USER_AGENT);
            StringEntity entity = new StringEntity(data, HTTP.UTF_8);       
            entity.setContentType("application/json");
            HttpParams httpParams = httpClient.getParams();
            HttpConnectionParams.setConnectionTimeout(httpParams, CONNECTION_TIMEOUT);
            HttpConnectionParams.setSoTimeout(httpParams, SOCKET_TIMEOUT);            
            HttpPost post = new HttpPost(url);
            post.setEntity(entity);
            HttpResponse response = httpClient.execute(post);
            if (response.getStatusLine().getStatusCode() < 200 || response.getStatusLine().getStatusCode() >= 400) {
                String re = "Got bad response, error code = " + response.getStatusLine().getStatusCode();
                result = String.format(TEMP_RESPONSE_ERROR, re);
                VulcanCore.log.error(re);
                return re;
            }

            HttpEntity httpEntity = response.getEntity();
            if (httpEntity != null) {
                result = EntityUtils.toString(httpEntity);
                EntityUtils.consume(entity);
            }else{
                VulcanCore.log.error("Null entity");
                result = String.format(TEMP_RESPONSE_ERROR, "Empty");
            }
            
        }catch(Exception ex){
            VulcanCore.log.error("Webservice error : "+ex);
        }finally{
            VulcanCore.logTransaction.info(maskData(result));
            VulcanCore.log.debug("HTTP Response : " + result);
            return result;
        }    
    }
    
     private String maskData(String text){
        try{
            String re = text.trim();
            Gson g = new Gson();
            MaskFieldModel maskFieldModel = g.fromJson(re, MaskFieldModel.class);
            if(maskFieldModel.password!=null){
                re = re.replace("\""+maskFieldModel.password+"\"", "---MASK---");
            }
            return re;
        }catch(Exception ex){
            VulcanCore.log.error(ex);
            return text;
        }
    }   
    
    
    // </editor-fold>     
    
    public CheckNewUserOutputModel checkNewUser(String nid) throws Exception{
        CheckNewUserInputModel req = new CheckNewUserInputModel(nid, apiVersion);
        CheckNewUserOutputModel res = new CheckNewUserOutputModel();
        
        String apiUrl = VulcanCore.getConfig("API_URL_CHECKNEWUSER");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, CheckNewUserOutputModel.class);
        return res;
    }
        
    public SaveRegisterationFormOutputModel saveRegisterationForm(
            String name,String surname,String birthDate,String passportNo,String countryCode,
            String fatherName,String motherName,String telephone,String telephoneExtension,
            String password,String questionId,String answer,String email,String moiFlag) throws Exception{
        
        SaveRegisterationFormInputModel req = new SaveRegisterationFormInputModel();
        SaveRegisterationFormOutputModel res = new SaveRegisterationFormOutputModel();
        
        req.name = name;
        req.surname = surname;
        req.birthDate = birthDate;
        req.passportNo = passportNo;
        req.countryCode = countryCode;
        req.fatherName = fatherName;
        req.motherName = motherName;
        req.telephone = telephone;
        req.telephoneExtension = telephoneExtension;
        req.password = password;
        req.questionId = questionId;
        req.answer = answer;
        req.email = email;
        req.moiFlag = moiFlag;
        
        String apiUrl = VulcanCore.getConfig("API_URL_SAVEREGISTERFORM");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, SaveRegisterationFormOutputModel.class);
        return res;
    }
    
    public UpdateTaxPayerProfileOutputModel updateTaxPayerProfile(String nid, String titleName, String name, String surname, String birthDate, String buildName, String roomNo, String floorNo, String addressNo, String soi, String village, String mooNo, String street, String tambol, String amphur, String province, String postcode, String contractNo, String indcForm, String taxpayerStatus, String spouseStatus, String marryStatus, String spouseNid, String spouseName, String spouseSurname, String spouseBirthDate, String spousePassportNo, String spouseCountryCode, String childNoStudy, String childStudy, String txpFatherPin, String txpMotherPin, String spouseFatherPin, String spouseMotherPin) throws Exception {
        UpdateTaxPayerProfileInputModel req = new UpdateTaxPayerProfileInputModel(nid, titleName, name, surname, birthDate, buildName, roomNo, floorNo, addressNo, soi, village, mooNo, street, tambol, amphur, province, postcode, contractNo, indcForm, taxpayerStatus, spouseStatus, marryStatus, spouseNid, spouseName, spouseSurname, spouseBirthDate, spousePassportNo, spouseCountryCode, childNoStudy, childStudy, txpFatherPin, txpMotherPin, spouseFatherPin, spouseMotherPin);
        UpdateTaxPayerProfileOutputModel res = new UpdateTaxPayerProfileOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_UPDATETAXPAYERPROFILE");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, UpdateTaxPayerProfileOutputModel.class);
        return res;
    }

    public ResetPasswordRequestOutputModel ResetPasswordRequest(String nid, String birthDate) throws Exception {
        ResetPasswordRequestInputModel req = new ResetPasswordRequestInputModel(nid, birthDate);
        ResetPasswordRequestOutputModel res = new ResetPasswordRequestOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_RESETPASSWORDREQUEST");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ResetPasswordRequestOutputModel.class);
        return res;
    }

    public ResetPasswordConfirmOutputModel ResetPasswordConfirm(String nid, String email) throws Exception {
        ResetPasswordConfirmInputModel req = new ResetPasswordConfirmInputModel(nid, email);
        ResetPasswordConfirmOutputModel res = new ResetPasswordConfirmOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_RESETPASSWORDCONFIRM");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ResetPasswordConfirmOutputModel.class);
        return res;
    }

    public AuthenticateUserIdOutputModel AuthenticateUserId(String userId, String password) throws Exception {
        AuthenticateUserIdInputModel req = new AuthenticateUserIdInputModel(userId, password, apiVersion);
        AuthenticateUserIdOutputModel res = new AuthenticateUserIdOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_AUTHENTICATEUSERID");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, AuthenticateUserIdOutputModel.class);
        return res;
    }

    public ChangePasswordOutputModel ChangePassword(String userId, String oldPassword, String newPassword) throws Exception {
        ChangePasswordInputModel req = new ChangePasswordInputModel(userId, oldPassword, newPassword);
        ChangePasswordOutputModel res = new ChangePasswordOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_CHANGEPASSWORD");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ChangePasswordOutputModel.class);
        return res;
    }

    public ConfirmRegisterationOutputModel ConfirmRegisteration(String nid, String buildName,
            String roomNo, String floorNo, String addressNo, String soi,
            String village, String mooNo, String street, String tambol,
            String amphur, String province, String postcode, String contractNo) throws Exception {
        ConfirmRegisterationInputModel req = new ConfirmRegisterationInputModel(nid, buildName,
                roomNo, floorNo, addressNo, soi,
                village, mooNo, street, tambol,
                amphur, province, postcode, contractNo);
        ConfirmRegisterationOutputModel res = new ConfirmRegisterationOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_CONFIRMREGISTERATION");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ConfirmRegisterationOutputModel.class);
        return res;
    }
    
    public SendSatisfactionOutputModel sendSatisfaction(String nid, String value) throws Exception{
        SendSatisfactionInputModel req = new SendSatisfactionInputModel();
        SendSatisfactionOutputModel res = new SendSatisfactionOutputModel();
        
        req.nid = nid;
        req.value = value;
        
        String apiUrl = VulcanCore.getConfig("API_URL_SENDSATISFACTION");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, SendSatisfactionOutputModel.class);
        return res;
    }
    
    public PrintFormReceiptOutputModel printFormReceipt(String nid, String formCode, String formType, String taxYear) throws Exception{
        PrintFormReceiptInputModel req = new PrintFormReceiptInputModel();
        PrintFormReceiptOutputModel res = new PrintFormReceiptOutputModel();
        
        req.nid = nid;
        req.formCode = formCode;
        req.formType = formType;
        req.taxYear = taxYear;
        
        String apiUrl = VulcanCore.getConfig("API_URL_PRINTFORMRECEIPT");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, PrintFormReceiptOutputModel.class);
        return res;
    }
    
    public UpdatePnd91CalTaxOutputModel updatePnd91CalTax(String nid, String apiRefNo, String chkRefundTax, String chkParty, String partyCode) throws Exception{
        UpdatePnd91CalTaxInputModel req = new UpdatePnd91CalTaxInputModel();
        UpdatePnd91CalTaxOutputModel res = new UpdatePnd91CalTaxOutputModel();
        
        req.nid = nid;
        req.apiRefNo = apiRefNo;
        req.chkRefundTax = chkRefundTax;
        req.chkParty = chkParty;
        req.partyCode = partyCode;
        
        String apiUrl = VulcanCore.getConfig("API_URL_UPDATEPND91CALTAX");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, UpdatePnd91CalTaxOutputModel.class);
        return res;
    }

    public GetPnd91CalTaxOutputModel getPnd91CalTaxOutputModel(String nid,String apiRefNo,
            String assblInc, String whtTax, String incomePayer, String pvdAmtOfAllw, String pvdAmtOfExcept, String expfPd1,
            String expfPd2, String exAge65, String qpdInc, String allMoneyExempt, String allw, String spoAllw, String childNoStudy,
            String childNoStudyAmt, String childStd, String childStudyAmt, String txpFatherPin, String txpMotherPin, String spouseFatherPin,
            String spouseMotherPin, String txpFatherPinValue, String txpMotherPinValue, String spouseFatherPinValue, String spouseMotherPinValue,
            String calIns, String txpFaPinIns, String txpMoPinIns, String spoFaPinIns, String spoMoPinIns, String insAmt, String insAmtResult,
            String spoInsAmt, String retireInsAmt, String retireInsAmtResult, String expfPd3, String expfPd4, String intLoan, String otherAmt,
            String ssfAmt, String allMoneyAllowances, String eduAmt, String eduAmtResult, String donAmt, String donAmtResult, String propertyAmt,
            String propertyPrice, String overtax) throws Exception{
        
        GetPnd91CalTaxInputModel req = new GetPnd91CalTaxInputModel();
        GetPnd91CalTaxOutputModel res = new GetPnd91CalTaxOutputModel();
        
        req.nid = nid;
        req.apiRefNo = apiRefNo;
        req.assblInc = assblInc;
        req.whtTax = whtTax;
        req.incomePayer = incomePayer;
        req.pvdAmtOfAllw = pvdAmtOfAllw;
        req.pvdAmtOfExcept = pvdAmtOfExcept;
        req.expfPd1 = expfPd1;
        req.expfPd2 = expfPd2;
        req.exAge65 = exAge65;
        req.qpdInc = qpdInc;
        req.allMoneyExempt = allMoneyExempt;
        req.allw = allw;
        req.spoAllw =spoAllw;
        req.childNoStudy = childNoStudy;
        req.childNoStudyAmt = childNoStudyAmt;
        req.childStd = childStd;
        req.childStudyAmt = childStudyAmt;
        req.txpFatherPin = txpFatherPin;
        req.txpMotherPin = txpMotherPin;
        req.spouseFatherPin = spouseFatherPin;
        req.spouseMotherPin = spouseMotherPin;
        req.txpFatherPinValue = txpFatherPinValue;
        req.txpMotherPinValue = txpMotherPinValue;
        req.spouseFatherPinValue = spouseFatherPinValue;
        req.spouseMotherPinValue = spouseMotherPinValue;
        req.calIns = calIns;
        req.txpFaPinIns = txpFaPinIns;
        req.txpMoPinIns = txpMoPinIns;
        req.spoFaPinIns = spoFaPinIns;
        req.spoMoPinIns = spoMoPinIns;
        req.insAmt = insAmt;
        req.insAmtResult = insAmtResult;
        req.spoInsAmt = spoInsAmt;
        req.retireInsAmt = retireInsAmt;
        req.retireInsAmtResult = retireInsAmtResult;
        req.expfPd3 = expfPd3;
        req.expfPd4 = expfPd4;
        req.intLoan = intLoan;
        req.otherAmt = otherAmt;
        req.ssfAmt = ssfAmt;
        req.allMoneyAllowances = allMoneyAllowances;
        req.eduAmt = eduAmt;
        req.eduAmtResult = eduAmtResult;
        req.donAmt = donAmt;
        req.donAmtResult = donAmtResult;
        req.propertyAmt = propertyAmt;
        req.propertyPrice = propertyPrice;
        req.overtax = overtax;
        
        String apiUrl = VulcanCore.getConfig("API_URL_GETPND91CALTAX");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, GetPnd91CalTaxOutputModel.class);
        return res;
    }
    
    public GetFormPnd91OutputModel getFormPnd91(String nid) throws Exception{
        GetFormPnd91InputModel req = new GetFormPnd91InputModel();
        GetFormPnd91OutputModel res = new GetFormPnd91OutputModel();
        
        req.nid = nid;
        
        String apiUrl = VulcanCore.getConfig("API_URL_GETFORMPND91");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, GetFormPnd91OutputModel.class);
        return res;
    }
    
    public CheckTempTaxFormOutputModel checkTempTaxForm(String nid) throws Exception{
        CheckTempTaxFormInputModel req = new CheckTempTaxFormInputModel();
        CheckTempTaxFormOutputModel res = new CheckTempTaxFormOutputModel();
        
        req.nid = nid;
        
        String apiUrl = VulcanCore.getConfig("API_URL_CHECKTEMPTAXFORM");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, CheckTempTaxFormOutputModel.class);
        return res;
    }
    
}
