/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

import java.util.HashMap;
import java.util.List;



/**
 *
 * @author Promptnow11
 */
public class AuthenticateUserIdOutputModel extends CommonAPIOutputModel{
    public AuthenticateUserIdData responseData;
    public String thaiNation;
    
    public class AuthenticateUserIdData {
        //http://jsongen.byingtondesign.com/
        public String nid;    
        public String email; //add
        public String titleName;  
        public String name;  
        public String surname;  
        public String birthDate;  
        public String buildName;  
        public String roomNo;  
        public String floorNo;  
        public String addressNo;  
        public String soi;  
        public String village;  
        public String mooNo;  
        public String street;  
        public String tambol;  
        public String amphur;  
        public String province;  
        public String postcode;  
        public String contractNo;  
        public String indcForm;  
        public String taxpayerStatus;  
        public HashMap<Integer,String> taxpayerHash;  
        public String spouseStatus;  
        public HashMap<Integer,String> spouseHash;  
        public String marryStatus;  
        public HashMap<Integer,String> marryHash;  
        public String spouseNid;  
        public String spouseName;  
        public String spouseSurname;  
        public String spouseBirthDate;
        public String passportNo; //add
        public String countryCode; // add
        public String spousePassportNo;  
        public String spouseCountryCode;  
        public String childNoStudy;  
        public String childStudy;  
        public String txpFatherPin;  
        public String txpMotherPin;  
        public String spouseFatherPin;  
        public String spouseMotherPin;
        public String authenKey; // add
        
        public String satisdaction;  
        public SatisfactionDataModel satisfactionData;   
        
        public String thaiNation;
        public String middleName = "";
    }
    
    public class SatisfactionDataModel {
        public String detailLabel; 
        public List<ChoicesDataModel> choices;
    }
    
    public class ChoicesDataModel {
        public String label;  
        public String value;  
    }
    
    
}
//class AuthenticateUserIdData{
//    public String nid;
//    public String titleName;
//    public String name;
//    public String surname;
//    
//    
//} 
