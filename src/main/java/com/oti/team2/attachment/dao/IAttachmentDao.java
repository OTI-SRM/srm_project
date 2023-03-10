package com.oti.team2.attachment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.oti.team2.attachment.dto.AttachResponseDto;
import com.oti.team2.attachment.dto.Attachment;

public interface IAttachmentDao {
	int insertAttachment(@Param("attachList")List<Attachment> attachList);
	
	List<AttachResponseDto> selectAttachByBbsNoOrDmndNo(@Param("bbsNo")int bbsNo, @Param("dmndNo") int dmndNo);

	AttachResponseDto selectAttachByFileSn(int fileSn);
}