List<FieloPLT__KPIDomain__c> kpiDomains = [SELECT FieloPLT__Program__c, FieloPLT__KPI__c From FieloPLT__KPIDomain__c Where FieloPLT__Program__c = 'a0S50000007xwbIEAQ'];

List<FieloPLT__KPIDomain__c> newKPIDomains = new List<FieloPLT__KPIDomain__c>();

Id targetProgram = 'a0S50000008C52cEAC';

for (FieloPLT__KPIDomain__c kpiDomain: kpiDomains) {
  newKPIDomains.add(
    kpiDomain.clone(false,false,false,false)
  );
  newKPIDomains[newKPIDomains.size()-1].FieloPLT__Program__c = targetProgram;
}

system.debug(
  JSON.serializePretty(newKPIDomains)
);

insert newKPIDomains;
