/**
 * Created by user on 16-Sep-19.
 */

public with sharing class DisplayImageExtension {
    public String recId;

    public DisplayImageExtension(ApexPages.StandardController controller) {
        recId = controller.getId();
    }

    public String getFileId() {
        String fileId = '';
        List<Attachment> attachedFiles =   [SELECT Id
                                            FROM Attachment
                                            WHERE parentId =: recId
                                            ORDER BY LastModifiedDate
                                            DESC LIMIT 1];
        if(attachedFiles != null && attachedFiles.size() > 0 ) {
            fileId = attachedFiles[0].Id;
        }
        return fileId;
    }
}