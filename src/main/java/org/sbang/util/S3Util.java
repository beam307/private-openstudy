package org.sbang.util;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Component;

import com.amazonaws.ClientConfiguration;
import com.amazonaws.Protocol;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;

@Component
public class S3Util {

   private String accessKey = "AKIAIAZ2FRY5DSYYP2RQ"; //s3엑세스키
   private String secretKey = "o0EwOivQmEyAuQ+yZ6YYT8LGttFA9M1dykcIm0c/";//s3시크릿키
   
   private AmazonS3 conn;

   public S3Util() {
      AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);//위의 엑세스키와 시크릿키로 접근권한 설정
      ClientConfiguration clientConfig = new ClientConfiguration();
      clientConfig.setProtocol(Protocol.HTTP); //통신방식은 HTTP
      this.conn = new AmazonS3Client(credentials, clientConfig);
      conn.setEndpoint("s3-ap-northeast-2.amazonaws.com"); //s3의 앤드포인트 설정(지역에따라 다름) sbang의 경우 서울로되어있다.
   }

   // Bucket List
   public List<Bucket> getBucketList() {
      return conn.listBuckets();
   }

   // Bucket 생성
   public Bucket createBucket(String bucketName) {
      return conn.createBucket(bucketName);
   }

   // 폴더 생성 (폴더는 파일명 뒤에 "/"를 붙여야한다.)
   public void createFolder(String bucketName, String folderName) {
      conn.putObject(bucketName, folderName + "/", new ByteArrayInputStream(new byte[0]), new ObjectMetadata());
   }

   // 파일 업로드
   public void fileUpload(String bucketName, String savedPath, byte[] byteArr) throws IOException {
      //file은 (경로포함+ uid+파일이름)을 불러온다=>DB에들어가는 이름과같음
      //경로만 주면 폴더 자동생성
      //절대경로를 불러와 uploadpath부분을 자른다.
      String filePath=(savedPath).replace(File.separatorChar, '/');   //파일 구별자를 `/`로 설정(\->/)
      ObjectMetadata metaData=new ObjectMetadata();                                 
      //byte[] bytes=IOUtils.toByteArray(new FileInputStream(file));//파일을 바이트화 시킨다.
      metaData.setContentLength(byteArr.length);   //메타데이터 설정 -->원래는 128kB까지 업로드 가능했으나 파일크기만큼 버퍼를 설정시켰다.
      ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(byteArr); //파일 넣음
      conn.putObject(bucketName, filePath,byteArrayInputStream , metaData); //버켓이름, 파일경로, 파일 바이트화, 메타데이터를 넣음
   }

   // 파일 삭제
   public void fileDelete(String bucketName, String fileName) {
      conn.deleteObject(bucketName, fileName);
   }

   // 파일 URL
   public String getFileURL(String bucketName, String fileName) {
      return conn.generatePresignedUrl(new GeneratePresignedUrlRequest(bucketName, fileName)).toString();
   }

}