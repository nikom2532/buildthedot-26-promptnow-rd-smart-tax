/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class UpdatePnd91CalTaxInputModel extends CommonAPIInputModel{
    public String apiRefNo;
    public String netTaxValue;
    public String totTaxValue;
    public String chkRefund;
    public String partyCode;
    public String smsTax;

    public UpdatePnd91CalTaxInputModel() {
    }

    public UpdatePnd91CalTaxInputModel(String nid, String version,String authenKey, String lang, String apiRefNo, String netTaxValue, String totTaxValue, String chkRefund, String partyCode, String smsTax) {
        this.nid = nid;
        this.version = version;
        this.authenKey = authenKey;
        this.language = lang;
        this.apiRefNo = apiRefNo;
        this.netTaxValue = netTaxValue;
        this.totTaxValue = totTaxValue;
        this.chkRefund = chkRefund;
        this.partyCode = partyCode;
        this.smsTax = smsTax;
    } 
}
