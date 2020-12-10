package com.yourgg.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int boardNumber;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private Date boardRegdate;
	private String boardPassword;
}
