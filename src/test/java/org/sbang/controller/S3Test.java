package org.sbang.controller;

import java.io.FileNotFoundException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.sbang.util.S3Util;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" ,"file:src/main/webapp/WEB-INF/spring/**/spring-security.xml"})
public class S3Test {

	@Test
	public void test() throws FileNotFoundException {
		S3Util s3 = new S3Util();
        
		/* List<Bucket> list = s3.getBucketList();
         
        // 첫번째 Bucket
        String bucketName = list.get(0).getName().toString();
        System.out.println("Bucket Name : " + bucketName);
         */
       /* // Bucket 생성(대문자는 포함되면 안됨.)
        for(int i = 0; i < 3; i++) {
            s3.createBucket("wonier-test-bucket" + i);
        }
         
        // 폴더 생성
        for(int i = 0; i < 3; i++) {
            s3.createFolder("sbangbucket", "woniper-test-folder" + i);
        }*/
         
        // 파일 업로드
        //String fileName = "/Users/woniper/Downloads/aws-java-sdk-1.8.4.zip";
     
        System.out.println(s3.getFileURL("sbangbucket", "aws-java-sdk-1.8.4.zip"));
        
	}

}
