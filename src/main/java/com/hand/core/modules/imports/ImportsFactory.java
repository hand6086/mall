package com.hand.core.modules.imports;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.imports.reader.CSVFileReader;
import com.hand.core.util.AppConstants;


public class ImportsFactory {

	public static ImportReader newInstance(QueryParams qps,HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		MultipartFile myfile = multipartRequest.getFile("importFile"); 
		FileReader fileReader = new CSVFileReader();
		fileReader.setEncoding(AppConstants.APP_EXPORT_ENCODING);
		return new ImportReader(qps, myfile.getInputStream(), fileReader);
	}

}
