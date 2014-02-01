/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.google.gson.Gson;
import com.promptnow.framework.vulcan.VulcanProcess;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.rdsmart.db.EventLoggingDB;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.model.MaskFieldModel;
import com.promptnow.security.MessageDigest;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author Promptnow11
 */
public abstract class BaseService extends VulcanProcess {
    
    protected static Map<String, String> USER_SESSION = new HashMap<String, String>();
    
    protected static final String KEY = "0123456789ABCDEF0123456789ABCDEF";
    protected static final String THAI = "TH";
    protected static final String ENG = "EN";
    protected static final String STATUS_SUCCESS = "SUCCESS";
    protected static final String STATUS_FAIL = "FAIL";
    protected static final String STATUS_ERROR = "ERROR";    
    protected static final String STATUS_TIMEOUT = "TIMEOUT";
    
    protected static final String CODE_WS_FAIL = "-1";
    protected static final String CODE_BU_FAIL = "-2";
       
    public final String REQUEST = "request";
    public final String RESPONSE = "response";

    protected String jsonInput = "";
    protected String jsonOutput = "";    
    protected String logRequest = null;
    protected String logResponse = null;    
    protected String logRemark = null;    
        
    public static String KEY_ENCRYPT_DB = "EC3CC66C2BD487787BDC18DC56331605A1E714DBC46173EAC50ACD7878AA2BBF";
    public final String KEY_ENCRYPT = "_key_encrypt";
    public final String KEY_DECRYPT = "_key_decrypt"; 
    public final String KEY_SESSION_ID = "_session_id";    
    
    private static SecureRandom secureRandom = new SecureRandom();
    private static String lastGenSessionID = "";    
    
    public static HashMap<String, Integer> DEVICE_MASTER_MAPPING = new HashMap<String, Integer>();
    
    protected String generateSessionID() {
        return MessageDigest.SHA256(lastGenSessionID + secureRandom.nextFloat());
    }    
    
    // <editor-fold defaultstate="collapsed" desc="Utility Method">     
    
    
    protected String getRealIP(){
        //String ipaddress = request.getHeader("HTTP_X_FORWARDED_FOR");
        //if (ipaddress  == null) ipaddress = request.getRemoteAddr();        
        //return ipaddress;
        String ipaddress = "";
        if((request.getHeader("proxy-ip") != null &&request.getHeader("proxy-ip").length() > 0)){
            ipaddress = request.getHeader("proxy-ip");
        }else if((request.getHeader("x-forwarded-for") != null &&request.getHeader("x-forwarded-for").length() > 0)){
            ipaddress = request.getHeader("x-forwarded-for");
        }else{
            ipaddress = request.getRemoteAddr();
        }
        return ipaddress;
    }
    
    protected static boolean checkReturnCd(String returnCd) {
        boolean result = false;
        if (returnCd.equals("0") || returnCd.equals("") || returnCd.toLowerCase().equals("ok")) {
            result = true;
        } else {
            result = false;
        }

        return result;
    }

    protected void setSessionAttribute(String name, Object obj) {
        request.getSession().setAttribute(name, obj);
    }

    protected String getSessionAttribute(String name) {
        if (request.getSession().getAttribute(name) != null) {
            return request.getSession().getAttribute(name).toString();
        } else {
            return null;
        }
    }

    protected String getDateTimeSQLServer() {
        Date date = new Date();
        Locale local = new Locale("en", "US");
        DateFormat dfm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", local);
        return dfm.format(date);
    }    
    
    protected String getUnixTimeString() {
        long unixTime = System.currentTimeMillis() / 1000L;
        return String.valueOf(unixTime);
    }
    
    protected long getUnixTime() {
        long unixTime = System.currentTimeMillis() / 1000L;
        return unixTime;
    }

    protected String getSession() {
        return request.getSession().getId();
    }

    protected String[] getRequestParameterValues(String name) {
        return request.getParameterValues(name);
    }

    protected String getRequestAttribute(String name) {
        return request.getParameter(name);
    }

    protected String getSerivceName() {
        String service = request.getRequestURI().substring(request.getContextPath().length(), request.getRequestURI().length());
        String[] temp = service.split("/");
        int len = temp.length;
        service = temp[len - 1];
        service = service.replaceAll(".service", "");
        return service;
    }

    protected String getIPAddress() {
        String ip = request.getRemoteAddr();
        return ip;
    }

