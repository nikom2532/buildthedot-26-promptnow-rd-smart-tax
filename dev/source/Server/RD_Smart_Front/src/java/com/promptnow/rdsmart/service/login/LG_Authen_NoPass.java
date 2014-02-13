/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.login;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Input;
import com.promptnow.framework.vulcan.annotation.Internal;
import com.promptnow.framework.vulcan.annotation.JSON;
import com.promptnow.framework.vulcan.annotation.Render;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.framework.vulcan.plugin.message.Message;
import com.promptnow.rdsmart.db.UserProfileDB;
import com.promptnow.rdsmart.db.UserProfileDB.checkUserSessionReturn;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Promptnow11
 */
@BusinessProcess("LG_Authen_NoPass")
public class LG_Authen_NoPass extends BaseService{

    @JSON
    @Internal
    @Input(REQUEST)
    LG_Authen_NoPass_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    LG_Authen_NoPass_ResponseModel resObject = null;       
    
    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        try{
            // Validate Paramenter
            if(isEmpty(reqObject.nid) || isEmpty(reqObject.oldSessionID)){
                logRemark = "Invalid Parameter";
                resObject.setResponse(STATUS_FAIL, CODE_BU_FAIL, Message.get(reqObject.language,"INVALID_PARAMETER"));
                return SUCCESS;                
            }
            // Check Session
            UserProfileDB db = new UserProfileDB();
            checkUserSessionReturn[] dbResult =  db.checkUserSession(reqObject.nid, reqObject.oldSessionID);
            if(dbResult.length==0){
                resObject.setResponse(STATUS_FAIL, CODE_BU_FAIL, Message.get(reqObject.language,"LOGIN_FAIL"));
                return SUCCESS;
            }else{
                resObject.authenKey = dbResult[0].AUTHEN_KEY;
                resObject.sessionID = generateSessionID();
                return SUCCESS;
            }
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(LG_Authen_NoPass.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, LG_Authen_NoPass_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    }     
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model"> 
class LG_Authen_NoPass_RequestModel extends CommonRequestModel{
    public String oldSessionID;
} 

class LG_Authen_NoPass_ResponseModel extends CommonResponseModel{
    public String authenKey;
    
    public LG_Authen_NoPass_ResponseModel() {
        super();
    }
    
    public LG_Authen_NoPass_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}
// </editor-fold> 