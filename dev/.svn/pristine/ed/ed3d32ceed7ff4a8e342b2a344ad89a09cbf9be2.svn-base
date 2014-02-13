package com.promptnow.rdsmart.db;

import com.google.gson.Gson;
/**
*
* @author Database Repository Generator
*/

public class ClientApplication{

    public String datasourceName = "";

    public ClientApplication(String datasourceName){
        this.datasourceName = datasourceName; 
    }

    public ClientApplication(){
        this.datasourceName = com.promptnow.framework.vulcan.VulcanCore.getConfig("DB_DSNAME"); 
    }


    /** Database Repository Generator Function **/
    public ClientVersion[] getClientVersion(String device_type_name) throws java.sql.SQLException{
String SQL = "SELECT                 CLIENT_APPLICATION.CLIENT_IDS AS CLIENT_IDS,                CLIENT_APPLICATION.DEVICE_TYPE_ID AS DEVICE_TYPE_ID,                CLIENT_APPLICATION.CURRENT_VERSION AS CURRENT_VERSION,                CLIENT_APPLICATION.DOWNLOAD_URL AS DOWNLOAD_URL                  FROM CLIENT_APPLICATION INNER JOIN DEVICE_MASTER                 ON DEVICE_MASTER.DEVICE_TYPE_IDS=CLIENT_APPLICATION.DEVICE_TYPE_ID                 WHERE CLIENT_APPLICATION.device_type_id=? AND CLIENT_APPLICATION.APPLICATION_NAME='rdsmart' ";
    java.util.ArrayList<ClientVersion> returnValue = new java.util.ArrayList<ClientVersion>();

    java.sql.ResultSet resultSet = com.promptnow.framework.vulcan.database.DBCore.executePrepareQuery(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,device_type_name);
    if(resultSet!=null){
        resultSet.beforeFirst();
        while(resultSet.next()){
            ClientVersion c = new ClientVersion(resultSet);
            returnValue.add(c);
        }
        
    }

    return returnValue.toArray(new ClientVersion[returnValue.size()]);
    }


    /**
    *
    * @author Database Repository Generator(Result Class)
    */

 public ClientVersion create_ClientVersion() throws java.sql.SQLException{
   return new ClientVersion();}
    public class ClientVersion{
    public int CLIENT_IDS = 0;
    public int getClientIds(){ return CLIENT_IDS; }

    public int DEVICE_TYPE_ID = 0;
    public int getDeviceTypeId(){ return DEVICE_TYPE_ID; }

    public String CURRENT_VERSION = null;
    public String getCurrentVersion(){ return CURRENT_VERSION; }

    public String DOWNLOAD_URL = null;
    public String getDownloadUrl(){ return DOWNLOAD_URL; }


        public ClientVersion(){}

        public ClientVersion(java.sql.ResultSet resultSet) throws java.sql.SQLException{

   if(resultSet!=null){
            CLIENT_IDS = resultSet.getInt("CLIENT_IDS");
            DEVICE_TYPE_ID = resultSet.getInt("DEVICE_TYPE_ID");
            CURRENT_VERSION = resultSet.getString("CURRENT_VERSION");
            DOWNLOAD_URL = resultSet.getString("DOWNLOAD_URL");
        }
        }
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