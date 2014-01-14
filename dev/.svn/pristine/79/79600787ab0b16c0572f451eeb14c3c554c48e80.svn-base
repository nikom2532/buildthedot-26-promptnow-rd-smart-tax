/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.profile;

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
import com.promptnow.rdsmart.api.model.UpdateTaxPayerProfileOutputModel;
import com.promptnow.rdsmart.api.model.UpdateTaxPayerProfileOutputModel.UpdateTaxPayerProfileData;
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
@BusinessProcess("PF_Update_TaxPayerProfile")
public class PF_Update_TaxPayerProfile extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    PF_Update_TaxPayerProfile_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    PF_Update_TaxPayerProfile_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new PF_Update_TaxPayerProfile_ResponseModel();
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
            UpdateTaxPayerProfileOutputModel wsRes = ws.updateTaxPayerProfile(reqObject.nid, reqObject.authenKey, reqObject.language, reqObject.name, reqObject.surname, reqObject.buildName, reqObject.roomNo
                    , reqObject.floorNo, reqObject.addressNo, reqObject.soi, reqObject.village, reqObject.mooNo, reqObject.street, reqObject.tambol, reqObject.amphur
                    , reqObject.province, reqObject.postcode, reqObject.taxpayerStatus, reqObject.spouseStatus, reqObject.marryStatus, reqObject.spouseNid
                    , reqObject.spouseName, reqObject.spouseSurname, reqObject.childNoStudy, reqObject.childStudy, reqObject.txpFatherPin, reqObject.txpMotherPin
                    , reqObject.spouseFatherPin, reqObject.spouseMotherPin
                    , reqObject.passportNo, reqObject.countryCode, reqObject.email, reqObject.phoneNumber, reqObject.spousePassportNo, reqObject.spouseCountryCode, reqObject.spouseBirthDate, reqObject.middleName);
            
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
            Logger.getLogger(PF_Update_TaxPayerProfile.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, PF_Update_TaxPayerProfile_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}   
// <editor-fold defaultstate="collapsed" desc="Request Response Model">
class PF_Update_TaxPayerProfile_RequestModel extends CommonRequestModel{
    public String name;
    public String surname;
    public String buildName;
    public String roomNo;
    public String floorNo;
    public String addressNo;
    public String soi;
    public String village;
    public String mooNo;
    public String street;
    public String tambol;
    public String amphur;
    public String province;
    public String postcode;
    public String taxpayerStatus;
    public String spouseStatus;
    public String marryStatus;
    public String spouseNid;
    public String spouseName;
    public String spouseSurname;
    public String childNoStudy;
    public String childStudy;
    public String txpFatherPin;
    public String txpMotherPin;
    public String spouseFatherPin;
    public String spouseMotherPin;
    public String passportNo;
    public String countryCode;
    public String email;
    public String phoneNumber;
    public String spousePassportNo;
    public String spouseCountryCode;
    public String spouseBirthDate;
    public String middleName; 
} 

class PF_Update_TaxPayerProfile_ResponseModel extends CommonResponseModel{
    
    public UpdateTaxPayerProfileData responseData;
    
    public PF_Update_TaxPayerProfile_ResponseModel() {
        super();
    }
    
    public PF_Update_TaxPayerProfile_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}



// </editor-fold> 
