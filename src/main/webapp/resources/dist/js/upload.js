function checkImageType(fileName) {
	var pattern = /JPG|GIF|PNG|JPEG/i;
	return fileName.match(pattern);
}

function getFileInfo(fullName) {

	var fileName, imgsrc;
	if (checkImageType(fullName)) {
		imgsrc = "/displayFile?fileName=" + fullName;
		fileName = fullName.substr(fullName.indexOf("_") + 1);
	}
	return {
		fileName : fileName,
		imgsrc : imgsrc,
		fullName : fullName
	};
}
