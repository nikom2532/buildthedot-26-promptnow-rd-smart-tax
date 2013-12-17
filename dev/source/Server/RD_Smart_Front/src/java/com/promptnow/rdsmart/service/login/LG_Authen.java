/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.login;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Config;
import com.promptnow.framework.vulcan.annotation.Input;
import com.promptnow.framework.vulcan.annotation.Internal;
import com.promptnow.framework.vulcan.annotation.JSON;
import com.promptnow.framework.vulcan.annotation.PostProcess;
import com.promptnow.framework.vulcan.annotation.PreProcess;
import com.promptnow.framework.vulcan.annotation.Render;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.framework.vulcan.plugin.message.Message;
import com.promptnow.rdsmart.api.model.AuthenticateUserIdOutputModel;
import com.promptnow.rdsmart.api.model.AuthenticateUserIdOutputModel.AuthenticateUserIdData;
import com.promptnow.rdsmart.api.service.RDWebService;
import com.promptnow.rdsmart.db.UserProfileDB;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Promptnow11
 */
@BusinessProcess("LG_Authen")
public class LG_Authen extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    LG_Authen_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    LG_Authen_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new LG_Authen_ResponseModel();
        resObject.sessionID = reqObject.sessionID;
        debug(this.getClass()+" : "+jsonInput); 
        return SUCCESS;
    }    
    
    @PostProcess
    public String postExecute(VulcanHashParameter vhp) throws VulcanException {   
        jsonOutput = getJSONMask(resObject);
        debug(this.getClass()+" : "+jsonOutput);   
        return SUCCESS;
    }
	
    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        try{
            // Validate Paramenter
            if(isEmpty(reqObject.nid) || isEmpty(reqObject.password)){
                logRemark = "Invalid Parameter";
                resObject.setResponse(STATUS_FAIL, CODE_BU_FAIL, Message.get(reqObject.language,"INVALID_PARAMETER"));
                return SUCCESS;                
            }
            // Call Webservice
            RDWebService ws = new RDWebService();
            AuthenticateUserIdOutputModel wsRes = ws.AuthenticateUserId(reqObject.nid, reqObject.password);
            
            if(wsRes.isSuccess()){
                resObject.responsData = wsRes.responseData;
                resObject.setCaseSuccess(SUCCESS);
            }else{
                resObject.setCaseError(reqObject, CODE_BU_FAIL, wsRes.responseError);
            }
            
            /*
                
                // Update UserProfile
                UserProfileDB db = new UserProfileDB();
                int result = db.updateUserProfile(resObject.psbId, reqObject.deviceID, getDeviceID(reqObject.deviceType), getUserAgent(),reqObject.sessionID,
                        getUnixTimeString(),reqObject.username);
                log.debug(result);
                if(result == 0){
                    db.insertUserProfile(resObject.psbId, reqObject.username, reqObject.deviceID, getDeviceID(reqObject.deviceType),getUserAgent(),reqObject.sessionID,
                        getUnixTimeString());
                }
  
             */
                //resObject.setCaseSuccess(SUCCESS);
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(LG_Authen.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, LG_Authen_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}    
    
    
// <editor-fold defaultstate="collapsed" desc="Request Response Model"> 
class LG_Authen_RequestModel extends CommonRequestModel{
    public String password;
} 

class LG_Authen_ResponseModel extends CommonResponseModel{
    
    public AuthenticateUserIdData responsData;
    
    public LG_Authen_ResponseModel() {
        super();
    }
    
    public LG_Authen_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}



// </editor-fold> 
