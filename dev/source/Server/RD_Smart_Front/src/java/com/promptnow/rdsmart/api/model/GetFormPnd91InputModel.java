/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class GetFormPnd91InputModel extends CommonAPIInputModel{
    public String authenKey;

    public GetFormPnd91InputModel() {
    }

    public GetFormPnd91InputModel(String nid, String authenKey, String version) {
        this.nid = nid;
        this.authenKey = authenKey;
        this.version = version;
    }
    
}
