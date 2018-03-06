List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
    DeveloperName = 'AvailableCourses'];
String reportId = (String)reportList.get(0).get('Id');

// Run a report
Reports.ReportResults results = Reports.ReportManager.runReport(reportId);

// Get the report metadata
Reports.ReportMetadata rm = results.getReportMetadata();

System.debug('Metadata');
System.debug(JSON.serializePretty(rm));
System.debug('Filters');
System.debug(JSON.serializePretty(rm.getreportFilters()));
System.debug('Results');
System.debug(JSON.serializePretty(results));
System.debug('Details');
System.debug(JSON.serializePretty(rm.getBuckets()));




/* Get Possible Filter Operators

system.debug(
    JSON.serializePretty(Reports.ReportManager.getDatatypeFilterOperatorMap())
);

*/
