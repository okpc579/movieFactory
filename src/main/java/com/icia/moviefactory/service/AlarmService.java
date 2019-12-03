package com.icia.moviefactory.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;

@Service
public class AlarmService {
	@Autowired
	private AlarmDao dao;
	
	public Map<String, List<?>> my(String username) {
		
		List<MovieReviewComment> alarmcomments = dao.myalarmreviewcomment(username);
		List<MovieReviewLike> alarmreviewlikes = dao.myalarmreviewlike(username);
		List<MovieReviewCommentLike> alarmcommentlikes = dao.myalarmreviewcommentlike(username);
		Map<String, List<?>> map = new HashMap<String, List<?>>();
		map.put("comments", alarmcomments);
		map.put("reviewlikes", alarmreviewlikes);
		map.put("commentlikes", alarmcommentlikes);
		
		return map;
	}

	public List<MovieReview> you(String username) {
		return dao.you(username);
	}

}
