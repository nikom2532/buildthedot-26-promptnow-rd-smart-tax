/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.login;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Input;
import com.promptnow.framework.vulcan.annotation.Internal;
import com.promptnow.framework.vulcan.annotation.JSON;
import com.promptnow.framework.vulcan.annotation.PostProcess;
import com.promptnow.framework.vulcan.annotation.PreProcess;
import com.promptnow.framework.vulcan.annotation.Render;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.framework.vulcan.plugin.message.Message;
//import com.promptnow.rdsmart.db.UserProfileDB;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Promptnow11
 */
@BusinessProcess("LG_Logout")
public class LG_Logout extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    LG_Logout_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    LG_Logout_ResponseModel resObject = null;   
        
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new LG_Logout_ResponseModel();
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
            /*
            // Check Session
            UserProfileDB db = new UserProfileDB();
            int dbResult =  db.updateUserLogoutTime(reqObject.username);
            if(dbResult == 0){
                log.warn("Logout User not found");
            }*/
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(LG_Logout.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, LG_Logout_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}    
    
// <editor-fold defaultstate="collapsed" desc="Request Response Model"> 
class LG_Logout_RequestModel extends CommonRequestModel{
} 

class LG_Logout_ResponseModel extends CommonResponseModel{
    
    public LG_Logout_ResponseModel() {
        super();
    }
    
    public LG_Logout_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}


// </editor-fold> 
