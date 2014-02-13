/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

import java.util.HashMap;

/**
 *
 * @author Promptnow11
 */
public class UpdateTemplatePnd91InputModel extends CommonAPIInputModel {
    
    public HashMap<String, String> keys;
    
    public UpdateTemplatePnd91InputModel() {}
    
    public UpdateTemplatePnd91InputModel(String nid, String version, String authenKey, String lang, HashMap<String, String> keys) {
        this.nid = nid;
        this.version = version;
        this.authenKey = authenKey;
        this.language = lang;
        this.keys = keys;
    } 
    
}
