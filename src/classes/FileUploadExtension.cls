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
            if (Attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }

    public PageReference upload() {
        attachment.ParentId = recId;
        try {
            if(attachment.Name.endsWith('.png')) {
                insert attachment;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'File uploaded'));
            }
            else {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Invalid image type'));
            }

        }
        catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading file'));
            return null;
        }
        finally {
            attachment.body = null;
        }
        return null;
    }
}