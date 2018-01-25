List<FieloPLT__PageSettings__c> kpiPS = [SELECT Id FROM FieloPLT__PageSettings__c WHERE FieloPLT__Object__c = 'FieloPLT__KPI__c' OR FieloPLT__TargetObject__c = 'FieloPLT__KPI__c'];

for (FieloPLT__PageSettings__c ps: kpiPS) {
  ps.FieloPLT__IsActive__c = true;
}

update kpiPS;
