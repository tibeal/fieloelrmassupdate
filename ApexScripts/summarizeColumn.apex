List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
    DeveloperName = 'PointsPerPromotion'];
String reportId = (String)reportList.get(0).get('Id');

String reportField = 's!FieloPLT__Point__c.FieloPLT__TotalPoints__c';

// Run a report
Reports.ReportResults results = Reports.ReportManager.runReport(reportId);

// Get the report metadata
Reports.ReportMetadata rm = results.getReportMetadata();

System.debug(
  JSON.serializePretty(results)
);

List<String> aggregations = rm.getAggregates();

Integer indexOf=-1;

if (new Set<String>(aggregations).contains(reportField)) {
  for(String column: aggregations){
    indexOf++;
    if (column == reportField) {
      break;
    }
  }
}

if (indexOf!=-1) {
  Map<String,Reports.ReportFact> fact = results.getFactMap();
  Decimal summaryTotal = 0;
  String factKey = 'T!T';
  if(fact.containsKey(factKey))  {
    summaryTotal += (Decimal) fact.get(factKey).getAggregates()[indexOf].getValue();
  }
  System.debug('Summary Total: ' + summaryTotal);
}
