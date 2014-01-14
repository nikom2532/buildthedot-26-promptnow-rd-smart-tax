package com.promptnow.rdsmart.db;

import com.google.gson.Gson;
/**
*
* @author Database Repository Generator
*/

public class CountryApplication{

    public String datasourceName = "";

    public CountryApplication(String datasourceName){
        this.datasourceName = datasourceName; 
    }

    public CountryApplication(){
        this.datasourceName = com.promptnow.framework.vulcan.VulcanCore.getConfig("DB_DSNAME"); 
    }


    /** Database Repository Generator Function **/
    public ListProvince[] getProvince() throws java.sql.SQLException{
String SQL = "SELECT PROVINCE_IDS,PROVINCE_NAME FROM CT_PROVINCE ORDER BY PROVINCE_NAME";
    java.util.ArrayList<ListProvince> returnValue = new java.util.ArrayList<ListProvince>();

    java.sql.ResultSet resultSet = com.promptnow.framework.vulcan.database.DBCore.executeQuery(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL);
    if(resultSet!=null){
        resultSet.beforeFirst();
        while(resultSet.next()){
            ListProvince c = new ListProvince(resultSet);
            returnValue.add(c);
        }
        
    }

    return returnValue.toArray(new ListProvince[returnValue.size()]);
    }


    /**
    *
    * @author Database Repository Generator(Result Class)
    */

 public ListProvince create_ListProvince() throws java.sql.SQLException{
   return new ListProvince();}
    public class ListProvince{
    public String PROVINCE_IDS = null;
    public String getProvinceIds(){ return PROVINCE_IDS; }

    public String PROVINCE_NAME = null;
    public String getProvinceName(){ return PROVINCE_NAME; }


        public ListProvince(){}

        public ListProvince(java.sql.ResultSet resultSet) throws java.sql.SQLException{

   if(resultSet!=null){
            PROVINCE_IDS = resultSet.getString("PROVINCE_IDS");
            PROVINCE_NAME = resultSet.getString("PROVINCE_NAME");
        }
        }
    }



    /** Database Repository Generator Function **/
    public ListAmpTomb[] getAmpTomb(String provinceID) throws java.sql.SQLException{
String SQL = "SELECT AMPHUR_IDS,AMPHUR_NAME,TOMBOL_IDS,TOMBOL_NAME FROM CT_AMPHUR INNER JOIN CT_TOMBOL ON CT_AMPHUR.AMPHUR_IDS = CT_TOMBOL.AMPHUR_ID WHERE CT_AMPHUR.PROVINCE_ID = ? ORDER BY AMPHUR_NAME,TOMBOL_NAME";
    java.util.ArrayList<ListAmpTomb> returnValue = new java.util.ArrayList<ListAmpTomb>();

    java.sql.ResultSet resultSet = com.promptnow.framework.vulcan.database.DBCore.executePrepareQuery(com.promptnow.framework.vulcan.database.DBCore.getDBConnection(datasourceName),SQL,provinceID);
    if(resultSet!=null){
        resultSet.beforeFirst();
        while(resultSet.next()){
            ListAmpTomb c = new ListAmpTomb(resultSet);
            returnValue.add(c);
        }
        
    }

    return returnValue.toArray(new ListAmpTomb[returnValue.size()]);
    }


    /**
    *
    * @author Database Repository Generator(Result Class)
    */

 public ListAmpTomb create_ListAmpTomb() throws java.sql.SQLException{
   return new ListAmpTomb();}
    public class ListAmpTomb{
    public String AMPHUR_IDS = null;
    public String getAmphurIds(){ return AMPHUR_IDS; }

    public String AMPHUR_NAME = null;
    public String getAmphurName(){ return AMPHUR_NAME; }

    public String TOMBOL_IDS = null;
    public String getTombolIds(){ return TOMBOL_IDS; }

    public String TOMBOL_NAME = null;
    public String getTombolName(){ return TOMBOL_NAME; }


        public ListAmpTomb(){}

        public ListAmpTomb(java.sql.ResultSet resultSet) throws java.sql.SQLException{

   if(resultSet!=null){
            AMPHUR_IDS = resultSet.getString("AMPHUR_IDS");
            AMPHUR_NAME = resultSet.getString("AMPHUR_NAME");
            TOMBOL_IDS = resultSet.getString("TOMBOL_IDS");
            TOMBOL_NAME = resultSet.getString("TOMBOL_NAME");
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