package com.icia.moviefactory.dao;

import org.apache.ibatis.annotations.*;

@Mapper
public interface LoginJobMapper {

	// LDAO-01. 로그인 실패 횟수 증가 4번째일때 5번 된거가 필요하기 때문에
	@Update("update member set login_failure_cnt = login_failure_cnt+1 where username=#{username} and login_failure_cnt < 5")
	public long increaseLoginFailureCount(String username);

	// LDAO-02. 로그인 실패 횟수 읽어오기 
	@Select("select login_failure_cnt from member where username=#{username} and rownum=1")
	public Long findLoginFailureCount(String username);
	
	// LDAO-03. 로그인 성공하면 로그인 실패 횟수 리셋
	@Update("update member set login_failure_cnt = 0 where username=#{username}")
	public long resetLoginFailureCount(String name);
	
	@Update("update member set LAST_LOGIN_DATE = RECENT_LOGIN_DATE where username=#{username}")
	public long updateLastLoginDate(String username);
	
	@Update("update member set RECENT_LOGIN_DATE = sysdate where username=#{username}")
	public long updateRecentLoginDate(String username);
	
}

