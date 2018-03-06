List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
    DeveloperName = 'AvailableCourses'];
String reportId = (String)reportList.get(0).get('Id');

// Describe the report
Reports.ReportDescribeResult describeResults = Reports.ReportManager.describeReport(reportId);

// Get report type metadata
Reports.ReportTypeMetadata reportTypeMetadata = describeResults.getReportTypeMetadata();

// Get report type column categories
List<Reports.ReportTypeColumnCategory> reportTypeColumnCategories = reportTypeMetadata.getCategories();

System.debug('reportTypeColumnCategories: ');
System.debug(JSON.serializePretty(reportTypeColumnCategories));
