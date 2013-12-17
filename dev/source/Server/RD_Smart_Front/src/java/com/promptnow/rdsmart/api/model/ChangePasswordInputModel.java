package com.promptnow.rdsmart.api.model;

import com.promptnow.rdsmart.api.model.CommonAPIInputModel;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Tong
 */
public class ChangePasswordInputModel extends CommonAPIInputModel {

    public String userId;
    public String oldPassword;
    public String newPassword;

    public ChangePasswordInputModel() {
    }

    public ChangePasswordInputModel(String userId, String oldPassword,
            String newPassword) {
        this.userId = userId;
        this.oldPassword = oldPassword;
        this.newPassword = newPassword;
    }
}