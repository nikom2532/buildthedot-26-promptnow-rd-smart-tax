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
import com.promptnow.rdsmart.api.model.GetPnd91CalTaxOutputModel;
import com.promptnow.rdsmart.api.model.GetPnd91CalTaxOutputModel.GetPnd91CalTaxData;
import com.promptnow.rdsmart.api.service.RDWebService;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import com.promptnow.rdsmart.service.base.BaseService;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Promptnow11
 */
@BusinessProcess("FL_Get_Pnd91CalTax")
public class FL_Get_Pnd91CalTax extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    FL_Get_Pnd91CalTax_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    FL_Get_Pnd91CalTax_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new FL_Get_Pnd91CalTax_ResponseModel();
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
            GetPnd91CalTaxOutputModel wsRes = ws.getPnd91CalTaxOutputModel(reqObject.nid, reqObject.authenKey, reqObject.language, reqObject.apiRefNo, reqObject.keys);
            //GetPnd91CalTaxOutputModel wsRes = ws.getPnd91CalTaxOutputModel(reqObject.nid, reqObject.authenKey, reqObject.language, reqObject.apiRefNo, reqObject.whtTax, reqObject.incomePayer, reqObject.paidTax, reqObject.pvdAmtOfAllw, reqObject.pvdAmtOfExcept, reqObject.expfPd1, reqObject.expfPd2, reqObject.exAge65, reqObject.qpdInc, reqObject.sumExeInc, reqObject.txpAllw, reqObject.spoAllw, reqObject.childNoStudy, reqObject.getchildNoStudy, reqObject.childNoStudyAmt, reqObject.childStd, reqObject.getchildStudy, reqObject.childStudyAmt, reqObject.txpFatherPin, reqObject.txpMotherPin, reqObject.spouseFatherPin, reqObject.spouseMotherPin, reqObject.txpFatherAmt, reqObject.txpMotherAmt, reqObject.spouseFatherAmt, reqObject.spouseMotherAmt, reqObject.insFaMoAmt, reqObject.txpFaPinIns, reqObject.txpMoPinIns, reqObject.spoFaPinIns, reqObject.spoMoPinIns, reqObject.insAmt, reqObject.spoInsAmt, reqObject.retireInsAmt, reqObject.retireInsAmtResult, reqObject.expfPd3, reqObject.expfPd4, reqObject.intLoan, reqObject.otherAmt, reqObject.ssfAmt, reqObject.sumAllowance, reqObject.incBfExp, reqObject.expense, reqObject.incDedExp, reqObject.incBfEdu, reqObject.incBfDon, reqObject.netIncome, reqObject.fiveHundThou, reqObject.eduAmt, reqObject.donAmt, reqObject.propertyAmt, reqObject.propertyPrice, reqObject.overTax);
            
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
            Logger.getLogger(FL_Get_Pnd91CalTax.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, FL_Get_Pnd91CalTax_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}  

// <editor-fold defaultstate="collapsed" desc="Request Response Model">
class FL_Get_Pnd91CalTax_RequestModel extends CommonRequestModel{
    public String apiRefNo;
    public HashMap<String, String> keys;
    /*
    public String apiRefNo;
    public String whtTax;
    public String incomePayer;
    public String paidTax;
    public String pvdAmtOfAllw;
    public String pvdAmtOfExcept;
    public String expfPd1;
    public String expfPd2;
    public String exAge65;
    public String qpdInc;
    public String sumExeInc;
    public String txpAllw;
    public String spoAllw;
    public String childNoStudy;
    public String getchildNoStudy;
    public String childNoStudyAmt;
    public String childStd;
    public String getchildStudy;
    public String childStudyAmt;
    public String txpFatherPin;
    public String txpMotherPin;
    public String spouseFatherPin;
    public String spouseMotherPin;
    public String txpFatherAmt;
    public String txpMotherAmt;
    public String spouseFatherAmt;
    public String spouseMotherAmt;
    public String insFaMoAmt;
    public String txpFaPinIns;
    public String txpMoPinIns;
    public String spoFaPinIns;
    public String spoMoPinIns;
    public String insAmt;
    public String spoInsAmt;
    public String retireInsAmt;
    public String retireInsAmtResult;
    public String expfPd3;
    public String expfPd4;
    public String intLoan;
    public String otherAmt;
    public String ssfAmt;
    public String sumAllowance;
    public String incBfExp;
    public String expense;
    public String incDedExp;
    public String incBfEdu;
    public String incBfDon;
    public String netIncome;
    public String fiveHundThou;
    public String eduAmt;
    public String donAmt;
    public String propertyAmt;
    public String propertyPrice;
    public String overTax;
     */
} 

class FL_Get_Pnd91CalTax_ResponseModel extends CommonResponseModel{
    public GetPnd91CalTaxData responseData;
    public FL_Get_Pnd91CalTax_ResponseModel() {
        super();
    }
    
    public FL_Get_Pnd91CalTax_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}
// </editor-fold> 
