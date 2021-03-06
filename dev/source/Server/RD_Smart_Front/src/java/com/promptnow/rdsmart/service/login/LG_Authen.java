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
import com.promptnow.rdsmart.api.model.AuthenticateUserIdOutputModel;
import com.promptnow.rdsmart.api.model.AuthenticateUserIdOutputModel.AuthenticateUserIdData;
import com.promptnow.rdsmart.api.service.RDWebService;
import com.promptnow.rdsmart.db.UserProfileDB;
import com.promptnow.rdsmart.db.UserProfileDB.UserProfile;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.ArrayList;
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
        if(isEmpty(resObject.sessionID)){
            resObject.sessionID = generateSessionID();
            request.getSession().setAttribute("sessionID", resObject.sessionID);
        }
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
            RDWebService ws = new RDWebService(requestID);
            AuthenticateUserIdOutputModel wsRes = ws.authenticateUserId(reqObject.nid, reqObject.password, reqObject.language);
            
            if(wsRes.isSuccess()){
                if(!isEmpty(wsRes.thaiNation)){
                    wsRes.responseData.thaiNation = wsRes.thaiNation;
                }
                resObject.responseData = wsRes.responseData;
                resObject.setCaseSuccess(SUCCESS);
            }else{
                resObject.setCaseError(reqObject, CODE_BU_FAIL, wsRes.responseError);
                return SUCCESS;
            }
            //resObject.loginFirst = "1";
            //resObject.lastAccessed = getDateTimeSQLServer();
            
            resObject.termsConditionDetail = "";
            resObject.displaySatisfication = "0";
            resObject.titleNameHash = new ArrayList<titleNameHash>();
            resObject.timeCurrent = getUnixTimeString();
            
            resObject.titleNameHash.add(new titleNameHash("0", "นาย"));
            resObject.titleNameHash.add(new titleNameHash("1", "นางสาว"));
            resObject.titleNameHash.add(new titleNameHash("2", "นาง"));
            resObject.titleNameHash.add(new titleNameHash("3", "จ.ส.ต"));
            resObject.titleNameHash.add(new titleNameHash("4", "จ.ส.ท"));
            resObject.titleNameHash.add(new titleNameHash("5", "จ.ส.อ"));
            
            
            // UserProfile
            UserProfileDB db = new UserProfileDB();
            UserProfile[] userProfileArr = db.getUserProfile(resObject.responseData.nid);
            
            if(userProfileArr.length ==0){
                resObject.loginFirst = "1";
                db.insertUserProfile(resObject.responseData.nid, resObject.responseData.nid, reqObject.deviceID, getDeviceID(reqObject.deviceType),
                        getUserAgent(), getDateTimeSQLServer(), resObject.sessionID, getDateTimeSQLServer(), getUnixTimeString(), resObject.responseData.authenKey);
            }else{
                resObject.loginFirst = "0";
                resObject.lastAccessed = userProfileArr[0].LAST_ACCESS;
                db.updateUserProfile(resObject.responseData.nid, reqObject.deviceID, getDeviceID(reqObject.deviceType),
                        getUserAgent(), getDateTimeSQLServer(), resObject.sessionID, getUnixTimeString(), resObject.responseData.nid, resObject.responseData.authenKey);
            
            }     
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
    
    public AuthenticateUserIdData responseData;
    public String loginFirst;
    public String termsConditionDetail;
    public String displaySatisfication;
    public String lastAccessed;
    public String timeCurrent;
    
    public ArrayList<titleNameHash> titleNameHash;
    
    public LG_Authen_ResponseModel() {
        super();
    }
    
    public LG_Authen_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}

class titleNameHash{
    public String titleId;
    public String titleNameHash;

    public titleNameHash(String titleId, String titleNameHash) {
        this.titleId = titleId;
        this.titleNameHash = titleNameHash;
    } 
}


// </editor-fold> 
