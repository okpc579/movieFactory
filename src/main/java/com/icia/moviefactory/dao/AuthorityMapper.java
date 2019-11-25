package com.icia.moviefactory.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

public interface AuthorityMapper {
   // ADAO-01. 권한 정보 저장
   @Insert("insert into authorities(username, authority) values(#{username}, #{authority})")
   public int insert(@Param("username") String username, @Param("authority") String authority);
   
   // ADAO-02. 사용자의 모든 권한 삭제
   @Delete("delete from authorities where username=#{username}")
   public int delete(@Param("username") String username);
}