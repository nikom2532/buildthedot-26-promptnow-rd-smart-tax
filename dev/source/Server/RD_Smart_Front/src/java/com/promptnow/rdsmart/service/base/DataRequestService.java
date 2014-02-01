/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.google.gson.Gson;
import com.promptnow.common.util.converter.HEX;
import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.annotation.Config;
import com.promptnow.framework.vulcan.annotation.InputByteStream;
import com.promptnow.framework.vulcan.annotation.Render;
import com.promptnow.framework.vulcan.define.PageModel;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.rdsmart.model.CommonRequestModel;
import com.promptnow.rdsmart.model.MaskFieldModel;
import java.sql.SQLException;

/**
 *
 * @author Sarun Ketsrimek
 */
@BusinessProcess("data-request")
public class DataRequestService extends BaseService{

    final String[] maskFields = {"password","newPass","pin"};
    
    @InputByteStream
    byte[] dataB = null;

    @Render(REQUEST)
    String res = null;
    
    @Render("ENC_DATA")
    String encData = "N";
    
    @Config("SERVER_MODE")
    String serverMode="PROD";
    
    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        String data=null;
        String logString = "No data";
        try{
            log.debug(request.getSession().getId());
            if(dataB!=null){
                data = new String(dataB);
                log.debug("Input Stream size="+dataB.length);
                log.debug("data="+data.length());
                
                data = data.trim();
                if(data.startsWith("{") && data.endsWith("}")){
                    encData = "N";
                    logString = maskPassword(data);
                    logAccess.info(requestID+" I="+ logString);                    
                }else{
                    encData = "Y";
                    SecureSecService secService = new SecureSecService();
                    //secService.setSecretKey(ENC_KEY);
                    log.debug("Input="+data);
                    String decKey = request.getSession().getAttribute(KEY_DECRYPT)+"";
                    log.debug("Session Decrypt Key="+decKey);
                    byte dataValueByte[] = secService.decrypt(HEX.hexStringToByteArray(data),HEX.hexStringToByteArray(decKey));
                    data = new String(dataValueByte);
                    logString = maskPassword(data);
                    logAccess.info(requestID+" IE="+ logString);  
                }
            }
        }catch(Exception ex){
            log.error("Read input data error", ex);
        }
        
        if(data==null){
            res = null;
            log.warn("Request data is null from session id="+request.getSession().getId()+" IP="+request.getRemoteAddr());
            if(getConfig("SERVER_MODE").equals("DEVELOP")){
                res = "{}";
            }
        }else{
            res = data;
            
            try{/*
                PageModel pageModel = getCurentPageModel(vhp);
                if(pageModel.attributes.get("session")!=null && pageModel.attributes.get("session").equals("Y")){
                    // Check Session
                    Gson gson = new Gson();
                    CommonRequestModel commonReq = gson.fromJson(res, CommonRequestModel.class);
                    UserProfileDB userDB = new UserProfileDB();
                    checkUserSessionReturn[] dbResult = userDB.checkUserSession(commonReq.username, commonReq.sessionID);
                    if(dbResult.length==0){
                        vhp.put("lang", commonReq.language);
                        throw new VulcanException("Timeout","Timeout");
                    }              
                }*/
            }catch(Exception ex){
                log.error(ex);
            }
            
            /*
            try{
                if(!pageModel.attributes.containsKey("do-not-logging")){
                    if(requestModel.sessionID==null || requestModel.sessionID.equals("")){
                        logInfo(requestModel, pageModel.service, "JSID="+request.getSession().getId()+" : "+logString, "E", "1", "Session is null");
                    }else{
                        logInfo(requestModel, pageModel.service, "JSID="+request.getSession().getId()+" : "+logString, "S", "0", "");
                    }
                }
            }catch(Exception err){
                log.error("Add event error on get info from request",err);
            }
            */
        }
        return SUCCESS;
    }
    
    private String maskPassword(String text){
        String re = text.trim();
        Gson gson = new Gson();
        MaskFieldModel maskFieldModel = gson.fromJson(re, MaskFieldModel.class);
        if(maskFieldModel.password!=null){
            re = re.replace("\""+maskFieldModel.password+"\"", "---MASK---");
        }
        if(maskFieldModel.newPass!=null){
            re = re.replace("\""+maskFieldModel.newPass+"\"", "---MASK---");
        }
        return re;
    }
}

