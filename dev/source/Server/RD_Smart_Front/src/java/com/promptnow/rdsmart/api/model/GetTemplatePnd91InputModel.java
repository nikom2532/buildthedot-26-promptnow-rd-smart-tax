/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class GetTemplatePnd91InputModel  extends CommonAPIInputModel {

    public GetTemplatePnd91InputModel() {}
    
    public GetTemplatePnd91InputModel(String nid, String version, String authenKey, String lang) {
        this.nid = nid;
        this.version = version;
        this.authenKey = authenKey;
        this.language = lang;    
    } 
    
}
