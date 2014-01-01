/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class CheckStatusInputModel extends CommonAPIInputModel{
    public String authenKey;
    public String name;
    public String surname;

    public CheckStatusInputModel() {
    }

    public CheckStatusInputModel(String nid, String version, String authenKey, String name, String surname) {
        this.authenKey = authenKey;
        this.name = name;
        this.surname = surname;
    }
}