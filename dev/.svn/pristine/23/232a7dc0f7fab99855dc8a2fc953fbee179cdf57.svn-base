/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.model;

import com.promptnow.framework.vulcan.plugin.message.Message;
import com.promptnow.rdsmart.service.base.BaseService;


/**
 *
 * @author cheng
 */
public class CommonResponseModel {
    
    public static final String STATUS_SUCCESS = "SUCCESS";
    public static final String STATUS_ERROR = "ERROR";
    
    /*
    public static final String ERROR_NO_CLIENT_DATETIME = "NO_CLIENT_DATETIME";
    public static final String ERROR_INVALID_CLIENT_DATETIME = "INVALID_CLIENT_DATETIME";
    public static final String ERROR_REQUEST_IS_NULL = "REQUEST_IS_NULL";
    public static final String ERROR_INVALID_FORMAT = "INPUT_INVALID_FORMAT";
    public static final String ERROR_CALL_BACKEND = "GENERAL_ERROR_CALL_BACKEND";
    public static final String ERROR_EXECUTE_SQL = "GENERAL_ERROR_EXECUTE_SQL";
    public static final String ERROR_OTHER_DEVICE_LOGIN="ERROR_OTHER_DEVICE_LOGIN";
    */
    
    public static final String CODE_SUCCESS = "0";
    
    public String sessionID = "";
    public String responseCode="";
    public String responseStatus="";
    public String responseMessage="";
    
    //public long serverDateTimeMS = 0;
    //public String serverDateTime = "";
    
    public CommonResponseModel(){}
    
    public CommonResponseModel(String status, String code,String msg){
        responseStatus = status;
        responseCode = code;
        responseMessage = msg;
    }
    
    public void setResponse(String status, String code,String msg){
        responseStatus = status;
        responseCode = code;
        responseMessage = msg;
    }
    
    public void setResponseMessage(String message){
        responseMessage = message;
    }
    
    public void setResponseCode(String code){
        responseCode = code;
    }
    
    public void setResponseStatus(String status){
        responseStatus = status;
        if(status.equals(STATUS_SUCCESS)){
            responseCode = CODE_SUCCESS;
        }
    }
    
    public String getResponseStatus(){
        return responseStatus;
    }
    
    public boolean isSuccess(){
        return responseCode.equals(CODE_SUCCESS);
    }
    
    public String getResponseCode(){
        return responseCode;
    }
    
    public String getResponseMessage(){
        return responseMessage;
    }
    
    public void setCaseSuccess(String message){
        responseStatus = STATUS_SUCCESS;
        responseCode = CODE_SUCCESS;
        responseMessage = message;
    }
    
    
    public void setCaseSuccessCode(CommonRequestModel requestModel, String code){
        responseStatus = STATUS_SUCCESS;
        responseCode = code;
        responseMessage = Message.get(requestModel.language, code);    
    }
    
    public void setCaseError(String errorCode, String message){
        responseStatus = STATUS_ERROR;
        responseCode = errorCode;
        responseMessage = message;        
    }
    
    public void setCaseError(CommonRequestModel requestModel, String errorCode, String defaultMessage){        
        responseStatus = STATUS_ERROR;
        responseCode = errorCode;
        if(BaseService.isEmpty(defaultMessage)){
            responseMessage = Message.get(requestModel.language, errorCode, defaultMessage);
        }else{
            responseMessage = defaultMessage;
        }       
    }
    
    public void setCaseErrorCode(CommonRequestModel requestModel, String errorCode){
        responseStatus = STATUS_ERROR;
        responseCode = errorCode;
        responseMessage = Message.get(requestModel.language, errorCode);
        
    }
}