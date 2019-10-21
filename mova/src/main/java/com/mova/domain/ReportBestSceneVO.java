package com.mova.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReportBestSceneVO {

	private Long rebsno;
	private Long bsno;
	private String reporter;
	private BestSceneVO bestscene;
	
}
