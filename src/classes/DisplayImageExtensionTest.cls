/**
 * Created by user on 19-Sep-19.
 */

@IsTest
private class DisplayImageExtensionTest {

    @IsTest
    static void testGetFileId() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment';
        testAtt.ParentId = testCnt.Id;
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        testAtt.body = bodyBlob;
        insert testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        DisplayImageExtension testExtension = new DisplayImageExtension(sc);
        String result =  testExtension.getFileId();
        System.assertEquals(result, testAtt.Id);
    }

    @IsTest
    static void testSaveEmployee() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment';
        testAtt.ParentId = testCnt.Id;
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        testAtt.body = bodyBlob;
        insert testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        DisplayImageExtension testExtension = new DisplayImageExtension(sc);

        PageReference testPageReference = new PageReference('/apex/EmployeeDetail');
        testPageReference.getParameters().put('id', sc.getId());
        testPageReference.getParameters().put('imageId', testExtension.getFileId());
        testExtension.getFileId();
        PageReference pageResult = testExtension.saveEmployee();
        System.assertEquals(pageResult.getUrl(), testPageReference.getUrl());
    }
}