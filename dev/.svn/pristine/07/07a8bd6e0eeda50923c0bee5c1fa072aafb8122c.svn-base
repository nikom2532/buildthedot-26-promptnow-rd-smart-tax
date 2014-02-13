/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.suggest;

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
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Promptnow11
 */
@BusinessProcess("SG_Send_Email")
public class SG_Send_Email extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    SG_Send_Email_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    SG_Send_Email_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new SG_Send_Email_ResponseModel();
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

            resObject.setCaseSuccess(SUCCESS);
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(SG_Send_Email.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, SG_Send_Email_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model">
class SG_Send_Email_RequestModel extends CommonRequestModel{
    public String emailTo;
    public String pdfLink;
} 

class SG_Send_Email_ResponseModel extends CommonResponseModel{
    
    
    public SG_Send_Email_ResponseModel() {
        super();
    }
    
    public SG_Send_Email_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}

// </editor-fold> 
