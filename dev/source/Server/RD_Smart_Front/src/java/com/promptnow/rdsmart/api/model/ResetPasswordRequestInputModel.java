/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Tong
 */
public class ResetPasswordRequestInputModel extends CommonAPIInputModel{
    
    public String birthDate;
    
    public ResetPasswordRequestInputModel() {
    }

    public ResetPasswordRequestInputModel(String nid, String lang, String authenKey, String birthDate, String version) {
        this.nid = nid;
        this.birthDate = birthDate;
        this.version = version;
        this.language = lang;
        this.authenKey = authenKey;
    }
}
