/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class SendSatisfactionInputModel extends CommonAPIInputModel{
    public String authenKey;
    public String value;

    public SendSatisfactionInputModel() {
    }

    public SendSatisfactionInputModel(String nid, String version, String authenKey, String value) {
        this.nid = nid;
        this.version = version;
        this.authenKey = authenKey;
        this.value = value;
    }
    
}
