package com.icia.moviefactory.dao;

import org.apache.ibatis.annotations.*;

@Mapper
public interface LoginJobMapper {
	// LDAO-01. 로그인 실패 횟수 증가
	@Update("update users set login_failure_cnt = login_failure_cnt+1 where username=#{username}")
	public int increaseLoginFailureCount(String username);

	// LDAO-02. 로그인 실패 횟수 읽어오기 
	@Select("select login_failure_cnt from users where username=#{username} and rownum=1")
	public Integer findLoginFailureCount(String username);
	
	// LDAO-03. 로그인 5회 실패로 아이디 비활성화
	@Update("update users set enabled=0, blockday=sysdate where username=#{username}")
	public void block(String username);
	
	// LDAO-04. 로그인 성고하면 로그인 실패 횟수 리셋
	@Update("update users set login_failure_cnt = 0 where username=#{username}")
	public int resetLoginFailureCount(String name);
	
	// LDAO-05. 로그인 성공 횟수 증가
	@Update("update users set login_cnt = login_cnt+1 where username=#{username}")
	public int increaseLoginCount(String username);
	
	// LDAO-06. 로그인 성공하면 받은 메모가 존재하는 지 확인
	@Select("select mno from memo where receiver=#{username} and is_read=0 and rownum=1")
	public Integer isNotReadMemoExist(String username);

}