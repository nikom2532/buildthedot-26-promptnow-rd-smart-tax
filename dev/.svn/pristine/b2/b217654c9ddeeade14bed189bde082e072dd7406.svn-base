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
import com.promptnow.rdsmart.db.CountryApplication;
import com.promptnow.rdsmart.db.CountryApplication.ListProvince;
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
@BusinessProcess("RQ_Province")
public class RQ_Province extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    RQ_Province_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    RQ_Province_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new RQ_Province_ResponseModel();
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
            CountryApplication ca = new CountryApplication();
            ListProvince[] lp = ca.getProvince();
            
            if(lp.length > 0)
            {
                resObject.province = new ArrayList<Province>();
                for(int i=0;i<lp.length;i++)
                {
                    resObject.province.add(new Province(lp[i].PROVINCE_IDS,lp[i].PROVINCE_NAME));
                }
            }
//            resObject.province = new ArrayList<Province>();
//            resObject.province.add(new Province("810000","กระบี่"));
//            resObject.province.add(new Province("100000","กรุงเทพมหานคร"));
            resObject.setCaseSuccess(SUCCESS);
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(RQ_Province.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, RQ_Province_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model">

class RQ_Province_RequestModel extends CommonRequestModel{
} 

class RQ_Province_ResponseModel extends CommonResponseModel{
    
    public ArrayList<Province> province;
    
    public RQ_Province_ResponseModel() {
        super();
    }
    
    public RQ_Province_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}

class Province{
    public String id;
    public String name;

    public Province(String provinceID, String provinceName) {
        this.id = provinceID;
        this.name = provinceName;
    }
    
}

// </editor-fold> 
