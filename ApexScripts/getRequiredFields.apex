List<String> objects = new List<String>{'Account','Lead','Contact'};

Schema.DescribeSobjectResult[] results = Schema.describeSObjects(objects);

Map<String,Schema.SObjectField> fieldsTypeMapSubQuery;
Schema.DescribeFieldResult fieldDescribe;
Map<String,List<String>> fieldNamesByObject = new Map<String,List<String>>();
List<String> fieldNames = new List<String>();
for (Schema.DescribeSobjectResult result: results) {
    fieldsTypeMapSubQuery = result.fields.getMap();
    fieldNames = new List<String>();
    for (Schema.SObjectField field: fieldsTypeMapSubQuery.values()) {
      fieldDescribe = field.getDescribe();
      if (!fieldDescribe.isNillable()) {
        fieldNames.add(fieldDescribe.getName());
      }
    }
    fieldNamesByObject.put(result.getName(), fieldNames);
}

system.debug(JSON.serializePretty(fieldNamesByObject));
