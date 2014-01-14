/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class ConfirmRequestPasswordInputModel extends CommonAPIInputModel{
    public String name;
    public String surName;
    public String birthDate;
    public String fatherName;
    public String motherName;
    public String passportNo;
    public String countryCode;

    public ConfirmRequestPasswordInputModel() {
    }

    public ConfirmRequestPasswordInputModel(String nid, String lang, String authenKey, String name, String surName, String birthDate, String fatherName, String motherName, String passportNo, String countryCode, String version) {
        this.nid = nid;
        this.language = lang;
        this.authenKey = authenKey;
        this.name = name;
        this.surName = surName;
        this.birthDate = birthDate;
        this.fatherName = fatherName;
        this.motherName = motherName;
        this.passportNo = passportNo;
        this.countryCode = countryCode;
        this.version = version;
    }
    
    
    
}
