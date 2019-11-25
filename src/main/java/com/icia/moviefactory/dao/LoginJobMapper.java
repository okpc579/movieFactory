package com.icia.moviefactory.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface LoginJobMapper {
<<<<<<< HEAD
   // LDAO-01. 로그인 실패 횟수 증가
   @Update("update member set login_failure_cnt = login_failure_cnt+1 where username=#{username}")
   public int increaseLoginFailureCount(String username);

   // LDAO-02. 로그인 실패 횟수 읽어오기 
   @Select("select login_failure_cnt from member where username=#{username} and rownum=1")
   public Integer findLoginFailureCount(String username);
   
   // LDAO-03. 로그인 5회 실패로 아이디 비활성화
   // 우리는 블록 아니다..
   // @Update("update users set enabled=0, blockday=sysdate where username=#{username}")
   // public void block(String username);
   
   // LDAO-04. 로그인 성고하면 로그인 실패 횟수 리셋
   @Update("update member set login_failure_cnt = 0 where username=#{username}")
   public int resetLoginFailureCount(String name);
   
   // LDAO-05. 로그인 성공 횟수 증가
   
<<<<<<< HEAD
   /*
    * @Update("update member set login_cnt = login_cnt+1 where username=#{username}"
    * ) public int increaseLoginCount(String username);
    */
   
   // LDAO-06. 로그인 성공하면 받은 메모가 존재하는 지 확인
   /*
    * @Select("select mno from memo where receiver=#{username} and is_read=0 and rownum=1"
    * ) public Integer isNotReadMemoExist(String username);
    */
=======
   
    @Update("update member set username=username where username=#{username}"
    ) public int increaseLoginCount(String username);
    
   
   // LDAO-06. 로그인 성공하면 받은 메모가 존재하는 지 확인
   
    @Select("select username from member where username=#{username}"
    ) public Integer isNotReadMemoExist(String username);
    
>>>>>>> dongmin_1
}
=======
	// LDAO-01. 로그인 실패 횟수 증가 4번째일때 5번 된거가 필요하기 때문에
	@Update("update member set login_failure_cnt = login_failure_cnt+1 where username=#{username}")
	public long increaseLoginFailureCount(String username);

	// LDAO-02. 로그인 실패 횟수 읽어오기 
	@Select("select login_failure_cnt from member where username=#{username} and rownum=1")
	public Long findLoginFailureCount(String username);
	
	// LDAO-03. 로그인 5회 실패로 아이디 비활성화
	// 우리는 블록 아니다..
	// @Update("update users set enabled=0, blockday=sysdate where username=#{username}")
	// public void block(String username);
	
	// LDAO-04. 로그인 성공하면 로그인 실패 횟수 리셋
	@Update("update member set login_failure_cnt = 0 where username=#{username}")
	public long resetLoginFailureCount(String name);
}
>>>>>>> soonsim2
