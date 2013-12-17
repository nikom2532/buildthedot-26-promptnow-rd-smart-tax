package com.promptnow.rdsmart.db;

import com.google.gson.Gson;
/**
*
* @author Database Repository Generator
*/

public class DataMapping{

    public String datasourceName = "";

    public DataMapping(String datasourceName){
        this.datasourceName = datasourceName; 
    }

    public DataMapping(){
        this.datasourceName = com.promptnow.framework.vulcan.VulcanCore.getConfig("DB_DSNAME"); 
    }


    /** Database Repository Generator Function **/
    public DeviceTypeID[] getDeviceTypeID(String device_type_name) throws java.sql.SQLException{
String SQL = "SELECT DEVICE_TYPE_IDS FROM DEVICE_MASTER WHERE DEVICE_TYPE_NAME=? ";
    java.util.ArrayList<DeviceTypeID> returnValue = new java.util.ArrayList<DeviceTypeID>();

    java.sql.ResultSet resultSet = com.promptnow.framework.vulcan.database.DBCore.executePrepareQuery(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,device_type_name);
    if(resultSet!=null){
        resultSet.beforeFirst();
        while(resultSet.next()){
            DeviceTypeID c = new DeviceTypeID(resultSet);
            returnValue.add(c);
        }
        
    }

    return returnValue.toArray(new DeviceTypeID[returnValue.size()]);
    }


    /**
    *
    * @author Database Repository Generator(Result Class)
    */

 public DeviceTypeID create_DeviceTypeID() throws java.sql.SQLException{
   return new DeviceTypeID();}
    public class DeviceTypeID{
    public int DEVICE_TYPE_IDS = 0;
    public int getDeviceTypeIds(){ return DEVICE_TYPE_IDS; }


        public DeviceTypeID(){}

        public DeviceTypeID(java.sql.ResultSet resultSet) throws java.sql.SQLException{

   if(resultSet!=null){
            DEVICE_TYPE_IDS = resultSet.getInt("DEVICE_TYPE_IDS");
        }
        }
    }



    /** Database Repository Generator Function **/
    public AllDeviceTypeID[] getAllDeviceTypeID() throws java.sql.SQLException{
String SQL = "SELECT * from DEVICE_MASTER ";
    java.util.ArrayList<AllDeviceTypeID> returnValue = new java.util.ArrayList<AllDeviceTypeID>();

    java.sql.ResultSet resultSet = com.promptnow.framework.vulcan.database.DBCore.executeQuery(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL);
    if(resultSet!=null){
        resultSet.beforeFirst();
        while(resultSet.next()){
            AllDeviceTypeID c = new AllDeviceTypeID(resultSet);
            returnValue.add(c);
        }
        
    }

    return returnValue.toArray(new AllDeviceTypeID[returnValue.size()]);
    }


    /**
    *
    * @author Database Repository Generator(Result Class)
    */

 public AllDeviceTypeID create_AllDeviceTypeID() throws java.sql.SQLException{
   return new AllDeviceTypeID();}
    public class AllDeviceTypeID{
    public int device_type_ids = 0;
    public int getDeviceTypeIds(){ return device_type_ids; }

    public String device_type_name = null;
    public String getDeviceTypeName(){ return device_type_name; }


        public AllDeviceTypeID(){}

        public AllDeviceTypeID(java.sql.ResultSet resultSet) throws java.sql.SQLException{

   if(resultSet!=null){
            device_type_ids = resultSet.getInt("device_type_ids");
            device_type_name = resultSet.getString("device_type_name");
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