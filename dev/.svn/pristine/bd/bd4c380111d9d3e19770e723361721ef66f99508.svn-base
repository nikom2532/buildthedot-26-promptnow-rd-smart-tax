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
public class GetPnd91CalTaxOutputModel extends CommonAPIOutputModel{
    
    public GetPnd91CalTaxData responseData;
    
    public class GetPnd91CalTaxData{
        public String apiRefNo;
        public String nid;
        public KeysData keys;
        public List<FormsData> forms;
    }
    public class KeysData{
        public String nid;
        public String apiRefNo;
        public String netTaxValue;
        public String totTaxValue;
        public String chkRefund;
        public String partySelect;
        public String smsTax;
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
