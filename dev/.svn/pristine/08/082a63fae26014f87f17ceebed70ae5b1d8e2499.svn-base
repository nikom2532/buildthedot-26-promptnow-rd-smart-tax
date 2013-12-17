/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Input;
import com.promptnow.framework.vulcan.annotation.Internal;
import com.promptnow.framework.vulcan.annotation.JSON;
import com.promptnow.framework.vulcan.annotation.Render;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.framework.vulcan.plugin.message.Message;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Promptnow11
 */
@BusinessProcess("TimeOut")
public class TimeOutService extends BaseService{

    @JSON
    @Internal
    @Input(REQUEST)
    TimeOutRequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    TimeOutResponseModel resObject = null;
    

    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        try{
            resObject = new TimeOutResponseModel();
            String lang = "EN";
            if(vhp.containsKey("lang")){
                lang = (String)vhp.get("lang");
            }
            log.warn("Session TimeOut");
            resObject.setResponse(STATUS_FAIL, CODE_BU_FAIL, Message.get(lang,"LOGIN_FAIL"));
            
        } catch (Exception ex) {
            logRemark = ex.toString();
            Logger.getLogger(TimeOutService.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, TimeOutResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        } 
        
        //return "response-filter";
        return SUCCESS;
    }
    
}


// <editor-fold defaultstate="collapsed" desc="Request Response Model"> 
class TimeOutRequestModel extends CommonRequestModel{
}

class TimeOutResponseModel extends CommonResponseModel {
    public TimeOutResponseModel() {
        super();
    }
    public TimeOutResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }
}
// </editor-fold> 
