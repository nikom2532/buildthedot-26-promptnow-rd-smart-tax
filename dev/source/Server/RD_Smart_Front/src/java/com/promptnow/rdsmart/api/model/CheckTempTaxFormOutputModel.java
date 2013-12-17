/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

import java.util.List;

/**
 *
 * @author Promptnow11
 */
public class CheckTempTaxFormOutputModel extends CommonAPIOutputModel{
    
    public CheckTempTaxFormData responseData;
    
    public class CheckTempTaxFormData{
        public List<TempTaxFormData> tmpTaxForm;
        public List<FieldsData> fields;
    }
    public class TempTaxFormData{
        public String sysRefNo;
        public String fillRefNo;
        public String controlCode;
        public String sendFormDate;
        public String paidAmount;
        public String taxYear;
        public String printURL;
    }
    public class FieldsData{
        public String label;
        public String detailLable;
        public List<String> logos;
        public String path;
        public List<String> keys;
    }
    /*public class KeysData{
        public String nid;
        public String fillRefNo;
    }*/
}
