# Fielo Proof of Purchase: Product Flexibility
## Intro
The Fielo's Proof of Purchase (FieloPRP) has a functionality called _Product Flexibility_ that enables developers, consultants or administrators to change the Product object used by the Proof of Purchase App.
By default the object used by the Proof of Purchase solution is the **Product2** object that comes with Salesforce. If the customer wants to use another object just follow the following Tutorial. This procedure must be done in both _Backend_ and _Frontend_.

This Tutorial will use as example one object called ExternalProduct__c to be used as the new Proof of Purchase product object.

## 1. First Step
Both _Backend_ and _Frontend_ are using the same Custom Settings to discover which product object is being used. To change that just go to:

> **Setup** > **Develop** > **Custom Settings** > **Custom Settings:** Public Settings (FieloPLT Namespace)

Then click on the "**Manage**" button.

In the section "**Default Organization Level Value**" click Edit or New if there is nothing defined.

Edit the field "**Product Lookup Field**" and put as its value the ApiName of the Field in the Invoice Items Object (FieloPRP__InvoiceItem__c) that points to the custom product object.

![Public Settings Edit](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/ScreenHunter_01%20Aug.%2030%2011.45.gif?raw=true)

Hit Save.

With this the First Step is completed.

## 2. Backend
The field being used by the Invoice Item to reference the product and the fieldsets of the product advanced search are controlled by Page Settings.
The Standard Page Settings for the Proof of Purchase looks like the following:

 - [Invoice > Edit Page Settings](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/PageSettings.json)


