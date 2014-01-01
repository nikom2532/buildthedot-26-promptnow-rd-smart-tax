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
import com.promptnow.rdsmart.api.model.PrintFormReceiptOutputModel;
import com.promptnow.rdsmart.api.model.PrintFormReceiptOutputModel.PrintFormReceiptData;
import com.promptnow.rdsmart.api.service.RDWebService;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Promptnow11
 */
@BusinessProcess("FL_Print_FormReceipt")
public class FL_Print_FormReceipt extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    FL_Print_FormReceipt_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    FL_Print_FormReceipt_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new FL_Print_FormReceipt_ResponseModel();
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
            RDWebService ws = new RDWebService();
            PrintFormReceiptOutputModel wsRes = ws.printFormReceipt(reqObject.nid, reqObject.authenKey, reqObject.formCode, reqObject.formType, reqObject.taxYear);
            
            if(wsRes.isSuccess()){
                resObject.responseData = wsRes.responseData;
                resObject.setCaseSuccess(SUCCESS);
            }else{
                resObject.setCaseError(reqObject, CODE_BU_FAIL, wsRes.responseError);
            }
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(FL_Print_FormReceipt.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, FL_Print_FormReceipt_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
} 
// <editor-fold defaultstate="collapsed" desc="Request Response Model">
class FL_Print_FormReceipt_RequestModel extends CommonRequestModel{
    public String authenKey;
    public String formCode;
    public String formType;
    public String taxYear;
} 

class FL_Print_FormReceipt_ResponseModel extends CommonResponseModel{
    public PrintFormReceiptData responseData;
    public FL_Print_FormReceipt_ResponseModel() {
        super();
    }
    
    public FL_Print_FormReceipt_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}
// </editor-fold> 
