/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Tong
 */
public class AuthenticateUserIdInputModel extends CommonAPIInputModel{
    public String userId;
    public String password;
    
    public AuthenticateUserIdInputModel() {
    }

    public AuthenticateUserIdInputModel(String userId, String password, String version, String lang) {
        this.userId = userId;
        this.password = password;
        this.version = version;
        this.language = lang;
    }
}
