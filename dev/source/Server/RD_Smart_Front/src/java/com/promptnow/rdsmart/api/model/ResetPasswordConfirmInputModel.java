/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Tong
 */
public class ResetPasswordConfirmInputModel extends CommonAPIInputModel{
    
    public String email;
    
    public ResetPasswordConfirmInputModel() {
    }

    public ResetPasswordConfirmInputModel(String nid, String lang, String authenKey, String email, String version) {
        this.nid = nid;
        this.email = email;
        this.version = version;
        this.language = lang;
        this.authenKey = authenKey;
    }
}
