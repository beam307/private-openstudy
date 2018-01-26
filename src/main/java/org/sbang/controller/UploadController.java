package org.sbang.controller;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.sbang.domain.UserVO;
import org.sbang.service.UserService;
import org.sbang.util.MediaUtils;
import org.sbang.util.S3Util;
import org.sbang.util.UploadFileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.util.IOUtils;

@Controller
public class UploadController {

	@Inject
	private UserService service;
	

	static private S3Util s3 = new S3Util(); // 아마존s3 기능불러옴

	static final private String bucketName = "sbangbucket";// s3버킷이름

	@ResponseBody
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file, String profileFlag, HttpSession session) throws Exception {
		String filePath = UploadFileUtils.uploadFile(file.getOriginalFilename(), file.getBytes(), profileFlag);
		ResponseEntity<String> status = new ResponseEntity<>(filePath, HttpStatus.CREATED);
		if (profileFlag != null) {
			UserVO tempVO = (UserVO) session.getAttribute("login");
			int userNo = tempVO.getUserNo();
			service.modifyImg(userNo, filePath);
		}
		return status;
	}

	@ResponseBody
	@RequestMapping("/displayFile") // 이미지 출력 매핑
	public ResponseEntity<byte[]> displayFile(String fileName, HttpSession session) throws Exception {
		InputStream in = null;
		HttpURLConnection uCon = null;
		ResponseEntity<byte[]> entity = null;

		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);// 확장자만 자른다.
			MediaType mType = MediaUtils.getMediaType(formatName); // 이미지 타입검사
			HttpHeaders headers = new HttpHeaders();
			URL url;
			try {
				url = new URL(s3.getFileURL(bucketName, fileName));
				uCon = (HttpURLConnection) url.openConnection();
				in = uCon.getInputStream();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (mType != null) {
				headers.setContentType(mType);
			} else { // 요거 이미지파일아닐때 다운로드할 수 있게 만드는 로직인데 아직 안필요할거같은데 나중에 필요할거같아서 일단 놔둘게요 ㅎㅎ
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST) // 이미지파일 제거 실제파일을 제거한다.
	public ResponseEntity<String> deleteFile(String fileName) {

		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		MediaType mType = MediaUtils.getMediaType(formatName);
		if (mType != null) {
			s3.fileDelete(bucketName, fileName);
		}
		s3.fileDelete(bucketName, fileName);
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	@ResponseBody
	@RequestMapping(value = "/deleteAllFiles", method = RequestMethod.POST) // 스터디삭제시 이미지파일제거
	public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files) {

		if (files == null || files.length == 0) {
			return new ResponseEntity<String>("deleted", HttpStatus.OK);
		}
		for (String fileName : files) {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);// 확장자만 자른다.
			MediaType mType = MediaUtils.getMediaType(formatName);// 확장자 검사.
			if (mType != null) { // 이미지일경우 원본파일제거
				String front = fileName.substring(0, 11);
				String end = fileName.substring(13);
				s3.fileDelete(bucketName, front + end);
			}
			s3.fileDelete(bucketName, fileName); // 썸네일제거
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
