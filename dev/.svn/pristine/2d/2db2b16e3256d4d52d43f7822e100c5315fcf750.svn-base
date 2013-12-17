/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.define.PageModel;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;

/**
 *
 * @author Sarun Ketsrimek
 */
@BusinessProcess("response-filter")
public class ResponseFilter extends BaseService{

    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
                PageModel pageModel = getCurentPageModel(vhp);
        if(pageModel.attributes.containsKey("html")){
            return "html-response";
        }else{
            return "data-response";
        }
    }
    
}
