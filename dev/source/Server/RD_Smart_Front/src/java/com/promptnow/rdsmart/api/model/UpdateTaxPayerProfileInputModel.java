/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Tong
 */
public class UpdateTaxPayerProfileInputModel extends CommonAPIInputModel {

    public String name;
    public String surname;
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
    public String taxpayerStatus;
    public String spouseStatus;
    public String marryStatus;
    public String spouseNid;
    public String spouseName;
    public String spouseSurname;
    public String childNoStudy;
    public String childStudy;
    public String txpFatherPin;
    public String txpMotherPin;
    public String spouseFatherPin;
    public String spouseMotherPin;
    
    public String passportNo;
    public String countryCode;
    public String email;
    public String phoneNumber;
    public String spousePassportNo;
    public String spouseCountryCode;
    public String spouseBirthDate;
    public String middleName;

    public UpdateTaxPayerProfileInputModel() {
    }

    public UpdateTaxPayerProfileInputModel(String nid, String version, String authenKey, String lang, String name, String surname, String buildName, String roomNo, String floorNo, String addressNo, String soi, String village, String mooNo, String street, String tambol, String amphur, String province, String postcode, String taxpayerStatus, String spouseStatus, String marryStatus, String spouseNid, String spouseName, String spouseSurname, String childNoStudy, String childStudy, String txpFatherPin, String txpMotherPin, String spouseFatherPin, String spouseMotherPin, 
            String passportNo, String countryCode, String email, String phoneNumber, String spousePassportNo, String spouseCountryCode, String spouseBirthDate, String middleName) {
        this.nid = nid;
        this.version = version;
        this.authenKey = authenKey;
        this.language = lang;
        this.name = name;
        this.surname = surname;
        this.buildName = buildName;
        this.roomNo = roomNo;
        this.floorNo = floorNo;
        this.addressNo = addressNo;
        this.soi = soi;
        this.village = village;
        this.mooNo = mooNo;
        this.street = street;
        this.tambol = tambol;
        this.amphur = amphur;
        this.province = province;
        this.postcode = postcode;
        this.taxpayerStatus = taxpayerStatus;
        this.spouseStatus = spouseStatus;
        this.marryStatus = marryStatus;
        this.spouseNid = spouseNid;
        this.spouseName = spouseName;
        this.spouseSurname = spouseSurname;
        this.childNoStudy = childNoStudy;
        this.childStudy = childStudy;
        this.txpFatherPin = txpFatherPin;
        this.txpMotherPin = txpMotherPin;
        this.spouseFatherPin = spouseFatherPin;
        this.spouseMotherPin = spouseMotherPin;
        
        this.passportNo = passportNo;
        this.countryCode = countryCode;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.spousePassportNo = spousePassportNo;
        this.spouseCountryCode = spouseCountryCode;
        this.spouseBirthDate = spouseBirthDate;
        this.middleName = middleName;        
        
    }
}
