/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.register;

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
import com.promptnow.rdsmart.api.model.ConfirmRegisterationOutputModel;
import com.promptnow.rdsmart.api.model.ConfirmRegisterationOutputModel.ConfirmRegisterationData;
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
@BusinessProcess("RG_Confirm_Form")
public class RG_Confirm_Form extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    RG_Confirm_Form_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    RG_Confirm_Form_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new RG_Confirm_Form_ResponseModel();
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
            ConfirmRegisterationOutputModel wsRes = ws.confirmRegisteration(reqObject.nid, reqObject.language, reqObject.buildName, reqObject.roomNo, reqObject.floorNo, reqObject.addressNo, reqObject.soi, reqObject.village, reqObject.mooNo, reqObject.street, reqObject.tambol, reqObject.amphur, reqObject.province, reqObject.postcode, reqObject.contractNo);
            
            if(wsRes.isSuccess()){
                resObject.responsData = wsRes.responseData;
                resObject.setCaseSuccess(SUCCESS);
            }else{
                resObject.setCaseError(reqObject, CODE_BU_FAIL, wsRes.responseError);
            }
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(RG_Confirm_Form.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, RG_Confirm_Form_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}   
// <editor-fold defaultstate="collapsed" desc="Request Response Model"> 
class RG_Confirm_Form_RequestModel extends CommonRequestModel{
    public String buildName;
    public String roomNo;
    public String floorNo;
    public String addressNo;
    public String village;
    public String mooNo;
    public String street;
    public String tambol;
    public String amphur;
    public String province;
    public String postcode;
    public String contractNo;
    
    public String soi;
} 

class RG_Confirm_Form_ResponseModel extends CommonResponseModel{
    
    public ConfirmRegisterationData responsData;
    
    public RG_Confirm_Form_ResponseModel() {
        super();
    }
    
    public RG_Confirm_Form_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}



// </editor-fold> 
