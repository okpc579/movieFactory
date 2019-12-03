package com.icia.moviefactory;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;

import com.icia.moviefactory.dao.*;

import lombok.extern.slf4j.*;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class AdminDaoTest {
	@Autowired
	private AdminDao dao;
	
	// 블라인드 된 리뷰 블라인드 여부 수정
	//@Test
	public void updateRevBlindTest() {
		assertThat(dao.updateRevBlind(1),is(1L));
	}
	
	// 블라인드 된 댓글 블라인드 여부 수정
	//@Test
	public void updateCmntBlindTest() {
		assertThat(dao.updateCmntBlind(6),is(1L));
	}
	
	// 블라인드 된 댓글 상세(신고목록)
	//@Test
	public void readCmntBlindTest() {
		System.out.println(dao.readCmntBlind(1));
		assertThat(dao.readRevBlind(1).size(), is(4));
	}
	
	// 블라인드 된 리뷰 상세(신고목록)
	// @Test
	public void readRevBlind() {
		System.out.println(dao.readRevBlind(2));
		assertThat(dao.readRevBlind(2).size(), is(2));
	}
	
	// 블락리스트 상세
	//@Test
	//@Transactional
	public void findRevBlindByUser() {
		System.out.println(dao.findRevBlindByUser("soon1234"));
		assertThat(dao.findRevBlindByUser("soon1234").size(), is(2));
		
	}
	//@Test
	public void findRevCmntBlindByUser() {
		System.out.println(dao.findRevCmntBlindByUser("soon1234"));
	}
	
	// 블락 된 계정 블락여부 수정
	//@Test
	public void updateEnabled() {
		assertThat(dao.updateEnabled("soon"),is(1L));
	}
	
	// 블라인드 당한 댓글 수
	//@Test
	public void findRevCmntBlindCount() {
		System.out.println(dao.findRevCmntBlindCount());
		assertThat(dao.findRevCmntBlindCount(),is(2));
	}
	
	// 블라인드당한 댓글 읽어오기
	//@Test
	public void findRevCmntBlind() {
		System.out.println(dao.findRevCmntBlind(1, 10));
		assertThat(dao.findRevCmntBlind(1,10).size(),is(1));
	}

	// 블라인드 당한 리뷰 수
	// @Test
	public void findRevBlindCount() {
		System.out.println(dao.findRevBlindCount());
		assertThat(dao.findRevBlindCount(),is(1));
	}
	
	// 블라인드당한 리뷰 읽어오기
	// @Test
	public void findRevBlind() {
		System.out.println(dao.findRevBlind(1, 10));
		assertThat(dao.findRevBlind(1,10).size(),is(1));
	}
	
	// 블락 당한 유저 수 (0)
	//@Test
	public void findEnabledCount() {
		System.out.println(dao.findEnabledCount());
		assertThat(dao.findEnabledCount(),is(1));
	}
	
	// 블락리스트 읽어오기 
	//@Test
	public void findAllEnabledList() {
		System.out.println(dao.findAllEnabledList(1,20));
		assertThat(dao.findAllEnabledList(1, 20).size(),is(2));
	}
}
