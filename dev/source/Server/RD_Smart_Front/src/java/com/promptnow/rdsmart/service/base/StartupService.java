/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.service.base;

import com.promptnow.framework.vulcan.annotation.BusinessProcess;
import com.promptnow.framework.vulcan.define.VulcanException;
import com.promptnow.framework.vulcan.define.VulcanHashParameter;
import com.promptnow.rdsmart.db.DataMapping;
import java.sql.SQLException;

/**
 *
 * @author Sarun Ketsrimek
 */
@BusinessProcess("startup-process")
public class StartupService extends BaseService{

   
    @Override
    public String execute(VulcanHashParameter vhp) throws VulcanException {
        
        /*
        if(getConfig("SERVER_MODE").equals("DEVELOP") || getConfig("SERVER_MODE").equals("SIT")){
            
        }else{
           
        }
        */

        // List device master
        DataMapping dataMapping = new DataMapping();
        try {
            DataMapping.AllDeviceTypeID allDeviceTypeID[] = dataMapping.getAllDeviceTypeID();
            if(allDeviceTypeID!=null){
                for(DataMapping.AllDeviceTypeID adtid : allDeviceTypeID){
                    DEVICE_MASTER_MAPPING.put(adtid.getDeviceTypeName(), adtid.getDeviceTypeIds());
                }
                
            }
        } catch (SQLException ex) {
            log.error("Get Device Master error",ex);
        }
        return SUCCESS;
    }
    
}
