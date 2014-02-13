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
public class CheckStatusOutputModel extends CommonAPIOutputModel{
    public String message;
    public List<FormDetailData> formDetailList;
    public class FormDetailData{
        public String payDate;
        public String officeName;
        public String formType;
        public String seq;
    }
}
