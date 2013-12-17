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
public class GetFormPnd91OutputModel extends CommonAPIOutputModel{
    
    public GetFormPnd91Data responseData;
    
    public class GetFormPnd91Data{
        public String apiRefNo;
        public String nid;
        public KeysData keys;
        public List<FormsData> forms;
    }
    public class KeysData{
        public String nid;
        public String apiRefNo;
        public String assblInc;
        public String whtTax;
        public String incomePayer;
        public String expfPd1;
        public String expfPd2;
        public String exAge65;
        public String qpdInc;
        public String allMoneyExempt;
        public String allw;
        public String spoAllw;
        public String childNoStudy;
        public String childNoStudyAmt;
        public String childStd;
        public String childStudyAmt;
        public String txpFatherPin;
        public String txpMotherPin;
        public String spouseFatherPin;
        public String spouseMotherPin;
        public String txpFatherPinValue;
        public String txpMotherPinValue;
        public String spouseFatherPinValue;
        public String spouseMotherPinValue;
        public String calIns;
        public String txpFaPinIns;
        public String txpMoPinIns;
        public String spoFaPinIns;
        public String spoMoPinIns;
        public String spoInsAmt;
        public String expfPd3;
        public String expfPd4;
        public String intLoan;
        public String otherAmt;
        public String ssfAmt;
        public String allMoneyAllowances;
        public String propertyAmt;
        public String propertyPrice;
        public String overTax;
        public String retireInsAmtResult;
        public String insAmtResult;
        public String pvdAmtOfAllw;
        public String pvdAmtOfExcept;
        public String eduAmtResult;
        public String donAmtResult;
    }
    public class FormsData{
        public String formId;
        public String formName;
        public List<FormData> formData;
    }
    public class FormData{
        public String header;
        public List<FieldsData> fields;
    }
    public class FieldsData{
        public String identify;
        public String label;
        public String type;
        public String keyboardType;
        public String placeholder;
        public String secure;
        public String format;
        public String hidden;
        public List<FieldSummaryData> summary;
        public List<DependOnData> dependOn;
        public List<ConditionsData> conditions;
        public List<ValidateData> validate;
        public FormsData forms;
        public List<ItemsData> items;
    }
    public class SummaryData{
        public String identify;
        public String value;
    }
    public class FieldSummaryData extends SummaryData{
        public List<String> values;
        public SummaryListData maximum;
    }
    public class ConditionsData extends FieldSummaryData{
        public String operate;
    }
    public class DependOnData extends ConditionsData{
        public List<FieldsData> fields;
    }
    public class ValidateData{
        public VariableData v1;
        public String operate;
        public VariableData v2;
        public String Message;
        
    }
    public class SummaryListData{
        public List<SummaryData> summary;
    }
    public class VariableData extends SummaryListData{
    }
    public class ItemsData{
        public String key;
        public String data;
    }
}
