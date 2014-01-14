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
@BusinessProcess("RQ_Amphur")
public class RQ_Amphur extends BaseService{
    
    @JSON
    @Internal
    @Input(REQUEST)
    RQ_Amphur_RequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    RQ_Amphur_ResponseModel resObject = null;   
               
    @PreProcess
    public String preExecute(VulcanHashParameter vhp) throws VulcanException {
        jsonInput = getJSONMask(reqObject);
        resObject = new RQ_Amphur_ResponseModel();
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
            ArrayList<tambol> tambolList;
            Amphur amphur;
            resObject.amphur = new ArrayList<Amphur>();
            
            if(reqObject.provinceID.equals("810000")){
                tambolList = new ArrayList<tambol>();
                    tambolList.add(new tambol("810303", "เกาะกลาง"));
                    tambolList.add(new tambol("810302", "เกาะลันตาน้อย"));
                    tambolList.add(new tambol("810301", "เกาะลันตาใหญ่"));
                    tambolList.add(new tambol("810304", "คลองยาง"));
                amphur = new Amphur("เกาะลันตา", tambolList);
                resObject.amphur.add(amphur);

                tambolList = new ArrayList<tambol>();
                    tambolList.add(new tambol("810202", "เขาดิน"));
                    tambolList.add(new tambol("810201", "เขาพนม"));
                amphur = new Amphur("เขาพนม", tambolList);
                resObject.amphur.add(amphur);                

            }else{
                tambolList = new ArrayList<tambol>();
                    tambolList.add(new tambol("103302", "คลองตัน"));
                    tambolList.add(new tambol("103301", "คลองเตย"));
                    tambolList.add(new tambol("103303", "พระโขนง"));
                amphur = new Amphur("คลองเตย", tambolList);
                resObject.amphur.add(amphur);

                tambolList = new ArrayList<tambol>();
                    tambolList.add(new tambol("101804", "คลองต้นไทร"));
                    tambolList.add(new tambol("810302", "คลองสาน"));
                    tambolList.add(new tambol("101803", "บางลำภูล่าง"));
                    tambolList.add(new tambol("101801", "สมเด็จเจ้าพระยา"));
                amphur = new Amphur("คลองสาน", tambolList);
                resObject.amphur.add(amphur);                
            }
            
            resObject.setCaseSuccess(SUCCESS);
            return SUCCESS;
        }catch(Exception ex){
            logRemark = ex.toString();
            log.error(ex);
            Logger.getLogger(RQ_Amphur.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, RQ_Amphur_ResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        }
        return SUCCESS;
    } 
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model">

class RQ_Amphur_RequestModel extends CommonRequestModel{
    public String provinceID = "";
} 

class RQ_Amphur_ResponseModel extends CommonResponseModel{
    
    public ArrayList<Amphur> amphur;
    
    public RQ_Amphur_ResponseModel() {
        super();
    }
    
    public RQ_Amphur_ResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }      
}

class Amphur{
    public String amphurID = "";
    public String amphurName;
    public ArrayList<tambol> tambol;
    
    public Amphur(String amphurName, ArrayList<tambol> tambol) {
        this.amphurName = amphurName;
        this.tambol = tambol;
    }
}

class tambol{
    public String tambolID;
    public String tambolName;
    
    public tambol(String tambolID, String tambolName) {
        this.tambolID = tambolID;
        this.tambolName = tambolName;
    }    
}


// </editor-fold> 
