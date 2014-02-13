/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.filling;

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
import com.promptnow.rdsmart.api.model.CheckStatusOutputModel;
import com.promptnow.rdsmart.api.model.CheckStatusOutputModel.FormDetailData;
import com.promptnow.rdsmart.api.service.RDWebService;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Promptnow11
 */
@BusinessProcess("FL_Check_Status")
public class FL_Check_Status extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    FL_Check_Status_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    FL_Check_Status_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new FL_Check_Status_ResponseModel();
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
            if(isEmpty(reqObject.nid)){
                logRemark = "Invalid Parameter";
                resObject.setResponse(STATUS_FAIL, CODE_BU_FAIL, Message.get(reqObject.language,"INVALID_PARAMETER"));
                return SUCCESS;                
            }
            // Call Webservice
            RDWebService ws = new RDWebService(requestID);
            CheckStatusOutputModel wsRes = ws.checkStatus(reqObject.nid, reqObject.authenKey, reqObject.language, reqObject.name, reqObject.surname);
            
            if(wsRes.isSuccess()){
                resObject.message = wsRes.message;
                resObject.formDetailList = wsRes.formDetailList;
                resObject.setCaseSuccess(SUCCESS);
            }else{
                resObject.setCaseError(reqObject, CODE_BU_FAIL, wsRes.responseError);
            }
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(FL_Check_Status.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, FL_Check_Status_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}   
// <editor-fold defaultstate="collapsed" desc="Request Response Model">
class FL_Check_Status_RequestModel extends CommonRequestModel{
    public String name;
    public String surname;
} 

class FL_Check_Status_ResponseModel extends CommonResponseModel{
    public String message;
    public List<FormDetailData> formDetailList;
    public FL_Check_Status_ResponseModel() {
        super();
    }
    
    public FL_Check_Status_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}
// </editor-fold> 
