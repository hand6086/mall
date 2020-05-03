package com.hand.core.modules.export;

import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.writer.CSVFileWriter;
import com.hand.core.util.AppConstants;


public class ExportFactory {

	public static ExportWriter newInstance(QueryParams qps) throws Exception{
		FileWriter fileWriter = new CSVFileWriter();
		fileWriter.setEncoding(AppConstants.APP_EXPORT_ENCODING);
		ExportWriter exportWriter = new ExportWriter(qps,fileWriter);
		return exportWriter;
	}

}
