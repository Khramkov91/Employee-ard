/**
 * Created by user on 19-Sep-19.
 */

@IsTest
private class SaveAsPdfExtensionTest {

    @IsTest
    static void testGetFile() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        Attachment testAtt = new Attachment();
        testAtt.Name = 'Test Attachment';
        testAtt.ParentId = testCnt.Id;
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        testAtt.body = bodyBlob;
        insert testAtt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);
        String result = testExtension.getFileId();
        System.assertEquals(result, testAtt.Id);
    }

    @IsTest
    static void testRenderedContentTypeNegative() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);

        String testRenderedContentType = 'text/html';
        String result = testExtension.renderedContentType;
        System.assertEquals(result, testRenderedContentType);
    }

    @IsTest
    static void testRenderedContentType() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);

        String testRenderedContentType = 'application/pdf';
        testExtension.saveToPdf();
        String result = testExtension.renderedContentType;
        System.assertEquals(result, testRenderedContentType);
    }

    @IsTest
    static void testRenderedContentTypeWithFileName() {
        Contact testCnt = new Contact(LastName = 'TestContact');
        insert testCnt;

        ApexPages.StandardController sc = new ApexPages.StandardController(testCnt);
        SaveAsPdfExtension testExtension = new SaveAsPdfExtension(sc);

        String testRenderedContentType = 'application/pdf';
        testExtension.renderedFileName = 'TestFile';
        testExtension.saveToPdf();
        String result = testExtension.renderedContentType;
        System.assertEquals(result, testRenderedContentType);
    }
}