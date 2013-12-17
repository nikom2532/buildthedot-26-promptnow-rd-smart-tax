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
public class PrintFormReceiptOutputModel extends CommonAPIOutputModel{
    
    public PrintFormReceiptData responseData;
    
    public class PrintFormReceiptData{
        public String nid;
        public String formCode;
        public String formType;
        public String taxYear;
        public List<PrintFormReceiptFormData> formData;
    }
    
    public class PrintFormReceiptFormData{
        public String receiptNo;
        public String sysRefNo;
        public String refNo;
        public String payDate;
        public String taxMonth;
        public String taxAmount;
        public String printURL;
    }
}
