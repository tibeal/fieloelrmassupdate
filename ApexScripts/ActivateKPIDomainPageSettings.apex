List<FieloPLT__PageSettings__c> kpiDomainPS = [SELECT Id FROM FieloPLT__PageSettings__c WHERE FieloPLT__Object__c = 'FieloPLT__KPIDomain__c' OR FieloPLT__TargetObject__c = 'FieloPLT__KPIDomain__c'];

for (FieloPLT__PageSettings__c ps: kpiDomainPS) {
  ps.FieloPLT__IsActive__c = true;
}

update kpiDomainPS;
