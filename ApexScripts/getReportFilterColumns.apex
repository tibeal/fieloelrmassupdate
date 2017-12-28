List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
    DeveloperName = 'Points_distributed_per_Program_per_Month'];
String reportId = (String)reportList.get(0).get('Id');

// Run a report
Reports.ReportResults results = Reports.ReportManager.runReport(reportId);

// Get the report metadata
Reports.ReportMetadata rm = results.getReportMetadata();

for(Reports.ReportFilter rf : rm.getreportFilters()){
    system.debug('---col value---'+rf.getcolumn());
    system.debug('---col value---'+rf.getValue());
}
