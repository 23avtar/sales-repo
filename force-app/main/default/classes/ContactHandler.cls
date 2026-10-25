public without sharing class ContactHandler {
    @TestVisible private static Boolean forceException = false; 

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(Id accountId) {
        try {
            if (forceException) {
                throw new IllegalArgumentException('Forced testing exception');
            }
            if(accountId == null){
                return new List<Contact>();
            }
            return [select Id, LastName from Contact where AccountId = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}