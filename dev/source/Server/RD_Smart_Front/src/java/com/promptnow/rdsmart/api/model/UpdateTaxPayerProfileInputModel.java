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
    public String spouseStatus;
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

    public UpdateTaxPayerProfileInputModel() {
    }

    public UpdateTaxPayerProfileInputModel(String nid, String titleName, String name, String surname, String birthDate, String buildName, String roomNo, String floorNo, String addressNo, String soi, String village, String mooNo, String street, String tambol, String amphur, String province, String postcode, String contractNo, String indcForm, String taxpayerStatus, String spouseStatus, String marryStatus, String spouseNid, String spouseName, String spouseSurname, String spouseBirthDate, String spousePassportNo, String spouseCountryCode, String childNoStudy, String childStudy, String txpFatherPin, String txpMotherPin, String spouseFatherPin, String spouseMotherPin) {
        this.nid = nid;
        this.titleName = titleName;
        this.name = name;
        this.surname = surname;
        this.birthDate = birthDate;
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
        this.contractNo = contractNo;
        this.indcForm = indcForm;
        this.taxpayerStatus = taxpayerStatus;
        this.spouseStatus = spouseStatus;
        this.marryStatus = marryStatus;
        this.spouseNid = spouseNid;
        this.spouseName = spouseName;
        this.spouseSurname = spouseSurname;
        this.spouseBirthDate = spouseBirthDate;
        this.spousePassportNo = spousePassportNo;
        this.spouseCountryCode = spouseCountryCode;
        this.childNoStudy = childNoStudy;
        this.childStudy = childStudy;
        this.txpFatherPin = txpFatherPin;
        this.txpMotherPin = txpMotherPin;
        this.spouseFatherPin = spouseFatherPin;
        this.spouseMotherPin = spouseMotherPin;
    }
}
