/**
 * Created by andgrigore on 2/28/2022.
 */

public with sharing class WebinarMemberTriggerHandler {
    public static void handleBeforeInsert(List<Webinar_Member__c> newList) {
        checkType(newList);
        ContactOrUser(newList);
        //maximumNumberOfSeats(newList);
    }
    public static void handleBeforeUpdate(List<Webinar_Member__c> newList){
        checkType(newList);
        ContactOrUser(newList);
        maximumNumberOfSeats(newList);
    }

    public static void checkType(List<Webinar_Member__c> newList){
        for(Webinar_Member__c w : newList)
            if(w.Webinar__r.Type__c != 'External') {
                if(w.Contact__c != null)
                    w.addError('you can not do that');
            }
    }

    private static void ContactOrUser(List<Webinar_Member__c> newList){
        for(Webinar_Member__c w : newList)
            if(w.Contact__c != NULL && w.User__c !=NULL)
                w.addError('you can not have a contact and a user');
    }

    private static void maximumNumberOfSeats(List<Webinar_Member__c> newList){
        for(Webinar_Member__c w : newList)
            if(w.Webinar__r.Number_of_Participants__c == w.Webinar__r.Total_Number_of_Seats__c)
                w.addError('The webinar is full');
    }

    private static void pricePerParticipant(){}//later




}