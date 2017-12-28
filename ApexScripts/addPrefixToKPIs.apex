List<FieloPLT__KPI__c> kpis = [Select Id, FieloPLT__ReportUniqueName__c From FieloPLT__KPI__c];

for (FieloPLT__KPI__c kpi: kpis) {
  if (kpi.FieloPLT__ReportUniqueName__c != null) {
    if (!kpi.FieloPLT__ReportUniqueName__c.tolowercase().contains('fieloplt__')) {
        kpi.FieloPLT__ReportUniqueName__c = 'fieloplt__' + kpi.FieloPLT__ReportUniqueName__c;
    }
  }
}

update kpis;
