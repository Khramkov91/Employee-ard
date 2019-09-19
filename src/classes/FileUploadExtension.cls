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

    public PageReference upload() {
        try {
            if(attachment.Body != null) {
                if(attachment.Name.endsWith('.png')) {
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
        PageReference pageRef = new PageReference('/apex/EmployeeEditImage');
        pageRef.getParameters().put('id', recId);
        pageRef.setRedirect(true);
        return pageRef;
    }
}