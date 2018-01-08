List<FieloPLT__KPI__c> kpis = new List<FieloPLT__KPI__c>();
List<FieloPLT__KPI__c> kpisToDelete = new List<FieloPLT__KPI__c>();
List<FieloPLT__KPIDomain__c> kpiDomains = new List<FieloPLT__KPIDomain__c>();

List<AggregateResult> dupRecords = [Select Name, Count(Id) DUPS From FieloPLT__KPI__c GROUP BY Name];

Set<String> dupKPIs = new Set<String>();
for(AggregateResult qr : dupRecords){
    if ( (Decimal)qr.get('DUPS') > 1 ) {
        dupKPIs.add((String)qr.get('Name'));
    }
}

kpis = [SELECT Id, Name, FieloPLT__ReportUniqueName__c FROM FieloPLT__KPI__c];
kpiDomains = [Select Id, Name, FieloPLT__KPI__c From FieloPLT__KPIDomain__c];

Set<Id> usedKPIs = new Set<Id>();

for(FieloPLT__KPIDomain__c kd: kpiDomains) {
    usedKPIs.add(kd.FieloPLT__KPI__c);
}

for (FieloPLT__KPI__c kpi: kpis) {
    if (!usedKPIs.contains(kpi.Id) && dupKPIs.contains(kpi.Name)) {
       kpisToDelete.add(kpi);
    }
}

for (FieloPLT__KPI__c kpi: kpisToDelete) {
  system.debug(kpi.Name);
}

// Uncomment to delete records!!!

// delete kpisToDelete;
