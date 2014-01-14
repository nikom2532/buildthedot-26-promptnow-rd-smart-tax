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
@BusinessProcess("SG_Explanation")
public class SG_Explanation extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    SG_Explanation_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    SG_Explanation_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new SG_Explanation_ResponseModel();
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
            resObject.explanation = new ArrayList<Explan>();
            resObject.explanation.add(new Explan("1","คำแนะนำ"));
            resObject.explanation.add(new Explan("2","เงื่อนไขการใช้งาน"));
            resObject.explanation.add(new Explan("3","ข้อตกลงการใช้งาน"));
            resObject.explanation.add(new Explan("4","คำอธิบายเพิ่มเติม"));
            
            resObject.setCaseSuccess(SUCCESS);
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(SG_Explanation.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, SG_Explanation_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model">
class SG_Explanation_RequestModel extends CommonRequestModel{
} 

class SG_Explanation_ResponseModel extends CommonResponseModel{
    
    public ArrayList<Explan> explanation;
    
    public SG_Explanation_ResponseModel() {
        super();
    }
    
    public SG_Explanation_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}

class Explan{
    public String id;
    public String name;

    public Explan(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public Explan() {
    }
       
}
// </editor-fold> 
