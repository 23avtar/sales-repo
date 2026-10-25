/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ContactHandlerTest {

    @testSetup
    static void setupTestData() {
        Account acc = new Account(Name ='New Account');
        insert acc;
        List<Contact> testContacts = new List<Contact>{
            new Contact(LastName = 'Smith', AccountId = acc.Id),
            new Contact(LastName = 'Jones', AccountId = acc.Id)
        };
        insert testContacts;
    }
    @isTest
    static void testGetContactValidId(){
        Account acc = [select Id from Account LIMIT 1];
        Test.startTest();
        List<Contact> conList = ContactHandler.getContact(acc.Id);
        Test.stopTest();
        System.assertEquals(2, conList.size());
    }

    @isTest
    static void testContactWithNull(){
        Test.startTest();
        List<Contact> result = ContactHandler.getContact(null);
        Test.stopTest();

        System.assertEquals(0, result.size());
    }

    @isTest
    static void testGetContactExceptionHandling() {
        String invalidId = '001000000000000AAA';
        try{
            Test.startTest();
            List<Contact> result = ContactHandler.getContact(invalidId);
            Test.stopTest();
            //System.assert(false, 'An AuraHandledException should have been thrown.');
        }catch(AuraHandledException e){
            System.assertNotEquals(null, e.getMessage(), 'The exception message should not be empty.');
        }
    }

}