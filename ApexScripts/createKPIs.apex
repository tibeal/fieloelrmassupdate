Id ruleTriggerId = [SELECT Id FROM FieloPLT__RuleTrigger__c Where FieloPLT__UniqueKey__c = 'FieloPLT__Event__c' LIMIT 1].Id;

List<FieloPLT__KPI__c> kpis = new List<FieloPLT__KPI__c>();

// #1 Engaged Members Per Promotion Per Month
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportClass__c = 'DefaultCustomReportController',FieloPLT__ReportType__c = 'Custom',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Promotion',Name = 'Engaged Members Per Promotion Per Month'));

// #2 Number of New Members per month
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = '[   {     "Report Field": "FieloPLT__Member__c.FieloPLT__Program__c",     "Record Field": "FieloPLT__Program__r.Name"   } ]',FieloPLT__ReportObjectiveField__c = 'RowCount',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__NewMembersMonth',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Number of New Members per month'));

// #3 Points that will be expired per month
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = '[   {     "Report Field": "FieloPLT__Point__c.FieloPLT__Promotion__c",     "Record Field": "FieloPLT__Promotion__r.Id"   } ]',FieloPLT__ReportObjectiveField__c = 's!FieloPLT__Point__c.FieloPLT__Balance__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__PointsThatWillExpirePerMonth',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Promotion',Name = 'Points that will be expired per month'));

// #4 Total number of Points generated per Promotion
kpis.add(new FieloPLT__KPI__c(FieloPLT__Frequency__c = '6',FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = JSON.serialize(new List<Map<String,String>>{new Map<String,String> {'Report Field'=>'FieloPLT__Point__c.FieloPLT__Promotion__c','Record Field'=>'FieloPLT__Promotion__r.Id'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Record Field'=>'FieloPLT__EndDate__c','Operator'=>'lessOrEqual'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Record Field'=>'FieloPLT__StartDate__c','Operator'=>'greaterOrEqual'}}),FieloPLT__ReportObjectiveField__c = 's!FieloPLT__Point__c.FieloPLT__TotalPoints__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__PointsGeneratedPerPromotion',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Promotion',Name = 'Total number of Points generated per Promotion'));

// #5 Total number of Active Points
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = JSON.serialize(new List<Map<String,String>>{new Map<String,String> {'Report Field'=>'FK_FieloPLT__Member__c.FieloPLT__Program__c','Record Field'=>'FieloPLT__Program__r.Name'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Value'=>'TODAY','Operator'=>'lessOrEqual'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Value'=>'6 MONTHS AGO','Operator'=>'greaterThan'}}),FieloPLT__ReportObjectiveField__c = 's!FieloPLT__Point__c.FieloPLT__Balance__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__ActivePoints',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Total number of Active Points'));

// #6 Breakage per month
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = '[   {     "Report Field": "FK_FieloPLT__Member__c.FieloPLT__Program__c",     "Record Field": "FieloPLT__Program__r.Name"   } ]',FieloPLT__ReportObjectiveField__c = 's!FieloPLT__Point__c.FieloPLT__ExpiredPoints__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__BreakagePerMonth',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Breakage per month'));

// #7 Members that redeemed points
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = '[   {     "Report Field": "FieloPLT__Redemption__c.FieloPLT__Program__c",     "Record Field": "FieloPLT__Program__r.Id"   } ]',FieloPLT__ReportObjectiveField__c = 's!FK_FieloPLT__Member__c.FieloPLT__Member_Counter__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__MembersThatRedeemedPoints',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Members that redeemed points'));

// #8 Total number of Points redeemed  per month
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = '[   {     "Report Field": "FieloPLT__Redemption__c.FieloPLT__Program__c",     "Record Field": "FieloPLT__Program__r.Id"   } ]',FieloPLT__ReportObjectiveField__c = 's!FieloPLT__Redemption__c.FieloPLT__Points__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__PointsRedeemedPerMonth',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Total number of Points redeemed  per month'));

// #9 Total number of Points distributed to all members per month per program
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = JSON.serialize(new List<Map<String,String>>{new Map<String,String> {'Report Field'=>'FK_FieloPLT__Member__c.FieloPLT__Program__c','Record Field'=>'FieloPLT__Program__r.Name'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Value'=>'TODAY','Operator'=>'lessOrEqual'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Value'=>'6 MONTHS AGO','Operator'=>'greaterThan'}}),FieloPLT__ReportObjectiveField__c = 's!FieloPLT__Transaction__c.FieloPLT__Points__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__PointsDistributedPerProgramPerMonth',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Total number of Points distributed to all members per month per program'));

// #10 Top 10 items redeemed (value)
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = '[   {     "Report Field": "FieloPLT__Redemption__c.FieloPLT__Program__c",     "Record Field": "FieloPLT__Program__c"   } ]',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__ItemsRedeemedBySumOfPoints',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Top 10 items redeemed (value)'));

// #11 Items redeemed by Quantity
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = '[   {     "Report Field": "FieloPLT__Redemption__c.FieloPLT__Program__c",     "Record Field": "FieloPLT__Program__c"   } ]',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__ItemsRedeemedByQuantity',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Items redeemed by Quantity'));

// #12 Active Members per month per program
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = JSON.serialize(new List<Map<String,String>>{new Map<String,String> {'Report Field'=>'FK_FieloPLT__Member__c.FieloPLT__Program__c','Record Field'=>'FieloPLT__Program__r.Name'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Value'=>'TODAY','Operator'=>'lessOrEqual'},new Map<String,String> {'Report Field'=>'CUST_CREATED_DATE','Value'=>'6 MONTHS AGO','Operator'=>'greaterThan'}}),FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__ActiveMembersPerMonthPerProgram',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Program',Name = 'Active Members per month per program'));

// #13 Total number of Points generated per Challenge
kpis.add(new FieloPLT__KPI__c(FieloPLT__IsCustom__c = false,FieloPLT__ReportFilter__c = JSON.serialize(new List<Map<String,String>>{new Map<String,String> {'Report Field'=>'FieloPLT__Challenge__c.Id','Record Field'=>'FieloPLT__Challenge__r.Id'},new Map<String,String> {'Report Field'=>'FieloPLT__Point__c.CreatedDate','Record Field'=>'FieloPLT__EndDate__c','Operator'=>'lessOrEqual'},new Map<String,String> {'Report Field'=>'FieloPLT__Point__c.CreatedDate','Record Field'=>'FieloPLT__StartDate__c','Operator'=>'greaterThan'}}),FieloPLT__ReportObjectiveField__c = 's!FieloPLT__Point__c.FieloPLT__TotalPoints__c',FieloPLT__ReportType__c = 'Standard',FieloPLT__ReportUniqueName__c = 'fieloplt__PointsGeneratedPerChallenge',FieloPLT__RuleTrigger__c = ruleTriggerId,FieloPLT__Type__c = 'Challenge',Name = 'Total number of Points generated per Challenge'));

Database.insert(kpis);
