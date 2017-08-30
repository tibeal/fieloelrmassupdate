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

> ![Public Settings Edit](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/ScreenHunter_01%20Aug.%2030%2011.45.gif?raw=true)

Hit Save.

With this the First Step is completed.

## 2. Backend
The field being used by the Invoice Item to reference the product and the fieldsets of the product advanced search are controlled by Page Settings.
The Standard Page Settings for the Proof of Purchase looks like the following:

> [Invoice Edit Page Settings] (https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/PageSettings.json)

There you will find 3 sections:

- **FieloPRP_Product** : Responsable for the fields displayed in the advanced search section

> ![FieloPRP_Product](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/product.gif?raw=true)

Responsible for:
> ![Advanced Product Search Section](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/advanced_search_section.gif?raw=true)

- **FieloPRP_ProductRecent** : Responsible for the fields displayed in the recent records results of the advanced search

> ![FieloPRP_ProductRecent](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/product_recent.gif?raw=true)

Responsible for:
> ![Advanced Search Recent](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/advanced_search_recent.gif?raw=true)

- **FieloPRP_InvoiceItems** : Responsible for the fields displayed in the Items section of the Invoice Form

> ![FieloPRP_InvoiceItems](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/items.gif?raw=true)

Responsible for:
> ![Invoice Items](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/items_section.gif?raw=true)

In order to put the new object we can do the following:

From:
> ![FieloPRP_Product](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/product.gif?raw=true)

to:
> ![FieloPRP_Product](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/external_prod.gif?raw=true)
