/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class ChosenCounterServiceInputModel extends CommonAPIInputModel{
    public String fillRefNo;

    public ChosenCounterServiceInputModel() {
    }

    public ChosenCounterServiceInputModel(String nid, String version, String authenKey, String lang, String fillRefNo) {
        this.nid = nid;
        this.version = version;
        this.authenKey = authenKey;
        this.language = lang;
        this.fillRefNo = fillRefNo;
    }
    
}