    public static boolean isEmpty(String source) {
        return source == null || source.trim().equals("");
    }

    public static String convertStreamToString(InputStream is) throws IOException {
        /*
         * To convert the InputStream to String we use the
         * Reader.read(char[] buffer) method. We iterate until the
         * Reader return -1 which means there's no more data to
         * read. We use the StringWriter class to produce the string.
         */
        if (is != null) {
            Writer writer = new StringWriter();
            char[] buffer = new char[1024];
            try {
                Reader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                int n;
                while ((n = reader.read(buffer)) != -1) {
                    writer.write(buffer, 0, n);
                }
            } finally {
                is.close();
            }
            return writer.toString();
        } else {
            return "";
        }
    }

    protected final byte[] getInputBytes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	int CONTENT_LENGTH = request.getContentLength();
        if( CONTENT_LENGTH < 1 ) CONTENT_LENGTH = 4096;
	byte[] buffer = new byte[ CONTENT_LENGTH ];
	int offset = 0, num_read = 0;
	BufferedInputStream in = new BufferedInputStream( request.getInputStream() );
	while( offset < buffer.length && (num_read = in.read(buffer, offset, buffer.length-offset)) != -1)offset += num_read;
	return arrayCopy( buffer, offset );
    }

    protected final byte[] arrayCopy( byte[] source, int length ) {
        byte[] buffer = new byte[ length ];
	System.arraycopy( source, 0, buffer, 0, length );
	return buffer;
    }
    
    // </editor-fold>
     
    // <editor-fold defaultstate="collapsed" desc="Mark Data">   
    
    public static String maskCreditCard(String ccNo){
        return   ccNo.subSequence(0, 6)+"XXXXXX"+ccNo.subSequence(ccNo.length()-4, ccNo.length());
    }
    
    protected String markEmail(String email){
        return email.replaceAll(".+@", "********@");
    }
    
    protected String getJSONMask(Object obj){
        Gson gson = new Gson();
        return maskPassword(gson.toJson(obj));
    }
    
    private String maskPassword(String text){
        String re = text.trim();
        Gson gson = new Gson();
        MaskFieldModel maskFieldModel = gson.fromJson(re, MaskFieldModel.class);
        if(maskFieldModel.password!=null){
            re = re.replace("\""+maskFieldModel.password+"\"", "---MASK---");
        }
        if(maskFieldModel.newPass!=null){
            re = re.replace("\""+maskFieldModel.newPass+"\"", "---MASK---");
        }
        return re;
    }    
    
    protected String markMobileOTP(String data){
        // 08x-xxx-1234
        String mark = "08x-xxx-xxxx";
        try{
            if(data != null){
                if(data.length()==10){
                    return data.substring(0, 1)+"x-xxxx-"+data.substring(6,10);
                }else if(data.length()==11){
                    return "0x-xxxx-"+data.substring(7, 11);
                }else{
                    return mark;
                }
            }else{
                return mark;
            }
        }catch(Exception ex){
            log.error(ex);
            return mark;
        }
    }
    
    // </editor-fold> 
   
    
    
    protected String convertMoneyFormat(String data, int type){
        try{
            String format = "";
            // Type 1 Format #,## 0
            // Type 2 Format #,## 0.00
            // Type 3 Format #0.00
            switch(type){
                case 1 : format = "#,##0"; break;
                case 2 : format = "#,##0.00"; break;
                case 3 : format = "#0.00"; break;
                default: format = "#,##0.00";    
            }  
            if(data == null || data.equals("*")||data.equals("")) return data;
            return new java.text.DecimalFormat(format).format(Double.valueOf(data));
        }catch(Exception e){
            log.warn(e +":" + data);
            return "0.00";
        }    
    }    

    protected String convertMoneyFormat(double data, int type){
        try{ 
            return convertMoneyFormat(String.valueOf(data),type);
        }catch(Exception e){
            log.warn(e +":" + data);
            return "0.00";
        }    
    }    
    
    
    protected boolean noSession(String user, String session){
        boolean status = true;
            if(USER_SESSION.containsKey(user)){
                if(USER_SESSION.get(user).equals(session)){
                    status = false;
                }
            }       
        return status;
    }
    
    
    public static <T> T inject(Object source,Class<T> destType){
        Gson gson = new Gson();
        String sourceString = gson.toJson(source);
        Object re = gson.fromJson(sourceString, destType);
        return destType.cast(re);
    }

    public static  <T> T injectJsonString(String source, Class<T> destType) {
        Gson gson = new Gson();
        Object re = gson.fromJson(source, destType);
        return destType.cast(re);
    }    
 
    // <editor-fold defaultstate="collapsed" desc="Log">     
    
    protected int getDeviceID(String deviceName){
        int re=-1;
        if(DEVICE_MASTER_MAPPING.containsKey(deviceName)){
            re = DEVICE_MASTER_MAPPING.get(deviceName);
        }
        return re;
    }    
    
    protected void writeEventLog(CommonRequestModel req, CommonResponseModel res, VulcanHashParameter vhp){
        try{
            String serviceUri = vhp.get("requestURI").toString();
            EventLoggingDB db = new EventLoggingDB();
            db.insertLog(req.nid, getDateTimeSQLServer(), serviceUri, logRequest, logResponse, getRealIP(), 
                    getDeviceID(req.deviceType), getUserAgent(), req.deviceID, 
                    req.latitude, req.longitude, 
                    res.responseStatus, res.responseCode, res.responseMessage, logRemark, req.sessionID); 
        }catch(Exception ex){
            log.error(ex);
        }
    }    
    
    protected void logInfo(CommonRequestModel requestModel, String keyword, String detail, String  resStatus,String  resCode, String resMsg){
        if(requestModel==null){
            requestModel = new CommonRequestModel();
        }
        if(resStatus.equalsIgnoreCase(CommonResponseModel.STATUS_SUCCESS)){
            resStatus = "S";
        }else if(resStatus.equalsIgnoreCase(CommonResponseModel.STATUS_ERROR)){
            resStatus = "E";
        }
        
        try{
            //EventLogging.info(requestModel.username, 1, "CONSUMER",getServerIP(),getDeviceID(requestModel.deviceType), keyword,"SID="+ requestModel.sessionID+" : "+ detail,requestModel.latitude,requestModel.longitude, requestModel.deviceID, getUserAgent(), resStatus, resCode, resMsg);
        }catch(Exception ex){
            log.error("Add event log error", ex);
        }
    }
    
    protected static void debug(String text){
        if(log!=null){
            log.debug(text);
        }else{
            System.out.println(text);
        }
    }
    
    protected void error(String text, Exception ex){
        if(log!=null){
            log.error(text,ex);
        }else{
            System.out.println(text);
            ex.printStackTrace();
        }
    }    

    protected void logWarn(CommonRequestModel requestModel, String keyword, String detail, String  resStatus,String  resCode, String resMsg){
        if(requestModel==null){
            requestModel = new CommonRequestModel();
        }
        if(resStatus.equalsIgnoreCase(CommonResponseModel.STATUS_SUCCESS)){
            resStatus = "S";
        }else if(resStatus.equalsIgnoreCase(CommonResponseModel.STATUS_ERROR)){
            resStatus = "E";
        }
        try {
            //EventLogging.warn(requestModel.username, 1, "CONSUMER",getServerIP(),getDeviceID(requestModel.deviceType), keyword,"SID="+ requestModel.sessionID+" : "+ detail,requestModel.latitude,requestModel.longitude, requestModel.deviceID, getUserAgent(), resStatus, resCode, resMsg);
        }catch(Exception ex) {
            log.error("Add event log error", ex);
        }
    }

    protected void logError(CommonRequestModel requestModel, String keyword, String detail, String resStatus, String resCode ,String resMsg,Exception e){
        log.error(detail, e);
        if(requestModel==null){
            requestModel = new CommonRequestModel();
        }
        
        if(resStatus.equalsIgnoreCase(CommonResponseModel.STATUS_SUCCESS)){
            resStatus = "S";
        }else if(resStatus.equalsIgnoreCase(CommonResponseModel.STATUS_ERROR)){
            resStatus = "E";
        }
        try {
            //EventLogging.error(requestModel.username, 1, "CONSUMER",getServerIP(),getDeviceID(requestModel.deviceType), keyword,"SID="+ requestModel.sessionID+" : "+detail,requestModel.latitude,requestModel.longitude, requestModel.deviceID, getUserAgent(), resStatus, resCode, resMsg);
        } catch (Exception ex) {
            log.error("Add event log error", ex);
        }
    }
    // </editor-fold>     
    
}
