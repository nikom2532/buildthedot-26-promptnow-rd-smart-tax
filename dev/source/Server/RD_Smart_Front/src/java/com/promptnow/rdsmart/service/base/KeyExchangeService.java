/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Input;
import com.promptnow.framework.vulcan.annotation.Internal;
import com.promptnow.framework.vulcan.annotation.JSON;
import com.promptnow.framework.vulcan.annotation.PostProcess;
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
 * @author Sarun Ketsrimek
 */
@BusinessProcess("KeyExchange")
public class KeyExchangeService extends BaseService{

    @JSON
    @Internal
    @Input(REQUEST)
    KeyExchangeRequestModel reqObject = null; 
        
    @JSON
    @Render(RESPONSE)
    KeyExchangeResponseModel resObject = null;
    

    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
    
        resObject = new KeyExchangeResponseModel(KeyExchangeResponseModel.STATUS_SUCCESS, 
                KeyExchangeResponseModel.CODE_SUCCESS, "Key Exchange Success");
        
        String modulus  = "7423866688788092730375632892133655575163784823363584754133883720690895336103965771008127952234763116514093700010737585026873496588835566657912741608749002";
        String exponent = "8795978702413663113181077677053513950582867036896484869168624885398574428392132500195468603879055097087016255364600753129842591338319653172152365709190473";
        
        SecureSecService secService = new SecureSecService();
        try {
            String[] iden = secService.keyExchange(modulus, exponent, reqObject.identify);
            resObject.identify = iden[0];
            resObject.independent = iden[2];
            String key = iden[3];
            secService.setSecretKey(key);
            log.debug("KEY="+key);
            log.debug("KEY_Enc="+secService.getENCRYPT_KEY());
            log.debug("KEY_Dec="+secService.getDECRYPT_KEY());
            request.getSession().setAttribute(KEY_ENCRYPT, secService.getDECRYPT_KEY());
            request.getSession().setAttribute(KEY_DECRYPT, secService.getENCRYPT_KEY());
            //fix key
            //request.getSession().setAttribute(KEY_ENCRYPT, KEY_ENCRYPT_DB);
            //request.getSession().setAttribute(KEY_DECRYPT, KEY_ENCRYPT_DB);
            //resObject.key = key;
        } catch (Exception ex) {
            logRemark = ex.toString();
            Logger.getLogger(KeyExchangeService.class.getName()).log(Level.SEVERE, null, ex);
            resObject.setCaseError(reqObject, KeyExchangeResponseModel.STATUS_ERROR, Message.get(reqObject.language,"GEN_ERR"));
        }finally {
            writeEventLog(reqObject, resObject,vhp);
        } 
        return SUCCESS;
    }
    
    
    @PostProcess
    public String postExecute(VulcanHashParameter vhp) throws VulcanException {
        resObject.sessionID = generateSessionID();
        request.getSession().setAttribute("sessionID", resObject.sessionID);
        //setSession(reqObject, resObject);
        //setServerDateTime(resObject);
        return SUCCESS;
    }
}

// <editor-fold defaultstate="collapsed" desc="Request Response Model"> 
class KeyExchangeRequestModel extends CommonRequestModel{
    String identify = "";
}

class KeyExchangeResponseModel extends CommonResponseModel {

    public String independent = null;
    public String identify = "";
    
    public KeyExchangeResponseModel(String status, String code, String msg) {
        super(status, code, msg);
    }
}

// </editor-fold> 
