/**
 * Created by andgrigore on 2/28/2022.
 */

public with sharing class WebinarTriggerHandler {
    public static void handleBeforeInsert(List<Webinar__c> newList) {
        ApproveBelow100(newList);
        IfRejectedCancel(newList);
    }

    public static void handleBeforeUpdate(List<Webinar__c> newList, Map<id, Webinar__c> oldMap){
        ApproveBelow100(newList);
        IfRejectedCancel(newList);
        statusValue(newList, oldMap);
    }


    private static void ApproveBelow100(List<Webinar__c> newList) {
        for(Webinar__c w: newList){
            if(w.Cost__c < 100) {
                w.Approval_Status__c = 'Approved';
            }
        }
    }

    private static void IfRejectedCancel(List<Webinar__c> newList){
        for(Webinar__c w : newList)
        if(w.Approval_Status__c == 'Rejected') {
            w.Status__c = 'Canceled';
        }
    }

    private static void statusValue(List<Webinar__c> newList, Map<Id, Webinar__c> oldMap){
        for(Webinar__c w : newList){
            if(oldMap.get(w.Id).Status__c == 'New' && w.Status__c != 'New' && w.Status__c != 'Canceled' && w.Approval_Status__c == 'Pending') {
                w.addError('Approval can not be Pending');
            }
        }
    }


}