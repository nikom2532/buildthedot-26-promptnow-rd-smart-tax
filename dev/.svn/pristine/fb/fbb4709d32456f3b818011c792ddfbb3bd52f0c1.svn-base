/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.other;

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
@BusinessProcess("RQ_Vdo")
public class RQ_Vdo extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    RQ_Vdo_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    RQ_Vdo_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new RQ_Vdo_ResponseModel();
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
            resObject.vdo = new ArrayList<VDOModel>();
            resObject.vdo.add(new VDOModel("1", "หัวข้อวิดีโอ 1", "youtube.googleapis.com/v/u8sqeO0-duA"));
            resObject.vdo.add(new VDOModel("2", "หัวข้อวิดีโอ 2", "www.youtube.com/watch?v=u8sqeO0-duA"));
            resObject.vdo.add(new VDOModel("3", "หัวข้อวิดีโอ 3", "www.youtube.com/v/u8sqeO0-duA"));
            resObject.vdo.add(new VDOModel("4", "หัวข้อวิดีโอ 4", "https://youtube.googleapis.com/v/u8sqeO0-duA"));
            
            resObject.setCaseSuccess(SUCCESS);
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(RQ_Vdo.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, RQ_Vdo_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model">

class RQ_Vdo_RequestModel extends CommonRequestModel{
} 

class RQ_Vdo_ResponseModel extends CommonResponseModel{
    
    public ArrayList<VDOModel> vdo;
    
    public RQ_Vdo_ResponseModel() {
        super();
    }
    
    public RQ_Vdo_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}

class VDOModel{
    public String id;
    public String name;
    public String url;

    public VDOModel(String id, String name, String url) {
        this.id = id;
        this.name = name;
        this.url = url;
    }

    public VDOModel() {
    }
       
}
// </editor-fold> 
