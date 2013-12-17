/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Input;
import com.promptnow.framework.vulcan.annotation.JSON;
import com.promptnow.framework.vulcan.annotation.Render;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.CommonResponseModel;

/**
 *
 * @author Sarun Ketsrimek
 */
@BusinessProcess("common-exception")
public class CommonExceptionService extends BaseService{

    @JSON
    @Render(REQUEST)
    CommonRequestModel reqObject = null;
    
    @Input(VulcanException.EXCEPTION_MESSAGE)
    String errorMessage = "";
    
    @Input(VulcanException.EXCEPTION_CODE)
    String errorCode = "";
    
    @JSON
    @Render(RESPONSE)
    CommonResponseModel resObject = null;
    
    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        resObject = new CommonResponseModel(CommonResponseModel.STATUS_ERROR, errorCode, errorMessage );
        
        /*
        logError(reqObject,  "Common Exception", "System get Common throw exception", "E", errorCode, errorMessage, getException(vhp));
        
        if (reqObject != null) {
            setSession(reqObject, resObject);
        }
        setServerDateTime(resObject);        
        
         */
        return SUCCESS;
    }
}
