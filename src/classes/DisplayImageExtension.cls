/**
 * Created by user on 16-Sep-19.
 */

public with sharing class DisplayImageExtension {
    public String recId;
    public String fileId;
    public sObject cnt;

    public DisplayImageExtension(ApexPages.StandardController controller) {
        recId = controller.getId();
        cnt = controller.getRecord();
    }

    public String getFileId() {
        fileId = ApexPages.currentPage().getParameters().get('imageId');

        if(fileId == null) {
            List<Attachment> attachedFiles =   [SELECT Id
                                                FROM Attachment
                                                WHERE parentId =: recId
                                                ORDER BY LastModifiedDate
                                                DESC LIMIT 1];
            if(attachedFiles != null && attachedFiles.size() > 0 ) {
                fileId = attachedFiles[0].Id;
            }
        }

        return fileId;
    }

    public PageReference saveEmployee() {
        upsert(cnt);
        Attachment attac = [SELECT Id, Name
                            FROM Attachment
                            WHERE Id =: fileId];
        update attac;
        PageReference pageRef = new PageReference('/apex/EmployeeDetail');
        pageRef.getParameters().put('id', recId);
        pageRef.getParameters().put('imageId', fileId);
        return pageRef;
    }
}