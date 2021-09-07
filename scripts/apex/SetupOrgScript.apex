SetupOrgScript script = new SetupOrgScript();
//script.clearSampleData();
//script.scheduleBusMaintenanceBatch();

//script.testExecuteBusMaintenanceBatch();
//script.abortCronJobId();

class SetupOrgScript {

    private final String CRON_FORMAT = '0 0 23 1/1 * ? *';
    private final String JOB_NAME = 'Schedule Bus Maintenance';

    public void clearSampleData() {
        System.debug(LoggingLevel.INFO, 'Clearing all sample data...');
        List<Id> deletedIds = new List<Id>();
        deletedIds.addAll(clearGarageRecords());
        deletedIds.addAll(clearBusRecords());
        deletedIds.addAll(clearMaintenanceRecords());
        deletedIds.addAll(clearLogRecords());
        Database.emptyRecycleBin(deletedIds);
        System.debug(LoggingLevel.INFO, 'Sample data cleared.');
    }

    private List<Id> clearGarageRecords() {
        List<Garage__c> garages = [SELECT Id FROM Garage__c];
        delete garages;
        return new List<Id>(new Map<Id, Garage__c> (garages).keySet());
    }

    private List<Id> clearBusRecords() {
        List<Bus__c> buses = [SELECT Id FROM Bus__c];
        delete buses;
        return new List<Id>(new Map<Id, Bus__c> (buses).keySet());
    }

    private List<Id> clearMaintenanceRecords() {
        List<Maintenance__c> maintenances = [SELECT Id FROM Maintenance__c];
        delete maintenances;
        return new List<Id>(new Map<Id, Maintenance__c> (maintenances).keySet());
    }

    private List<Id> clearLogRecords() {
        List<Log__c> logs = [SELECT Id FROM Log__c];
        delete logs;
        return new List<Id>(new Map<Id, Log__c> (logs).keySet());
    }

    public void testExecuteBusMaintenanceBatch() {
        System.debug(LoggingLevel.INFO, 'Test execute BusMaintenanceBatch for once...');
        BusMaintenanceBatch batchJob = new BusMaintenanceBatch();
        Id batchJobId = Database.executeBatch(batchJob, 10);
        System.debug(LoggingLevel.INFO, 'Batch job with Id ' + batchJobId + ' executing...');
    }

    // Schedules BusMaintenanceBatch to run daily at 23:00 at user local timezone
    public void scheduleBusMaintenanceBatch() {
        System.debug(LoggingLevel.INFO, 'Scheduling BusMaintenanceBatch at 23:00 daily...');
        BusMaintenanceBatch scheduledJob = new BusMaintenanceBatch();
        Id cronJobId = System.schedule(JOB_NAME, CRON_FORMAT, scheduledJob);
        System.debug(LoggingLevel.INFO, 'Job Scheduled with Cron Trigger Id : ' + cronJobId);
    }

    public void abortCronJobId() {
        System.debug(LoggingLevel.INFO, 'Aborting daily Bus Maintenance Job...');
        CronTrigger cronTrigger = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = :JOB_NAME];
        System.abortJob(cronTrigger.Id);
        System.debug(LoggingLevel.INFO, 'Job with cron Id ' + cronTrigger.Id + ' aborted.');
    }
}