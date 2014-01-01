/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.service;



import com.google.gson.Gson;
import com.promptnow.framework.vulcan.VulcanCore;
import com.promptnow.rdsmart.api.model.AuthenticateUserIdInputModel;
import com.promptnow.rdsmart.api.model.AuthenticateUserIdOutputModel;
import com.promptnow.rdsmart.api.model.ChangeOnlyPasswordInputModel;
import com.promptnow.rdsmart.api.model.ChangeOnlyPasswordOutputModel;
import com.promptnow.rdsmart.api.model.ChangePasswordInputModel;
import com.promptnow.rdsmart.api.model.ChangePasswordOutputModel;
import com.promptnow.rdsmart.api.model.CheckNewUserInputModel;
import com.promptnow.rdsmart.api.model.CheckNewUserOutputModel;
import com.promptnow.rdsmart.api.model.CheckStatusInputModel;
import com.promptnow.rdsmart.api.model.CheckStatusOutputModel;
import com.promptnow.rdsmart.api.model.CheckTempTaxFormInputModel;
import com.promptnow.rdsmart.api.model.CheckTempTaxFormOutputModel;
import com.promptnow.rdsmart.api.model.ChosenCounterServiceInputModel;
import com.promptnow.rdsmart.api.model.ChosenCounterServiceOutputModel;
import com.promptnow.rdsmart.api.model.CommonAPIInputModel;
import com.promptnow.rdsmart.api.model.ConfirmQuestionInputModel;
import com.promptnow.rdsmart.api.model.ConfirmQuestionOutputModel;
import com.promptnow.rdsmart.api.model.ConfirmRegisterationInputModel;
import com.promptnow.rdsmart.api.model.ConfirmRegisterationOutputModel;
import com.promptnow.rdsmart.api.model.ConfirmRequestPasswordInputModel;
import com.promptnow.rdsmart.api.model.ConfirmRequestPasswordOutputModel;
import com.promptnow.rdsmart.api.model.DeleteFormInputModel;
import com.promptnow.rdsmart.api.model.DeleteFormOutputModel;
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
import com.promptnow.rdsmart.api.model.SaveRegisterationInputModel;
import com.promptnow.rdsmart.api.model.SaveRegisterationOutputModel;
import com.promptnow.rdsmart.api.model.SendSatisfactionInputModel;
import com.promptnow.rdsmart.api.model.SendSatisfactionOutputModel;
import com.promptnow.rdsmart.api.model.UpdatePnd91CalTaxInputModel;
import com.promptnow.rdsmart.api.model.UpdatePnd91CalTaxOutputModel;
import com.promptnow.rdsmart.api.model.UpdateTaxPayerProfileInputModel;
import com.promptnow.rdsmart.api.model.UpdateTaxPayerProfileOutputModel;
import com.promptnow.rdsmart.model.MaskFieldModel;
import com.sun.org.apache.bcel.internal.generic.AALOAD;
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
                result = EntityUtils.toString(httpEntity,"UTF-8");
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
        
    public SaveRegisterationOutputModel saveRegisteration(String nid,
            String name,String surname,String birthDate,String passportNo,String countryCode,
            String fatherName,String motherName,String telephone,String telephoneExtension,
            String password,String questionId,String answer,String email,String moiFlag) throws Exception{
        
        SaveRegisterationInputModel req = new SaveRegisterationInputModel();
        SaveRegisterationOutputModel res = new SaveRegisterationOutputModel();
        
        req.nid = nid;
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
        res = gson.fromJson(result, SaveRegisterationOutputModel.class);
        return res;
    }
    
    public UpdateTaxPayerProfileOutputModel updateTaxPayerProfile(String nid, String authenKey, String name, String surname, String buildName, String roomNo, String floorNo, String addressNo, String soi, String village, String mooNo, String street, String tambol, String amphur, String province, String postcode, String taxpayerStatus, String spouseStatus, String marryStatus, String spouseNid, String spouseName, String spouseSurname, String childNoStudy, String childStudy, String txpFatherPin, String txpMotherPin, String spouseFatherPin, String spouseMotherPin) throws Exception {
        UpdateTaxPayerProfileInputModel req = new UpdateTaxPayerProfileInputModel(nid, apiVersion, authenKey, name, surname, buildName, roomNo, floorNo, addressNo, soi, village, mooNo, street, tambol, amphur, province, postcode, taxpayerStatus, spouseStatus, marryStatus, spouseNid, spouseName, spouseSurname, childNoStudy, childStudy, txpFatherPin, txpMotherPin, spouseFatherPin, spouseMotherPin);
        UpdateTaxPayerProfileOutputModel res = new UpdateTaxPayerProfileOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_UPDATETAXPAYERPROFILE");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, UpdateTaxPayerProfileOutputModel.class);
        return res;
    }
    
    public DeleteFormOutputModel deleteForm(String nid, String authenKey, String sysRefNo) throws Exception {
        DeleteFormInputModel req = new DeleteFormInputModel(nid, authenKey, sysRefNo, apiVersion);
        DeleteFormOutputModel res = new DeleteFormOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_DELETEFORM");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, DeleteFormOutputModel.class);
        return res;
    }

    public ResetPasswordRequestOutputModel resetPasswordRequest(String nid, String birthDate) throws Exception {
        ResetPasswordRequestInputModel req = new ResetPasswordRequestInputModel(nid, birthDate, apiVersion);
        ResetPasswordRequestOutputModel res = new ResetPasswordRequestOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_RESETPASSWORDREQUEST");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ResetPasswordRequestOutputModel.class);
        return res;
    }

    public ResetPasswordConfirmOutputModel resetPasswordConfirm(String nid, String email) throws Exception {
        ResetPasswordConfirmInputModel req = new ResetPasswordConfirmInputModel(nid, email, apiVersion);
        ResetPasswordConfirmOutputModel res = new ResetPasswordConfirmOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_RESETPASSWORDCONFIRM");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ResetPasswordConfirmOutputModel.class);
        return res;
    }
    
    public ConfirmQuestionOutputModel confirmQuestion(String nid, String answer, String questionId) throws Exception {
        ConfirmQuestionInputModel req = new ConfirmQuestionInputModel(nid, answer, questionId, apiVersion);
        ConfirmQuestionOutputModel res = new ConfirmQuestionOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_CONFIRMQUESTION");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ConfirmQuestionOutputModel.class);
        return res;
    }
    
    public ChangeOnlyPasswordOutputModel changeOnlyPassword(String nid, String password) throws Exception {
        ChangeOnlyPasswordInputModel req = new ChangeOnlyPasswordInputModel(nid, password, apiVersion);
        ChangeOnlyPasswordOutputModel res = new ChangeOnlyPasswordOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_CHANGEONLYPASSWORD");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ChangeOnlyPasswordOutputModel.class);
        return res;
    }
    
    public ConfirmRequestPasswordOutputModel confirmRequestPassword(String nid, String name, String surName, String birthDate, String fatherName, String motherName) throws Exception {
        ConfirmRequestPasswordInputModel req = new ConfirmRequestPasswordInputModel(nid, name, surName, birthDate, fatherName, motherName, apiVersion);
        ConfirmRequestPasswordOutputModel res = new ConfirmRequestPasswordOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_CONFIRMREQUESTPASSWORD");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ConfirmRequestPasswordOutputModel.class);
        return res;
    }

    public AuthenticateUserIdOutputModel authenticateUserId(String userId, String password) throws Exception {
        AuthenticateUserIdInputModel req = new AuthenticateUserIdInputModel(userId, password, apiVersion);
        AuthenticateUserIdOutputModel res = new AuthenticateUserIdOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_AUTHENTICATEUSERID");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, AuthenticateUserIdOutputModel.class);
        return res;
    }

    public ChangePasswordOutputModel changePassword(String userId, String oldPassword, String newPassword) throws Exception {
        ChangePasswordInputModel req = new ChangePasswordInputModel(userId, oldPassword, newPassword);
        ChangePasswordOutputModel res = new ChangePasswordOutputModel();

        String apiUrl = VulcanCore.getConfig("API_URL_CHANGEPASSWORD");

        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ChangePasswordOutputModel.class);
        return res;
    }

    public ConfirmRegisterationOutputModel confirmRegisteration(String nid, String buildName,
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
    
    public SendSatisfactionOutputModel sendSatisfaction(String nid, String authenKey, String value) throws Exception{
        SendSatisfactionInputModel req = new SendSatisfactionInputModel(nid, apiVersion, authenKey, value);
        SendSatisfactionOutputModel res = new SendSatisfactionOutputModel();
        
        String apiUrl = VulcanCore.getConfig("API_URL_SENDSATISFACTION");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, SendSatisfactionOutputModel.class);
        return res;
    }
    
    public PrintFormReceiptOutputModel printFormReceipt(String nid, String authenKey, String formCode, String formType, String taxYear) throws Exception{
        PrintFormReceiptInputModel req = new PrintFormReceiptInputModel(nid, apiVersion, authenKey, formCode, formType, taxYear);
        PrintFormReceiptOutputModel res = new PrintFormReceiptOutputModel();
                
        String apiUrl = VulcanCore.getConfig("API_URL_PRINTFORMRECEIPT");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, PrintFormReceiptOutputModel.class);
        return res;
    }
    
    public UpdatePnd91CalTaxOutputModel updatePnd91CalTax(String nid,String authenKey, String apiRefNo, String netTaxValue, String totTaxValue, String chkRefund, String partyCode, String smsTax) throws Exception{
        UpdatePnd91CalTaxInputModel req = new UpdatePnd91CalTaxInputModel(nid, apiVersion, authenKey, apiRefNo, netTaxValue, totTaxValue, chkRefund, partyCode, smsTax);
        UpdatePnd91CalTaxOutputModel res = new UpdatePnd91CalTaxOutputModel();
        
        String apiUrl = VulcanCore.getConfig("API_URL_UPDATEPND91CALTAX");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, UpdatePnd91CalTaxOutputModel.class);
        return res;
    }
    
    public ChosenCounterServiceOutputModel chosenCounterService(String nid, String authenKey, String fillRefNo) throws Exception{
        ChosenCounterServiceInputModel req = new ChosenCounterServiceInputModel(nid, apiVersion, authenKey, fillRefNo);
        ChosenCounterServiceOutputModel res = new ChosenCounterServiceOutputModel();
        
        String apiUrl = VulcanCore.getConfig("API_URL_CHOSENCOUNTERSERVICE");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, ChosenCounterServiceOutputModel.class);
        return res;
    }
    
    public CheckStatusOutputModel checkStatus(String nid, String authenKey, String name, String surname) throws Exception{
        CheckStatusInputModel req = new CheckStatusInputModel(nid, apiVersion, authenKey, name, surname);
        CheckStatusOutputModel res = new CheckStatusOutputModel();
        
        String apiUrl = VulcanCore.getConfig("API_URL_CHECKSTATUS");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, CheckStatusOutputModel.class);
        return res;
    }

    public GetPnd91CalTaxOutputModel getPnd91CalTaxOutputModel(String nid, String authenKey,String apiRefNo, String whtTax, String incomePayer, String paidTax, String pvdAmtOfAllw, String pvdAmtOfExcept, String expfPd1, String expfPd2, String exAge65, String qpdInc, String sumExeInc, String txpAllw, String spoAllw, String childNoStudy, String getchildNoStudy, String childNoStudyAmt, String childStd, String getchildStudy, String childStudyAmt, String txpFatherPin, String txpMotherPin, String spouseFatherPin, String spouseMotherPin, String txpFatherAmt, String txpMotherAmt, String spouseFatherAmt, String spouseMotherAmt, String insFaMoAmt, String txpFaPinIns, String txpMoPinIns, String spoFaPinIns, String spoMoPinIns, String insAmt, String spoInsAmt, String retireInsAmt, String retireInsAmtResult, String expfPd3, String expfPd4, String intLoan, String otherAmt, String ssfAmt, String sumAllowance, String incBfExp, String expense, String incDedExp, String incBfEdu, String incBfDon, String netIncome, String fiveHundThou, String eduAmt, String donAmt, String propertyAmt, String propertyPrice, String overTax) throws Exception{
        
        GetPnd91CalTaxInputModel req = new GetPnd91CalTaxInputModel(nid, apiVersion, authenKey, apiRefNo, whtTax, incomePayer, paidTax, pvdAmtOfAllw, pvdAmtOfExcept, expfPd1, expfPd2, exAge65, qpdInc, sumExeInc, txpAllw, spoAllw, childNoStudy, getchildNoStudy, childNoStudyAmt, childStd, getchildStudy, childStudyAmt, txpFatherPin, txpMotherPin, spouseFatherPin, spouseMotherPin, txpFatherAmt, txpMotherAmt, spouseFatherAmt, spouseMotherAmt, insFaMoAmt, txpFaPinIns, txpMoPinIns, spoFaPinIns, spoMoPinIns, insAmt, spoInsAmt, retireInsAmt, retireInsAmtResult, expfPd3, expfPd4, intLoan, otherAmt, ssfAmt, sumAllowance, incBfExp, expense, incDedExp, incBfEdu, incBfDon, netIncome, fiveHundThou, eduAmt, donAmt, propertyAmt, propertyPrice, overTax);
        GetPnd91CalTaxOutputModel res = new GetPnd91CalTaxOutputModel();
                
        String apiUrl = VulcanCore.getConfig("API_URL_GETPND91CALTAX");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, GetPnd91CalTaxOutputModel.class);
        return res;
    }
    
    public GetFormPnd91OutputModel getFormPnd91(String nid, String authenKey) throws Exception{
        GetFormPnd91InputModel req = new GetFormPnd91InputModel(nid, authenKey, apiVersion);
        GetFormPnd91OutputModel res = new GetFormPnd91OutputModel();
        
        String apiUrl = VulcanCore.getConfig("API_URL_GETFORMPND91");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, GetFormPnd91OutputModel.class);
        return res;
    }
    
    public CheckTempTaxFormOutputModel checkTempTaxForm(String nid, String authenKey) throws Exception{
        CheckTempTaxFormInputModel req = new CheckTempTaxFormInputModel(nid, apiVersion, authenKey);
        CheckTempTaxFormOutputModel res = new CheckTempTaxFormOutputModel();
        
        String apiUrl = VulcanCore.getConfig("API_URL_CHECKTEMPTAXFORM");
        
        String result = callPostService(gson.toJson(req), apiUrl);
        res = gson.fromJson(result, CheckTempTaxFormOutputModel.class);
        return res;
    }
    
}
