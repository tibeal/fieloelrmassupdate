String versionNo = 'v1.42.0';

List<FieloPLT__Program__c> programs = new List<FieloPLT__Program__c>();
List<FieloELR__Course__c> courses = new List<FieloELR__Course__c>();
List<FieloELR__Module__c> modules = new List<FieloELR__Module__c>();
List<FieloELR__Question__c> questions = new List<FieloELR__Question__c>();
List<FieloELR__AnswerOption__c> answersOpList = new List<FieloELR__AnswerOption__c>();

programs = [SELECT Id, Name FROM FieloPLT__Program__c WHERE Name = 'Training Center'];

courses.add(new FieloELR__Course__c( Name = 'Smoke ' + versionNo, FieloELR__Program__c = programs.get(0).Id, FieloELR__Description__c = 'Description', FieloELR__SubscriptionMode__c = 'Manual'));

insert courses;

modules.add(new FieloELR__Module__c(Name = 'Basic', FieloELR__Course__c = courses.get(0).id, FieloELR__ApprovalGrade__c = 75, FieloELR__AttemptsAllowed__c = 2, FieloELR__AttemptsAllowedPerQuestion__c = 2, FieloELR__PenaltyMode__c = 'None'));

insert modules;

questions.add(new FieloELR__Question__c(Name = 'Q1', FieloELR__Module__c = modules.get(0).Id, FieloELR__QuestionText__c = 'Which one is the most popular programming language?', FieloELR__Type__c = 'Short Answer'));
questions.add(new FieloELR__Question__c(Name = 'Q2', FieloELR__Module__c = modules.get(0).Id, FieloELR__QuestionText__c = 'Acronymn for Personal Computer', FieloELR__Type__c = 'Short Answer'));
questions.add(new FieloELR__Question__c(Name = 'Q3', FieloELR__Module__c = modules.get(0).Id, FieloELR__QuestionText__c = 'Name one Family-C programming language?', FieloELR__Type__c = 'Short Answer'));
questions.add(new FieloELR__Question__c(Name = 'Q4', FieloELR__Module__c = modules.get(0).Id, FieloELR__QuestionText__c = 'C++ is more performatic than java', FieloELR__Type__c = 'Short Answer'));

insert questions;

// Answers Q1 - Basic
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(0).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'JavaScript'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(0).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'javascript'));

// Answers Q2 - Basic
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(1).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'PC'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(1).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'pc'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(1).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'p.c.'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(1).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'P.C.'));

// Answers Q3 - Basic
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'C++'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'c++'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'Java'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'java'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'PHP'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'php'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'Python'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'python'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'Objective-C'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(2).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'objective-c'));

// Answers Q4 - Basic
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(3).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'True'));
answersOpList.add(new FieloELR__AnswerOption__c(FieloELR__Question__c = questions.get(3).Id, FieloELR__IsCorrect__c = true, FieloELR__AnswerOptionText__c = 'true'));

insert answersOpList;

//Set Module Active
modules.get(0).FieloELR__IsActive__c = true;
update modules;

//Set Course Active
courses.get(0).FieloELR__Status__c = 'Active';
update courses;
