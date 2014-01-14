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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Promptnow11
 */
@BusinessProcess("SG_Explanation_Detail")
public class SG_Explanation_Detail extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    SG_Explanation_Detail_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    SG_Explanation_Detail_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new SG_Explanation_Detail_ResponseModel();
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
            if(isEmpty(reqObject.explanationID)){
                logRemark = "Invalid Parameter";
                resObject.setResponse(STATUS_FAIL, CODE_BU_FAIL, Message.get(reqObject.language,"INVALID_PARAMETER"));
                return SUCCESS;                
            }            
            
            resObject.explanationDetail = new ArrayList<ExplanDetail>();
            resObject.explanationDetail.add(new ExplanDetail("1","คำแนะนำ", "http://www.rd.go.th/"));
            resObject.explanationDetail.add(new ExplanDetail("2","เงื่อนไขการใช้งาน", "http://www.rd.go.th/"));
            resObject.explanationDetail.add(new ExplanDetail("3","ข้อตกลงการใช้งาน", "http://www.rd.go.th/"));
            resObject.explanationDetail.add(new ExplanDetail("4","คำอธิบายเพิ่มเติม", "http://www.rd.go.th/"));
            
            resObject.setCaseSuccess(SUCCESS);
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(SG_Explanation_Detail.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, SG_Explanation_Detail_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model">
class SG_Explanation_Detail_RequestModel extends CommonRequestModel{
    public String explanationID;
} 

class SG_Explanation_Detail_ResponseModel extends CommonResponseModel{
    
    public ArrayList<ExplanDetail> explanationDetail;
    
    public SG_Explanation_Detail_ResponseModel() {
        super();
    }
    
    public SG_Explanation_Detail_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}

class ExplanDetail{
    public String id;
    public String message;
    public String url;

    public ExplanDetail(String id, String message, String url) {
        this.id = id;
        this.message = message;
        this.url = url;
    }

    public ExplanDetail() {
    }
       
}
// </editor-fold> 
