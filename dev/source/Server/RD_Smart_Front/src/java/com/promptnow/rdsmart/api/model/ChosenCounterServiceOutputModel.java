/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

/**
 *
 * @author Promptnow11
 */
public class ChosenCounterServiceOutputModel extends CommonAPIOutputModel{
    public ChosenCounterServiceData responseData;
    public class ChosenCounterServiceData{
        public String slipURL;
        public String notice;
    }
}
