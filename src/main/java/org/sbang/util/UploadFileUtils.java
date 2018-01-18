package org.sbang.util;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

public class UploadFileUtils {

   static S3Util s3=new S3Util();
   
   static final String bucketName="sbangbucket";
   
   public static String uploadFile(String originalName, byte[] fileData,String profileFlag) throws Exception {
      // 파일 업로드
      UUID uid = UUID.randomUUID(); // 파일명 중복 방지를 위한 uid 생성
      String exceptFormat=originalName.substring(0, originalName.lastIndexOf(".")); //확장자를 제외한 파일명
      String format=originalName.substring(originalName.lastIndexOf(".") + 1); //확장자명
      String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]"; // 특수문자 정규식
      exceptFormat = exceptFormat.replaceAll(match,""); // 특수문자를 제거
      exceptFormat = exceptFormat.replaceAll(" ",""); //공백제거
      originalName = exceptFormat + "." + format;
      String savedName = uid.toString() + "_" + originalName;
      String savedPath =null;
      if(profileFlag!=null) {
    	  savedPath="PR/"+calcPath();
    	  s3.fileUpload(bucketName, savedPath+savedName,fileData); //s3에 파일 업로드 (s3는 경로만 주면 폴더를 자동으로 생성해준다.)
      }
      else { 
    	  savedPath=calcPath();
    	  s3.fileUpload(bucketName, savedPath+savedName,fileData); //s3에 파일 업로드 (s3는 경로만 주면 폴더를 자동으로 생성해준다.)
      }
      
      
      //String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
      
      String uploadedFileName = (savedPath+savedName).replace(File.separatorChar, '/');

     /* if (MediaUtils.getMediaType(formatName) != null) {
         uploadedFileName = makeThumbnail(uploadPath, savedName);
      } else {
         uploadedFileName = makeIcon(uploadPath, savedName);
      }
*/
      return uploadedFileName; // 썸네일 파일 생성후 썸네일명 리턴
   }

  /* private static String makeIcon(String uploadPath, String fileName) throws Exception {
      String iconName = uploadPath+ File.separator + fileName;
      return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
   }*/

   private static String calcPath() { // 오늘 날짜로 폴더 이름 만들기
      Calendar cal = Calendar.getInstance();

      String yearPath = ""+cal.get(Calendar.YEAR);

      String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);

      String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE))+File.separator;      
      
      return datePath;//파일이름은 datePath만 넣는다.

   }

  /* private static String makeThumbnail(String uploadPath, String fileName) throws Exception {
      // 썸네일 생성
      BufferedImage sourceImg = ImageIO.read(new File(uploadPath, fileName)); // 원본 파일 읽기

      BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100); // 썸네일 환경설정후 변수 저장

      String thumbnailName = uploadPath + File.separator + "s_" + fileName; // 썸네일 name

      File newFile = new File(thumbnailName); 
      String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);// file 확장자

      ImageIO.write(destImg, formatName.toUpperCase(), newFile); // 썸네일 file 생성
      s3.fileUpload(bucketName,newFile );
      newFile.delete();
      return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/'); // 생성된 썸네일 name return
   }*/

}