package com.icia.moviefactory;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;

import lombok.extern.slf4j.*;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class MovieDaoTest {
	@Autowired
	private MovieDao dao;
	
	// 테스트에 @Transactional을 사용하면 무조건 rollback
	//@Transactional
	//@Test
	public void insertrevTest() {
		MovieReview moviereview = new MovieReview(12,"res",2,3,"hi",1,null,"액션",0);
		dao.insertrev(moviereview);	
	}
	
	//@Transactional
	//@Test
	public void updaterevTest() {
		MovieReview m = new MovieReview(25,"res",2,3,"bye",1,null,"멜로",0);
		int result = dao.updaterev(m);
		assertThat(result, is(1));
	}
	
	//@Transactional
	//@Test
	public void deleterev() {
		
		dao.deleterev(1);
	}
	//@Transactional
	//@Test
	public void insertrevlike() {
		MovieReviewLike moviereviewlike = new MovieReviewLike(3, 1, "soon", null);
		dao.insertrevlike(moviereviewlike);
		//dao.revlikecnt(1);
		assertThat(moviereviewlike.getMRevLikeNo(), is(3L));
	}
	
	//@Test
	public void insertrevrep() {
		MovieReviewReport moviereviewreport = new MovieReviewReport("soon", 1, "신고", "신고내용", null, null);
		dao.insertrevrep(moviereviewreport);
	}
	
	//@Transactional
	//@Test
	public void insertcmnt() {
		MovieReviewComment moviereviewcomment = new MovieReviewComment(2, 1, "soon", "안녕", 0, null);
		dao.insertcmnt(moviereviewcomment);
	}
	
	//@Transactional
	//@Test
	public void updaterevcmnt() {
		MovieReviewComment m = new MovieReviewComment(2, 1, "soon", "안녕하", 0, null);
		dao.updaterevcmnt(m);
		assertThat(m.getContent(),is("안녕"));
	}
	
	//@Transactional
	//@Test
	public void deleterevcmnt() {
		dao.deleterevcmnt(1);
	}
	
	//@Test
	public void insertcmntlike() {
		MovieReviewCommentLike moviereviewcommentlike = new MovieReviewCommentLike(1, 2, "soon", null);
		dao.insertcmntlike(moviereviewcommentlike);
		assertThat(moviereviewcommentlike.getCmntLikeNo(), is(2L));
	}
	
	//@Test
	public void insertcmntrep() {
		MovieReviewCommentReport moviereviewcommentreport = new MovieReviewCommentReport(2, "soon", "신고", "신고내용", null, "스포");
		dao.insertcmntrep(moviereviewcommentreport);
	}
	
	
}
