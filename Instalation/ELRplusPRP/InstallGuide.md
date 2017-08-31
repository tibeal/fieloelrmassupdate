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
|[FieloCMS-FieloELR](https://github.com/Fielo-Plugins/fielocms-fieloelr)| master |
|[FieloCMS-FieloPRP](https://github.com/Fielo-Plugins/fielocms-fieloprp)| master |

Deploy them in the following order:

1. **FieloCMS-FieloPLT**
2. **FieloCMS-FieloELR**
3. **FieloCMS-FieloPRP**
