List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
    Id = '00O50000005r8a4'];
String reportId = (String)reportList.get(0).get('Id');

// Run a report
Reports.ReportResults results = Reports.ReportManager.runReport(reportId);

// Get the report metadata
Reports.ReportMetadata rm = results.getReportMetadata();

system.debug( JSON.serializePretty(rm.getAggregates()));
