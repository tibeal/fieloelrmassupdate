List<FieloPLT__KPI__c> kpis = [SELECT Id, FieloPLT__Type__c FROM FieloPLT__KPI__c];
List<FieloPLT__KPIDomain__c> kpiDomains = new List<FieloPLT__KPIDomain__c>();

List<FieloPLT__Challenge__c> challenges = [Select Id From FieloPLT__Challenge__c];
List<FieloPLT__Promotion__c> promotions = [Select Id From FieloPLT__Promotion__c];
List<FieloPLT__Program__c> programs = [Select Id From FieloPLT__Program__c];

for (FieloPLT__KPI__c kpi: kpis) {
  // Challenges
  if (kpi.FieloPLT__Type__c == 'Challenge') {
    for (FieloPLT__Challenge__c challenge: challenges) {
      kpiDomains.add(
        new FieloPLT__KPIDomain__c(
          FieloPLT__Challenge__c = challenge.Id,
          FieloPLT__KPI__c = kpi.Id
        )
      );
    }
  }

  //promotions
  if (kpi.FieloPLT__Type__c == 'Promotion') {
    for (FieloPLT__Promotion__c promotion: promotions) {
      kpiDomains.add(
        new FieloPLT__KPIDomain__c(
          FieloPLT__Promotion__c = promotion.Id,
          FieloPLT__KPI__c = kpi.Id
        )
      );
    }
  }

  //Program
  if (kpi.FieloPLT__Type__c == 'Program') {
    for (FieloPLT__Program__c program: programs) {
      kpiDomains.add(
        new FieloPLT__KPIDomain__c(
          FieloPLT__Program__c = program.Id,
          FieloPLT__KPI__c = kpi.Id
        )
      );
    }
  }
}

insert kpiDomains;
