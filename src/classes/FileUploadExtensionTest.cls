/**
 * Created by user on 19-Sep-19.
 */

@IsTest
private class FileUploadExtensionTest {

    @IsTest
    static void testUploadPositive() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment.png';
        testAtt.ParentId = testCnt.Id;
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        testAtt.body = bodyBlob;
        insert testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        FileUploadExtension testExtension = new FileUploadExtension(sc);
        testExtension.attachment.Body = testAtt.Body;
        testExtension.attachment.Name = 'Test Attachment.png';

        PageReference testPageRef = new PageReference('/apex/EmployeeEditImage');
        testPageRef.getParameters().put('id', sc.getId());
        testPageRef.setRedirect(true);
        PageReference resultPageRef = testExtension.upload();
        System.assertEquals(resultPageRef.getUrl(), testPageRef.getUrl());
    }

    @IsTest
    static void testUploadNegativeFileExtension() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment.png';
        testAtt.ParentId = testCnt.Id;
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        testAtt.body = bodyBlob;
        insert testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        FileUploadExtension testExtension = new FileUploadExtension(sc);
        testExtension.attachment.Body = testAtt.Body;
        testExtension.attachment.Name = 'Test Attachment';

        PageReference testPageRef = new PageReference('/apex/EmployeeEditImage');
        testPageRef.getParameters().put('id', sc.getId());
        testPageRef.setRedirect(true);
        PageReference resultPageRef = testExtension.upload();
        System.assertEquals(resultPageRef.getUrl(), testPageRef.getUrl());
    }

    @IsTest
    static void testUploadNegativeNoFile() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment.png';
        testAtt.ParentId = testCnt.Id;
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        testAtt.body = bodyBlob;
        insert testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        FileUploadExtension testExtension = new FileUploadExtension(sc);

        PageReference testPageRef = new PageReference('/apex/EmployeeEditImage');
        testPageRef.getParameters().put('id', sc.getId());
        testPageRef.setRedirect(true);
        PageReference resultPageRef = testExtension.upload();
        System.assertEquals(resultPageRef.getUrl(), testPageRef.getUrl());
    }

    @IsTest
    static void testUploadNegativeDmlException() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        FileUploadExtension testExtension = new FileUploadExtension(sc);

        PageReference resultPageRef = testExtension.upload();
        System.assertEquals(resultPageRef.getUrl(), null);
    }

    @IsTest
    static void testGetAttachments() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        List<Attachment> testResult = new List<Attachment>();

        Attachment testAtt1 = new Attachment();
        testAtt1.Name = 'Test Attachment';
        testAtt1.ParentId = testCnt.Id;
        Blob bodyBlob1 = Blob.valueOf('Unit Test Attachment Body');
        testAtt1.body = bodyBlob1;
        insert testAtt1;
        testResult.add(testAtt1);

        Attachment testAtt2 = new Attachment();
        testAtt2.Name = 'Test Attachment1';
        testAtt2.ParentId = testCnt.Id;
        Blob bodyBlob2 = Blob.valueOf('Unit Test Attachment Body1');
        testAtt2.body = bodyBlob2;
        insert testAtt2;
        testResult.add(testAtt2);

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        FileUploadExtension testExtension = new FileUploadExtension(sc);
        List<Attachment> result = testExtension.getAttachments();
        System.assertEquals(result, testResult);
    }

    @IsTest
    static void testGetAttachmentsNegative() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        FileUploadExtension testExtension = new FileUploadExtension(sc);
        List<Attachment> result = testExtension.getAttachments();

        System.assert(result.isEmpty());
    }
}