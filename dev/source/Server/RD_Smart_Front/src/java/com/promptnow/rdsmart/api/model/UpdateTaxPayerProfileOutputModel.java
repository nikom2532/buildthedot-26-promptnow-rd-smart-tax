/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

import java.util.HashMap;
import java.util.List;


/**
 *
 * @author Tong
 */
public class UpdateTaxPayerProfileOutputModel extends CommonAPIOutputModel{
    
    public UpdateTaxPayerProfileData responseData;
    
    public class UpdateTaxPayerProfileData {
        public String nid; 
        public String email;
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
        public String passsportNo;
        public String countryCode;
        public String spousePassportNo; 
        public String spouseCountryCode; 
        public String childNoStudy; 
        public String childStudy; 
        public String txpFatherPin; 
        public String txpMotherPin; 
        public String spouseFatherPin; 
        public String spouseMotherPin; 
        public String authenKey;
        
        public String middleName;
        public String satisdaction;  
        public SatisfactionDataModel satisfactionData;    
        
        public String thaiNation = "1";

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
