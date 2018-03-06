set<String> records = new set<String>();
records.add('fieloplt__action__c');		records.add('fieloplt__agreement__c');
records.add('fieloplt__badge__c');		records.add('fieloplt__challenge__c');
records.add('fieloplt__challengereward__c');	records.add('fieloplt__criterion__c');
records.add('fieloplt__criteriongroup__c');		records.add('fieloplt__emailcampaign__c');
records.add('fieloplt__emailtemplate__c');		records.add('fieloplt__kpi__c');
records.add('fieloplt__kpidomain__c');		records.add('fieloplt__level__c');
records.add('fieloplt__library__c');		records.add('fieloplt__mission__c');
records.add('fieloplt__model__c');		records.add('fieloplt__pagesettings__c');
records.add('fieloplt__pointtype__c');		records.add('fieloplt__program__c');
records.add('fieloplt__programassignment__c');	records.add('fieloplt__programpointtype__c');
records.add('fieloplt__promotion__c');		records.add('fieloplt__reward__c');
records.add('fieloplt__rule__c');		records.add('fieloplt__ruletrigger__c');
records.add('fieloplt__segment__c');

Integer num = 0;
for(String obj: records){
    List<SObject> records = Database.query('SELECT Id, Name, ' + (obj == 'fieloplt__programassignment__c' ? 'FieloPLT__External_Id__c' : 'FieloPLT__ExternalId__c') + ' FROM ' + obj + ' WHERE ' + (obj == 'fieloplt__programassignment__c' ? 'FieloPLT__External_Id__c' : 'FieloPLT__ExternalId__c') + ' = NULL');
    if(!records.isEmpty()){
        for(SObject so: records){
            if(obj == 'fieloplt__programassignment__c'){
                so.put( 'FieloPLT__External_Id__c', String.ValueOf(so.get('Name')).replaceAll('[^a-zA-Z0-9]', '') );
            } else {
                so.put( 'FieloPLT__ExternalId__c', String.ValueOf(so.get('Name')).replaceAll('[^a-zA-Z0-9]', '') + '_' + num );
                num++;
            }
        }
        update records;
    }
}
