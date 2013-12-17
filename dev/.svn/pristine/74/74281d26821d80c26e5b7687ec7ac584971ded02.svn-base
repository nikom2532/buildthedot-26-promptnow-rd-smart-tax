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
@BusinessProcess("request-filter")
public class RequestFilter extends BaseService{

    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        PageModel pageModel = getCurentPageModel(vhp);
        String requestURI = pageModel.uri.replace(".service", "").replace("/", "");
        log.debug("Service URI : " +  requestURI);
        vhp.put("requestURI", requestURI);
        if(pageModel.attributes.containsKey("html")){
            return "html-request";
        }else{
            return "data-request";
        }
    }
}
