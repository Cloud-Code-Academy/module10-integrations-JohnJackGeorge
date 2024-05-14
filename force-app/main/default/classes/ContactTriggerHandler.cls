public class ContactTriggerHandler extends TriggerHandler {

    private List<Contact> newContList;
    private List<Contact> oldContList;
    private Map<Id,Contact> newContMap;
    private Map<Id,Contact> oldContMap;

    public ContactTriggerHandler() {
        // System.Debug('ContactTrigger:::' + Trigger.operationType);
        this.newContList = (List<Contact>)Trigger.new;
        this.oldContList = (List<Contact>)Trigger.old;
        this.newContMap = (Map<Id,Contact>)Trigger.newMap;
        this.oldContMap = (Map<Id,Contact>)Trigger.oldMap;
        //this.setMaxLoopCount(1);
    }

    public override void beforeInsert() {
        // System.Debug('Contact Trigger Before Insert');

        // When a contact is inserted
        // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
    
        ContactTriggerHelper.beforeInsert(this.newContList);
    }

    public override void beforeUpdate() {
        ContactTriggerHelper.postCreateDummyJSONUser(this.newContList);
    }   
}