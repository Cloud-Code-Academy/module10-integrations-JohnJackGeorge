public class ContactTriggerHelper {

    // When a contact is inserted
        // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value

        // When a contact is inserted
        // if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API

        // When a contact is updated
        // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
        
    public static void beforeInsert(List<Contact> conList) {
        // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
        for (Contact con : conList) {
            if (con.DummyJSON_Id__c == null) {
                con.DummyJSON_Id__c = String.valueOf(Math.round(Math.random() * 100));
            }
            if (Integer.valueOf(con.DummyJSON_Id__c) <= 100) {
                callGetDummyJSONUserFromId(con.DummyJSON_Id__c);
            }
        }
    }

    @future (callout = true)
    private static void callGetDummyJSONUserFromId(String contactId) {
        DummyJSONCallout.getDummyJSONUserFromId(contactId);
    }

    public static void postCreateDummyJSONUser(List<Contact> conList) {
        // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
        for (Contact con : conList) {
            if (Integer.valueOf(con.DummyJSON_Id__c) > 100) {
                callPostCreateDummyJSONUser(String.valueOf(con.Id));
            }
        }
    }

    @future (callout = true)
    private static void callPostCreateDummyJSONUser(String contactId) {
        DummyJSONCallout.postCreateDummyJSONUser(contactId);
    }
}