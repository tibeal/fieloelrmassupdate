# FieloPRP and FieloELR Instalation Guide

## 1. Installing Packages

We recomend using the following package versions:

| Package | Version | URL |
| --- | --- | --- |
| **FieloPLT** | **2.27.3** | /packaging/installPackage.apexp?p0=04t50000000M8P0 |
| **FieloCMS** | **1.73** | /packaging/installPackage.apexp?p0=04t360000016NMj |
| **FieloELR** | **1.17** | /packaging/installPackage.apexp?p0=04t6A00000104Eh |
| **FieloPRP** | **1.4** | /packaging/installPackage.apexp?p0=04t46000001pj8R |

Install them in the following sequence:

1. **FieloPLT**
2. **FieloCMS**
3. **FieloELR**
4. **FieloPRP**

When you finish the installation of them all you will be ready to go to the next section

## 2. Plugins Installation

Use the following combination of repositories/branches to configure your environment:

| Repository | Branch |
| --- | --- |
|[FieloCMS-FieloPLT](https://github.com/Fielo-Plugins/fielocms-fieloplt)| feature/naming |
|[FieloCMS-FieloELR](https://github.com/Fielo-Plugins/fielocms-fieloelr)| master :warning:|
|[FieloCMS-FieloPRP](https://github.com/Fielo-Plugins/fielocms-fieloprp)| master |

Deploy them in the following order:

1. **FieloCMS-FieloPLT**
2. **FieloCMS-FieloELR**
3. **FieloCMS-FieloPRP**

After deploying all of them into your org follow the Official Documentation Guide that will guide you through all the org configuration such as:
 - Site Configuration
 - Customer Portal Configuration
 - Profile Configuration
 - and so on...
 
Here is the link to the Official Documentation:

> [Fielo PLT & CMS packages](https://documentation.fielo.com/docs/fielo-platform-cms-packages)

**_NOTE_**: Remember that the official documentation is for the PLT and CMS only. There are some sections that asks you to add permissions or set object attributes in order to enable them to the CMS. Do not forget to do the same for the ELR and PRP objects!!!

Here's a little help. These are the objects for each package that aren't in the Official Documentation:

_**FieloELR**_
- **Answer**
- **Answer Options**
- **Course**
- **Course Dependency**
- **Course Status**
- **Module**
- **Module Dependency**
- **Module Response**
- **Question**
- **Question Response**

_**FieloPRP**_
- **Invoice**
- **Invoice Item**
- **Product2** \*\*\*

\*\*\*: Depending of your implementation, another product object must replace the Product2 object

**_TIP_**: The administrator user of the Org may not have access to some objects of the plugins becouse the plugin's repositories doesn't deploys the user profile. For example, there is a section that asks you to create 2 segments with a specific RecordType. Two things may happen: the RecordType doesn't exist or you doesn't have access to it. Try creating the record types or editing your profile.

![Add Image](https://github.com/tibeal/Fielo-Tutorials/blob/master/Instalation/Source/Add%20RecordType.png?raw=true)

:construction: :warning: **_Work In Progress! This Document isn't ready yet!!!_** :warning: :construction:
