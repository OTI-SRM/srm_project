package com.oti.team2.board.dto;

import java.sql.Date;
import java.util.List;

import com.oti.team2.attachment.dto.AttachResponseDto;
import com.oti.team2.comment.dto.CommentDto;

import lombok.Data;

@Data
public class Board {
	private int bbsNo;
	private String bbsType;
	private String bbsTtl;
	private String bbsCn;
	private Date wrtYmd;
	private String wrtrNm; // 작성자 이름 
	private String wrtrId;
	private boolean atchYn; // 첨부파일 유무
	
	private int inqCnt; // 조회수
	private boolean ansYn; //답변상태
	private String srNo; 
	
	private List<AttachResponseDto> srcList;
	private CommentDto comments;
}
