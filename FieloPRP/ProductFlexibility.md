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

- **FieloPRP_Product** : Controls the fields displayed in the advanced search section

> ![FieloPRP_Product](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/product.gif?raw=true)

Controls:
> ![Advanced Product Search Section](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/advanced_search_section.gif?raw=true)

- **FieloPRP_ProductRecent** : Controls the fields displayed in the recent records results of the advanced search

> ![FieloPRP_ProductRecent](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/product_recent.gif?raw=true)

Controls:
> ![Advanced Search Recent](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/advanced_search_recent.gif?raw=true)

- **FieloPRP_InvoiceItems** : Controls the fields displayed in the Items section of the Invoice Form

> ![FieloPRP_InvoiceItems](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/items.gif?raw=true)

Controls:
> ![Invoice Items](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/items_section.gif?raw=true)

We recomend using some advanced text editor tool to change the JSON. In order to put the new object we can do the following:

From:
> ![FieloPRP_Product](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/product.gif?raw=true)

to:
> ![FieloPRP_Product](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/external_prod.gif?raw=true)

Where Family__c and Description__c are fields from the new product object.

From:
> ![FieloPRP_ProductRecent](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/product_recent.gif?raw=true)

to:
> ![FieloPRP_ProductRecent](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/external_prod_recent.gif?raw=true)

Where Family__c and Description__c are fields from the new product object.

From:
> ![FieloPRP_InvoiceItems](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/items.gif?raw=true)

to:
> ![FieloPRP_InvoiceItems](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/external_prod_item.gif?raw=true)

Where External_Product__c is the field from Invoice Items that is a Lookup for the new product object.

Now we should save the new JSON somewhere in our PC and we go to:

> **Fielo Platform** App > **Libraries** Tab > **FieloPRP** Library > "**Invoice > New**" and "**Invoice > Edi**t" page settings

In these two page settings paste the content of the new JSON in the field Sections like this:

> ![Edit Section Field](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/edit_section.gif?raw=true)

Save the changes in both Page Settings.

Now you should be able to see and create new invoices with the new product object! :simple_smile:

Example:

Items:
![Items](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/external_prod_items.gif?raw=true)

Product search:
![Product search](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/external_prod_serarch.gif?raw=true)

Product results:
![Product results](https://github.com/tibeal/Fielo-Tutorials/blob/master/FieloPRP/Source/external_prod_results.gif?raw=true)

Thanks!

That's all Folks! :rabbit:
