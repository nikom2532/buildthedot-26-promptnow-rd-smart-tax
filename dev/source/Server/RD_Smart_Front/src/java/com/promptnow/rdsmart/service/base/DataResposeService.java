/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.promptnow.common.util.converter.HEX;
import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Input;
import com.promptnow.framework.vulcan.annotation.JSON;
import com.promptnow.framework.vulcan.define.PageModel;
import com.promptnow.framework.vulcan.define.RenderObjecModel;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.LogResponseDisplayModel;
import java.io.UnsupportedEncodingException;
import java.security.SecureRandom;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author cheng
 */
@BusinessProcess("data-response")
public class DataResposeService extends BaseService{

    private static Random randomSalt = new SecureRandom();
    
    @Input("ENC_DATA")
    String encData = "N";
    
    @JSON
    @Input(REQUEST)
    CommonRequestModel reqObject = null;

    @Input(RESPONSE)
    String resString = "";
    
    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        
        String outString = "";
        RenderObjecModel renderObjecModel = (RenderObjecModel)vhp.get(RESPONSE);
        
        if(renderObjecModel!=null){
            outString = renderObjecModel.value.toString();
                        
            String salt = "{\""+randomSalt.nextInt(100000)+"\":\""+randomSalt.nextInt(100000)+"\",";
            outString = salt + outString.substring(1, outString.length());
            
            
            PageModel pageModel = getCurentPageModel(vhp);
            String username = "Unknown";
            String jsessionID= request.getSession().getId();
            String sessionID = null;
            if(reqObject!=null){
                username = reqObject.nid;
                sessionID = reqObject.sessionID;
            }

            LogResponseDisplayModel resModel = injectJsonString(outString, LogResponseDisplayModel.class);
            
            if(sessionID == null){
                logInfo(reqObject, pageModel.service, "JSID=" + jsessionID + " : " + getJSON(resModel) , "S","1","Session is null");
            }else{
                logInfo(reqObject, pageModel.service, "SID=" + sessionID + " : " + getJSON(resModel) ,resModel.responseStatus,resModel.responseCode,resModel.responseMessage);
            }
            
            
            if("Y".equals(encData)){
                try {
                    logAccess.info(requestID+" OE="+ outString);
                    SecureSecService secService = new SecureSecService();
                    String encKey = request.getSession().getAttribute(KEY_ENCRYPT)+"";
                    log.debug("Session Encrypt Key="+encKey);
                    byte[] outByte = secService.encrypt(outString.getBytes("UTF-8"), HEX.hexStringToByteArray(encKey));
                    outString = HEX.getHexString(outByte);
                    logAccess.debug(requestID+" OE="+ outString);
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(DataResposeService.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(DataResposeService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }else{
                logAccess.info(requestID+" O="+ outString);
            }
            
            
        }
        try {
            response.setCharacterEncoding("UTF-8");
            sendByteStream(vhp, "text/html; charset=UTF-8", outString.getBytes("UTF-8"));
        } catch (Exception ex) {
            Logger.getLogger(DataResposeService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return SUCCESS;
    }
    
}
