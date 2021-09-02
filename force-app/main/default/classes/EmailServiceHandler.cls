global class EmailServiceHandler implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        Email_Service_Message__c messageRecord = new Email_Service_Message__c();

            messageRecord.Subject__c    = email.subject;
            messageRecord.Sender__c     = email.fromAddress;
            messageRecord.Recipients__c = string.join(email.toAddresses,',');
            messageRecord.Body__c       = email.htmlBody;

        insert messageRecord;

        if (email.binaryAttachments != null) {
            
            for (Messaging.InboundEmail.BinaryAttachment bAttachment : email.binaryAttachments) {
                
                Attachment attachment = new Attachment();
                attachment.Name = bAttachment.fileName;
                attachment.Body = bAttachment.body;
                attachment.ParentId = messageRecord.Id;
                insert attachment;

            }

        }
    
        return result;
    }
}
