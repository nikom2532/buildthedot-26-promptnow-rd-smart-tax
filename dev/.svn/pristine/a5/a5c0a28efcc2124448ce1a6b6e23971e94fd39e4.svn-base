package com.promptnow.rdsmart.db;

import com.google.gson.Gson;
/**
*
* @author Database Repository Generator
*/

public class UserProfileDB{

    public String datasourceName = "";

    public UserProfileDB(String datasourceName){
        this.datasourceName = datasourceName; 
    }

    public UserProfileDB(){
        this.datasourceName = com.promptnow.framework.vulcan.VulcanCore.getConfig("DB_DSNAME"); 
    }


    /** Database Repository Generator Function **/
    public UserProfile[] getUserProfile(String nid) throws java.sql.SQLException{
String SQL = "SELECT NID, USERNAME, DEVICE_ID, DEVICE_TYPE_IDS, DEVICE_USER_AGENT, LAST_LOGIN_DATETIME, SESSION_VALUE, LAST_ACCESS, LAST_ACCESS_MS FROM USER_PROFILE WHERE NID='"+escapeSql(nid)+"'";
    java.util.ArrayList<UserProfile> returnValue = new java.util.ArrayList<UserProfile>();

    java.sql.ResultSet resultSet = com.promptnow.framework.vulcan.database.DBCore.executeQuery(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL);
    if(resultSet!=null){
        resultSet.beforeFirst();
        while(resultSet.next()){
            UserProfile c = new UserProfile(resultSet);
            returnValue.add(c);
        }
        
    }

    return returnValue.toArray(new UserProfile[returnValue.size()]);
    }


    /**
    *
    * @author Database Repository Generator(Result Class)
    */

 public UserProfile create_UserProfile() throws java.sql.SQLException{
   return new UserProfile();}
    public class UserProfile{
    public String NID = null;
    public String getNid(){ return NID; }

    public String USERNAME = null;
    public String getUsername(){ return USERNAME; }

    public String DEVICE_ID = null;
    public String getDeviceId(){ return DEVICE_ID; }

    public int DEVICE_TYPE_IDS = 0;
    public int getDeviceTypeIds(){ return DEVICE_TYPE_IDS; }

    public String DEVICE_USER_AGENT = null;
    public String getDeviceUserAgent(){ return DEVICE_USER_AGENT; }

    public String LAST_LOGIN_DATETIME = null;
    public String getLastLoginDatetime(){ return LAST_LOGIN_DATETIME; }

    public String SESSION_VALUE = null;
    public String getSessionValue(){ return SESSION_VALUE; }

    public String LAST_ACCESS = null;
    public String getLastAccess(){ return LAST_ACCESS; }

    public String LAST_ACCESS_MS = null;
    public String getLastAccessMs(){ return LAST_ACCESS_MS; }


        public UserProfile(){}

        public UserProfile(java.sql.ResultSet resultSet) throws java.sql.SQLException{

   if(resultSet!=null){
            NID = resultSet.getString("NID");
            USERNAME = resultSet.getString("USERNAME");
            DEVICE_ID = resultSet.getString("DEVICE_ID");
            DEVICE_TYPE_IDS = resultSet.getInt("DEVICE_TYPE_IDS");
            DEVICE_USER_AGENT = resultSet.getString("DEVICE_USER_AGENT");
            LAST_LOGIN_DATETIME = resultSet.getString("LAST_LOGIN_DATETIME");
            SESSION_VALUE = resultSet.getString("SESSION_VALUE");
            LAST_ACCESS = resultSet.getString("LAST_ACCESS");
            LAST_ACCESS_MS = resultSet.getString("LAST_ACCESS_MS");
        }
        }
    }



