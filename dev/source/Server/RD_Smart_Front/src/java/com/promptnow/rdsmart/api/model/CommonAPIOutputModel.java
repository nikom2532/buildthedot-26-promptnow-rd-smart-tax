/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class CommonAPIOutputModel {
    public String responseStatus = "OK";
    public String responseError = "";
    public String authenKey;
    
    
    public boolean isSuccess(){
        if(responseStatus.equalsIgnoreCase("OK") || responseStatus.equalsIgnoreCase("CONFIRM")){
            return true;
        }else{
            return false;
        }
    }
    
    
}
