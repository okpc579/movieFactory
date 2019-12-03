package com.icia.moviefactory.dao;

import org.apache.ibatis.annotations.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.entity.*;

public interface RecommendMapper {
	@Select("select username from m_rev_rep where m_rev_no=#{mRevNo} and rownum=1")
	public String findById(@Param("username") String username, @Param("mRevNo") long mRevNo);
	
	@Select("select username from m_rev where username=#{username} and rownum=1")
	public String findByIds(@ModelAttribute MovieReview moviereview);

	@Insert("insert into m_rev_rep values(#{username}, #{mRevNo},#{title},#{content},#{writingDate},#{mRepCate})")
	public int insert(@ModelAttribute MovieReviewReport moviereviewreport);
	
	@Select("select username,title,content from m_cmnt_rep where m_rev_cmnt_no=#{mRevCmntNo} and rownum=1")
	public String findByIdCmnt(@Param("username") String username, @Param("mRevCmntNo") long mRevCmntNo);
	
	@Insert("insert into m_cmnt_rep values(#{mRevCmntNo}, #{username},#{title},#{content},#{writingDate},#{mRepCate})")
	void insertCmnt(@ModelAttribute MovieReviewCommentReport moviereviewcommentreport);
	
	@Insert("insert into m_rev_like values(#{mRevNo}, #{username},sysdate)")
	void insertlike(@Param("username") String username, @Param("mRevNo") long mRevNo);
	
	@Insert("insert into m_rev_rep values(#{username}, #{mRevNo},#{title},#{content},#{writingDate},#{mRepCate})")
	public void insertid(@Param("username")String username,@Param("mRevNo") Long mRevNo);
	
	@Insert("insert into m_cmnt_like values(#{mRevCmntNo},#{username},#{likeRegDate})")
	public void insertCmntlike(@ModelAttribute MovieReviewCommentLike moviereviewcommentlike);
	
	
}
