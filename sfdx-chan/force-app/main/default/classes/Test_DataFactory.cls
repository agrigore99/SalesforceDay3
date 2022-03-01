/**
 * Created by andgrigore on 3/1/2022.
 */

public with sharing class Test_DataFactory {
    public static Account createTestAccount() {
        Account account = new Account(Name = 'John');
        insert account;
        return account;
    }
    public static Account createTestOpportunity(Account account) {
        Opportunity opp = new Opportunity(
                Name = account.Name + ' Opportunity',
                StageName = 'Prospecting',
                Amount = 10,
                CloseDate = System.today().addMonths(2),
                AccountId = account.Id
        );
        insert opp;
        return account;
    }
    public static Contact createTestInvalidContact(String last_name) {
        Contact contact = new Contact(
                FirstName = 'John',
                LastName = last_name
        );
        //insert contact;
        return contact;
    }
}