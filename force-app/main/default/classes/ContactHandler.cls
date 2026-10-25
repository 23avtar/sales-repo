public without sharing class ContactHandler {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(Id accountId) {
        try {
            if(accountId == null){
                return new List<Contact>();
            }
            return [select Id, LastName from Contact where AccountId = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}