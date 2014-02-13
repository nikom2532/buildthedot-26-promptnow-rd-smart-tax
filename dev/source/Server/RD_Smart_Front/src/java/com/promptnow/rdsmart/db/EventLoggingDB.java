package com.promptnow.rdsmart.db;

import com.google.gson.Gson;
/**
*
* @author Database Repository Generator
*/

public class EventLoggingDB{

    public String datasourceName = "";

    public EventLoggingDB(String datasourceName){
        this.datasourceName = datasourceName; 
    }

    public EventLoggingDB(){
        this.datasourceName = com.promptnow.framework.vulcan.VulcanCore.getConfig("DB_DSNAME"); 
    }


    /** Database Repository Generator Function **/
    public int insertLog(String userName ,String logDateTime ,String logKeyWord ,String logReqDetail ,String logResDetail ,String eventSourceIP ,int deviceTypeID ,String deviceUserAgent ,String deviceID ,String latitude ,String longitude ,String responseStatus ,String responseCode ,String responseMessage ,String remark ,String session ) throws java.sql.SQLException{
String SQL = "INSERT INTO EVENT_LOGGING (USERNAME, LOG_DATETIME,LOG_KEYWORD,LOG_REQ_DETAIL,LOG_RES_DETAIL,EVENT_SOURCE_IP,DEVICE_TYPE_IDS,DEVICE_USER_AGENT,DEVICE_IDS,LATITUDE,LONGITUDE,RESPONSE_STATUS,RESPONSE_CODE,RESPONSE_MESSAGE,REMARK,SESSION_ID) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        return com.promptnow.framework.vulcan.database.DBCore.executePrepareUpdate(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,userName,logDateTime,logKeyWord,logReqDetail,logResDetail,eventSourceIP,deviceTypeID,deviceUserAgent,deviceID,latitude,longitude,responseStatus,responseCode,responseMessage,remark,session);
    }

 public String escapeSql(String str) {
 if (str == null) {
   return null;
 }
 return str.replaceAll("'", "''");
 }
protected <T> T inject(Object source,Class<T> destType){
        Gson gson = new Gson();
        String sourceString = gson.toJson(source);
        Object re = gson.fromJson(sourceString, destType);
        return destType.cast(re);
    }

}