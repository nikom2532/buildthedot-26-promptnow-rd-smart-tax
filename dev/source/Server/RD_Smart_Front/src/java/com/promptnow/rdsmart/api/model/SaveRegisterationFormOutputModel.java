/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class SaveRegisterationFormOutputModel extends CommonAPIOutputModel{
    
    public SaveRegisterationFormData responseData;
    
    public class SaveRegisterationFormData{
        public String nid;
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
        public String taxpayerStatus;
        public String taxpayerHash;
        public String spouseStatus;
        public String spouseHash;
        public String marryStatus;
        public String spouseNid;
        public String spouseName;
        public String spouseSurname;
        public String spouseBirthDate;
        public String spousePassportNo;
        public String spouseCountryCode; 
        public String childNoStudy;
        public String childStudy;
        public String txpFatherPin;
        public String txpMotherPin;
        public String spouseFatherPin;
        public String spouseMotherPin;
    } 
}
