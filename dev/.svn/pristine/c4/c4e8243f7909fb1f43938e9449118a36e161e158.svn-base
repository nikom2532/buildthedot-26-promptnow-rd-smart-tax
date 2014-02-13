/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.promptnow.rdsmart.api.model;

import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Promptnow11
 */
public class GetTemplatePnd91OuputModel extends CommonAPIOutputModel{
    public GetTemplatePnd91Data responseData;
    
    public class GetTemplatePnd91Data{
        public HashMap<String, String> keys;
        //public KeysData keys;
        public List<FormsData> forms;
    }   
    
    public class KeysData{
    
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
        public String defaultValue;
        public List<SummaryData> summary;
        
        public List<DependOnData> dependOn;
        public List<ConditionsData> conditions;
        public List<ValidateData> validate;
        
    }
    
    public class SummaryData{
        public String identify;
        public String value;
    }
    
    public class DependOnData extends SummaryData{
        public String operate;
    }    

    public class ConditionsData extends SummaryData{
        public String operate;
    }    
    
    public class VariableData extends SummaryListData{
        
    }    
    
    public class ValidateData{
        public VariableData v1;
        public String operate;
        public VariableData v2;
        public String message;
        
    }
    
    public class SummaryListData{
        public List<SummaryData> summary;
    }
}
