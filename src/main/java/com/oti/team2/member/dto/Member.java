package com.oti.team2.member.dto;

import com.oti.team2.department.dto.Department;
import com.oti.team2.institution.dto.Institution;
import com.oti.team2.jobgrade.dto.JobGrade;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(exclude="fileData")
public class Member {
	private String memberId;
	private String pswd;
	private boolean enabled;
	private String authority;
	private String flnm;
	private String addr;
	private String addrDetail;
	private String telNo;
	private String eml;
	private String instCd;
	private String jbgdCd;
	private String deptCd;
	private String memberType;
	private String fileType;
	private byte[] fileData;
	private Institution institution;
	private Department department;
	private JobGrade jobGrade;
}
