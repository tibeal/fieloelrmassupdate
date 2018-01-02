Id cRecordId = 'a0i1I0000016xopQAA';
List<FieloPLT__KPIDomain__c> kpiDomains;
Set<String> fields = new Set<String>();
fields.addAll(Schema.describeSObjects(new String[]{'FieloPLT__KPIDomain__c'})[0].fields.getMap().keySet());
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.Name');
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.FieloPLT__Type__c');
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.FieloPLT__ReportUniqueName__c');
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.FieloPLT__ReportMetadata__c');
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.FieloPLT__ReportObjectiveField__c');
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.FieloPLT__ReportType__c');
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.FieloPLT__ReportClass__c');
fields.add('FieloPLT__KPIDomain__c.FieloPLT__KPI__r.FieloPLT__ReportFilter__c');
String query = 'SELECT ' + String.join(new List<String>(fields), ',') +
' FROM FieloPLT__KPIDomain__c WHERE FieloPLT__Promotion__c = :cRecordId ORDER BY FieloPLT__Order__c, CreatedDate';
kpiDomains = (List<FieloPLT__KPIDomain__c>) Database.query(query);

Map<Id, Decimal> recordSummary = new Map<Id, Decimal>();
Map<Id,String> reportByKPIDomain = new Map<Id,String>();
Set<String> reportNames = new Set<String>();
List<String> prefixNames = new List<String>();
List<String> developerNameAndPrefix = new List<String>();

for(FieloPLT__KPIDomain__c kpiDomain: kpiDomains) {
    if (kpiDomain.FieloPLT__KPI__r.FieloPLT__ReportType__c == 'Standard' && !kpiDomain.FieloPLT__Snapshot__c) {
        developerNameAndPrefix = kpiDomain.FieloPLT__KPI__r.FieloPLT__ReportUniqueName__c.split('__');
        if (developerNameAndPrefix.size()==1) {
            reportNames.add(developerNameAndPrefix[0]);
        } else if (developerNameAndPrefix.size()==2) {
            prefixNames.add(developerNameAndPrefix[0]);
            reportNames.add(developerNameAndPrefix[1]);
        }
    }
}

List<Report> existingReports = Database.query('SELECT Id, NamespacePrefix , DeveloperName From Report WHERE DeveloperName in :reportNames' +
    (!prefixNames.isEmpty() ? ' AND NamespacePrefix in :prefixNames': '')
);
Map<String, Reports.ReportMetadata> reportMdMap = new Map<String, Reports.ReportMetadata>();


for (Report existingReport:existingReports) {
    reportMdMap.put(
        ((existingReport.NamespacePrefix != null ? existingReport.NamespacePrefix + '__' : '') + existingReport.DeveloperName).toLowerCase(),
        Reports.ReportManager.describeReport(existingReport.Id).getReportMetadata()
    );
}

Reports.ReportResults results;
Reports.ReportMetadata reportMd;
List<String> aggregations;
Integer indexOf;
Map<String,Reports.ReportFact> fact;
Decimal summaryTotal = 0;
String factKey = 'T!T';

for(FieloPLT__KPIDomain__c kpiDomain: kpiDomains) {
    if (kpiDomain.FieloPLT__KPI__r.FieloPLT__ReportType__c == 'Standard') {
        if (!kpiDomain.FieloPLT__Snapshot__c) {
            if (reportMdMap.containsKey(kpiDomain.FieloPLT__KPI__r.FieloPLT__ReportUniqueName__c.toLowerCase())) {
                reportMd = reportMdMap.get(kpiDomain.FieloPLT__KPI__r.FieloPLT__ReportUniqueName__c.toLowerCase());

                results = Reports.ReportManager.runReport(reportMd.getId(), reportMd);
                aggregations = results.getReportMetadata().getAggregates();
                indexOf=-1;
                summaryTotal = 0;
                if (new Set<String>(aggregations).contains(kpiDomain.FieloPLT__KPI__r.FieloPLT__ReportObjectiveField__c)) {
                  for(String column: aggregations){
                    indexOf++;
                    if (column == kpiDomain.FieloPLT__KPI__r.FieloPLT__ReportObjectiveField__c) {
                      break;
                    }
                  }
                }
                if (indexOf!=-1) {
                  fact = results.getFactMap();
                  if(fact.containsKey(factKey))  {
                    summaryTotal += (Decimal) fact.get(factKey).getAggregates()[indexOf].getValue();
                  }
                  recordSummary.put(kpiDomain.Id, summaryTotal);
                }
            }
        } else {
            recordSummary.put(kpiDomain.Id, kpiDomain.FieloPLT__Performance__c);
        }
    }
}

system.debug(
  JSON.serializePretty(recordSummary)
);
