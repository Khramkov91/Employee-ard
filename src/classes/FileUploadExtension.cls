/**
 * Created by user on 17-Sep-19.
 */

public with sharing class FileUploadExtension {

    public String recId;

    public FileUploadExtension(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    public Attachment attachment {
        get {
            if (Attachment == null) {
                attachment = new Attachment();
                attachment.ParentId = recId;
            }
            return attachment;
        }
        set;
    }

    public List<Attachment> getAttachments() {
        List<Attachment> attList = [    SELECT Id
                                        FROM Attachment
                                        WHERE parentId =: recId];
        if (attList.isEmpty()) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error Uploading Attachments'));
        }

        return attList;
    }

    public PageReference upload() {
        try {
            if(attachment.Body != null) {
                if(attachment.Name.endsWith('.png') || attachment.Name.endsWith('.jpg') || attachment.Name.endsWith('.jpeg')) {
                    attachment.ParentId = recId;
                    insert attachment;
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'File uploaded'));
                }
                else {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Invalid image type'));
                }
            }
            else {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'No image found'));
            }
        }
        catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading file'));
            return null;
        }
        finally {
            attachment.Body = null;
        }
        attachment = new Attachment();

        return null;
    }
}