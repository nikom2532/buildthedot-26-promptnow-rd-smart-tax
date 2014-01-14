/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class SaveRegisterationInputModel extends CommonAPIInputModel{    
    public String name;
    public String surname;
    public String birthDate;
    public String passportNo;
    public String countryCode;
    public String fatherName;
    public String motherName;
    public String telephone;
    public String telephoneExtension;
    public String password;
    public String questionId;
    public String answer;
    public String email;
    public String moiFlag;
    public String middleName;

    public SaveRegisterationInputModel() {
    }
    
    
    public SaveRegisterationInputModel(String nid, String lang, String version, String name, String surname, String birthDate, String passportNo, String countryCode, String fatherName, String motherName, String telephone, String telephoneExtension, String password, String questionId, String answer, String email, String moiFlag, String middleName) {
        this.nid = nid;
        this.language = lang;
        this.version = version;
        this.name = name;
        this.surname = surname;
        this.birthDate = birthDate;
        this.passportNo = passportNo;
        this.countryCode = countryCode;
        this.fatherName = fatherName;
        this.motherName = motherName;
        this.telephone = telephone;
        this.telephoneExtension = telephoneExtension;
        this.password = password;
        this.questionId = questionId;
        this.answer = answer;
        this.email = email;
        this.moiFlag = moiFlag;
        this.middleName = motherName;
    }    
}
