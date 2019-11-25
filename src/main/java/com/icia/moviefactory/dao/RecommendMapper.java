package com.icia.moviefactory.dao;

import org.apache.ibatis.annotations.*;

public interface RecommendMapper {
	@Select("select username from m_rev_rep where m_rev_no=#{mRevNo} and rownum=1")
	public String findById(@Param("username") String username, @Param("mRevNo") long mRevNo);

	@Insert("insert into m_rev_rep values(#{username}, #{mRevNo},#{title},#{content},#{writingDate},#{mRepCate})")
	void insert(@Param("username") String username, @Param("mRevNo") long mRevNo);
	
	@Select("select username from m_cmnt_rep where m_rev_cmnt_no=#{mRevCmntNo} and rownum=1")
	public String findByIdCmnt(@Param("username") String username, @Param("mRevCmntNo") long mRevCmntNo);
	
	@Insert("insert into m_cmnt_rep values(#{username}, #{mRevCmntNo},#{title},#{content},#{writingDate},#{mRepCate})")
	void insertCmnt(@Param("username") String username, @Param("mRevNo") long mRevCmntNo);
	
}
