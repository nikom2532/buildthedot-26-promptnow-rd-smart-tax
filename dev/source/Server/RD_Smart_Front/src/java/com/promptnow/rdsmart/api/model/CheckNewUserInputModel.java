/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class CheckNewUserInputModel extends CommonAPIInputModel{

    public CheckNewUserInputModel() {
    }

    public CheckNewUserInputModel(String nid, String version, String lang) {
        this.nid = nid;
        this.version = version;
        this.language = lang;
    }

}
