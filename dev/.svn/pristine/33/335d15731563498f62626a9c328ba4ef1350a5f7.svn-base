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
import com.promptnow.rdsmart.db.ClientApplication;
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
@BusinessProcess("LG_Update_Version")
public class LG_Update_Version extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    LG_Update_Version_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    LG_Update_Version_ResponseModel resObject = null;   
        
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new LG_Update_Version_ResponseModel();
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
            int dbResult =  db.updateUserUpdate_versionTime(reqObject.username);
            if(dbResult == 0){
                log.warn("Update_version User not found");
            }*/
//            
            ClientApplication ca = new ClientApplication();
            int device = getDeviceID(reqObject.deviceType);
            ClientApplication.ClientVersion[] cv = ca.getClientVersion(String.valueOf(device));
            if(cv.length > 0)
            {
                log.debug("DATA LENGTH : " + cv.length);
                String db_version = null;
                String url = null;
                for(int i=0;i<cv.length;i++)
                {
                    db_version = cv[i].CURRENT_VERSION;
                    url = cv[i].DOWNLOAD_URL;
                }
                log.debug("DATA DB VERSION : " + db_version);
                log.debug("DATA DB VERSION : " + db_version.split("\\.").length);
                log.debug("DATA DB CLIENT : " + reqObject.version);
                log.debug("DATA DB CLIENT : " + reqObject.version.split("\\.").length);
                if(Integer.parseInt(reqObject.version.split("\\.")[0]) < Integer.parseInt(db_version.split("\\.")[0]) ||
                   Integer.parseInt(reqObject.version.split("\\.")[1]) < Integer.parseInt(db_version.split("\\.")[1]) ||
                   Integer.parseInt(reqObject.version.split("\\.")[2]) < Integer.parseInt(db_version.split("\\.")[2]))
                {
                    resObject.newVersion = db_version;
                    resObject.update = "Y";
                    resObject.url = url;
                }
                else
                {
                    resObject.newVersion = null;
                    resObject.update = "N";
                    resObject.url = null;
                }
            }
            else
            {
                log.warn("Update version not found");
                resObject.newVersion = null;
                resObject.update = "N";
                resObject.url = null;
            }
            resObject.setCaseSuccess(SUCCESS);
//            
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(LG_Update_Version.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, LG_Update_Version_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}    
    
// <editor-fold defaultstate="collapsed" desc="Request Response Model"> 
class LG_Update_Version_RequestModel extends CommonRequestModel{
    public String version;
} 

class LG_Update_Version_ResponseModel extends CommonResponseModel{
    public String update;
    public String newVersion;
    public String url;
    public LG_Update_Version_ResponseModel() {
        super();
    }
    
    public LG_Update_Version_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}


// </editor-fold> 
