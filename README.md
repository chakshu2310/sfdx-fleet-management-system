# Fleet Management System
=============================================================================

## Configure Your Salesforce DX Project
The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

=============================================================================

## The Project Overview
### 1. Set Up the Salesforce DX Project :
Start by cloning the repository. Use the command ...
```
git clone https://github.com/chakshu2310/sfdx-fleet-management-system.git
```
… to clone the repository. Then, open the directory.
```
cd sfdx-fleet-management-system
```
### 2. Authorize Dev Hub in your Trailhead Playground :
Log into your Dev Hub org.
```
sfdx force:auth:web:login -d -a DevHub
```
Proceed to log in with your dev hub credentials.<br/>
If you already have an authorized Dev Hub, set it as the default:
```
sfdx force:config:set defaultdevhubusername=<username|alias>
```
### 3. Create a scratch org :
```
sfdx force:org:create -s -f config/project-scratch-def.json -a <org-alias>
```
### 4. Push the source to your scratch org :
```
sfdx force:source:push -u <org-alias>
```
### 5. Assign the permission set :
```
sfdx force:user:permset:assign -n FMS_Access -u <org-alias>
```
### 6. Push the source to your scratch org :
```
sfdx force:source:push -u <org-alias>
```
### 7. Open the scratch org :
```
sfdx force:org:open -u <org-alias>
```
### 8. Execute the following script to cleanup org data & schedule Bus Maintenance job :
```
sfdx force:apex:execute -f scripts/apex/SetupOrgScript.apex -u <org-alias>
```
### 9. Import sample data for Bus & Garage records :
```
sfdx force:data:tree:import -p data/data-plan.json -u <org-alias>
```
=============================================================================

## Assessment Questions
### Q1) Setup custom objects - Bus, Garage, Maintenance & Log (additional) :
> Schema or ER diagram path - "./schema-diagram/fleet-management-system.png".

### Q2) Trigger logic to calculate Resale Value :
> Before save trigger lightning flow created - "Bus_Resale_Value_Calculation_Flow".

> Starting selling price for each bus is assumed based on maximum capacity - mapping stored as custom metadata in "Bus_Starting_Selling_Price_Mapping__mdt".

> Resale value is presumed to reset if current status is other than "Ready For Use".

### Q3) Lightning page to display list of buses in the fleet :
> Go to "App Launcher" --> select "Fleet Management System" console app --> select "Bus Fleet" under navigation items to view the fleet of buses.

### Q4) Scheduling maintenance for 60-seater buses after every 5000 miles :
> A batch job "BusMaintenanceBatch" created to schedule maintenance of buses based on last location pinged on the daily basis. A nearest garage is located using location based SOQL query and a maintenance record is created.

> Job shceduled to run daily at 23:00 user local timezone.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