    /** Database Repository Generator Function **/
    public checkUserSessionReturn[] checkUserSession(String username,String sessionID) throws java.sql.SQLException{
String SQL = "SELECT NID FROM USER_PROFILE WHERE LOWER(USERNAME)=LOWER(?) AND SESSION_VALUE=?";
    java.util.ArrayList<checkUserSessionReturn> returnValue = new java.util.ArrayList<checkUserSessionReturn>();

    java.sql.ResultSet resultSet = com.promptnow.framework.vulcan.database.DBCore.executePrepareQuery(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,username,sessionID);
    if(resultSet!=null){
        resultSet.beforeFirst();
        while(resultSet.next()){
            checkUserSessionReturn c = new checkUserSessionReturn(resultSet);
            returnValue.add(c);
        }
        
    }

    return returnValue.toArray(new checkUserSessionReturn[returnValue.size()]);
    }


    /**
    *
    * @author Database Repository Generator(Result Class)
    */

 public checkUserSessionReturn create_checkUserSessionReturn() throws java.sql.SQLException{
   return new checkUserSessionReturn();}
    public class checkUserSessionReturn{
    public String NID = null;
    public String getNid(){ return NID; }


        public checkUserSessionReturn(){}

        public checkUserSessionReturn(java.sql.ResultSet resultSet) throws java.sql.SQLException{

   if(resultSet!=null){
            NID = resultSet.getString("NID");
        }
        }
    }



    /** Database Repository Generator Function **/
    public int insertUserProfile(String nID ,String username ,String deviceID ,int deviceType ,String deviceUserAgent ,String lastLoginDateTime ,String sessionID ,String lastAccess ,String lastAccessMS ) throws java.sql.SQLException{
String SQL = "INSERT INTO USER_PROFILE (NID, USERNAME, DEVICE_ID, DEVICE_TYPE_IDS, DEVICE_USER_AGENT, LAST_LOGIN_DATETIME, SESSION_VALUE, LAST_ACCESS, LAST_ACCESS_MS) VALUES (?,LOWER(?),?,?,?, ?,?,?,?)";
        return com.promptnow.framework.vulcan.database.DBCore.executePrepareUpdate(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,nID,username,deviceID,deviceType,deviceUserAgent,lastLoginDateTime,sessionID,lastAccess,lastAccessMS);
    }


    /** Database Repository Generator Function **/
    public int updateUserProfile(String nID ,String deviceID ,int deviceType ,String deviceUserAgent ,String lastLoginDateTime ,String sessionID ,String lastAccessMS ,String username ) throws java.sql.SQLException{
String SQL = "UPDATE USER_PROFILE SET NID=?, DEVICE_ID=?, DEVICE_TYPE_IDS=?, DEVICE_USER_AGENT=?, LAST_LOGIN_DATETIME=?, SESSION_VALUE=?, LAST_ACCESS=GETDATE(), LAST_ACCESS_MS=? WHERE LOWER(USERNAME)=LOWER(?)";
        return com.promptnow.framework.vulcan.database.DBCore.executePrepareUpdate(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,nID,deviceID,deviceType,deviceUserAgent,lastLoginDateTime,sessionID,lastAccessMS,username);
    }


    /** Database Repository Generator Function **/
    public int updateUserLoginTime(String lastLoginDateTime ,String username ) throws java.sql.SQLException{
String SQL = "UPDATE USER_PROFILE SET LAST_LOGIN_DATETIME=? WHERE LOWER(USERNAME)=LOWER(?)";
        return com.promptnow.framework.vulcan.database.DBCore.executePrepareUpdate(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,lastLoginDateTime,username);
    }


    /** Database Repository Generator Function **/
    public int updateUserLogoutTime(String nid ,String session ) throws java.sql.SQLException{
String SQL = "UPDATE USER_PROFILE SET LAST_LOGOUT_DATETIME=GETDATE() WHERE nid=? AND SESSION_VALUE=?";
        return com.promptnow.framework.vulcan.database.DBCore.executePrepareUpdate(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,nid,session);
    }


    /** Database Repository Generator Function **/
    public int updateUserSession(String lastAccessMS ,String username ) throws java.sql.SQLException{
String SQL = "UPDATE USER_PROFILE SET LAST_ACCESS=SYSDATA(), LAST_ACCESS_MS=? WHERE LOWER(USERNAME)=LOWER(?)";
        return com.promptnow.framework.vulcan.database.DBCore.executePrepareUpdate(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,lastAccessMS,username);
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