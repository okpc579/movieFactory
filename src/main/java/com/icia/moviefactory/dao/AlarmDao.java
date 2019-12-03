package com.icia.moviefactory.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class AlarmDao {
	@Autowired
	private SqlSessionTemplate tpl;

	public List<MovieReviewComment> myalarmreviewcomment(String username) {
		return tpl.selectList("alarmMapper.myalarmreviewcomment", username);
	}
	public List<MovieReviewLike> myalarmreviewlike(String username) {
		return tpl.selectList("alarmMapper.myalarmreviewlike", username);
	}
	public List<MovieReviewCommentLike> myalarmreviewcommentlike(String username) {
		return tpl.selectList("alarmMapper.myalarmreviewcommentlike", username);
	}

	public List<MovieReview> you(String username) {
		return tpl.selectList("alarmMapper.you", username);
	}	
}
