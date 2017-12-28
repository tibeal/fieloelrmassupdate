//Static resource to validate
Id staticResourceId = '0816A000000R3trQAC';

//Wrapper Classes
public class ValidatorFilterWrapper{
      public String andOrOperator;
      public String openPars;
      public String field;
      public String operator;
      public String value;
      public String closePars;
}

public class ValidatorSection {
    public String Name{get;set;}
    public List<List<ValidatorFormField>> Rows{get;set;}
    public String CssClass{get;set;}
}

public class ValidatorFormField {
  public String Type{get;set;}
  public String MetaField{get;set;}
  public String Name{get;set;}
  public String onchange{get;set;}
  public String Label{get;set;}
  public String Value{get;set;}
  public String WhereCondition{get;set;}
  public Boolean Required{get;set;}
  public Boolean ReadOnly{get;set;}
  public String SearchField{get;set;}
}

//Validation Begins
//Searghing for Static Resource
StaticResource r = [SELECT Id, Name, NamespacePrefix, SystemModStamp, Body FROM StaticResource WHERE Id=:staticResourceId LIMIT 1];

//Walking thru the JSON structure
Map<String,Object> library = (Map<String,Object>) JSON.deserializeUntyped(r.Body.toString());

List<Object> librariesList = (List<Object>) library.get('Libraries');

Map<String,Object> fieloelr = (Map<String,Object>) librariesList[0];

List<Object> pageSettingsList = (List<Object>) fieloelr.get('pageSettings');

Map<String,Object> pageSetting;

//Loop thru page settings and validate each one
for(Object pso: pageSettingsList) {
  pageSetting = (Map<String,Object>) pso;
  System.debug('Validating PageSetting: ' + String.valueOf(pageSetting.get('Name')));
  if (String.isNotBlank(String.valueOf(pageSetting.get('FieloPLT__Sections__c')))) {
    try{
        JSON.deserialize( '[' + String.valueOf(pageSetting.get('FieloPLT__Sections__c')) + ']', List<ValidatorSection>.class );
        System.debug('Success');
    } catch( JSONException e ) {
        System.debug('INVALID SECTION JSON');
    }
  }
  if (String.isNotBlank(String.valueOf(pageSetting.get('FieloPLT__Visibility__c')))) {
    try{
        JSON.deserialize(String.valueOf(pageSetting.get('FieloPLT__Visibility__c')), List<ValidatorFilterWrapper>.class);
        System.debug('Success');
    } catch( JSONException e ) {
        System.debug('INVALID VISIBILITY JSON');
    }
  }
}
