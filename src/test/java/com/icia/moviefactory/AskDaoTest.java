package com.icia.moviefactory;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.icia.moviefactory.dao.AskDao;
import com.icia.moviefactory.entity.AdminAsk;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class AskDaoTest {
	@Autowired
	private AskDao askDao;
	
	//@Test
	public void askFindAllCountTest() {
		assertThat(askDao.findAllCount(),is(1));
	}
	
	//@Test
	public void findCountByUsernameTest() {
		assertThat(askDao.findCountByUsername("박동민"),is(1));
	}
	
	//@Transactional
	//@Test
	public void insertTest() {
		List<String> list = new ArrayList();
		list.add("바보");
		assertThat(askDao.insert(new AdminAsk(99, "손지혜", "미친천재", "똑띡이", null, null, "답변중")),is(1));
	}

	//@Transactional
	//@Test
	public void update() {
		assertThat(askDao.update(new AdminAsk(10,"박동민","천재","빡고수",null,null,"답변완료")),is(1));
	}
	//@Transactional
	//@Test
	public void delete() {
		assertThat(askDao.delete(10L),is(1));
	}
	// 페이징 테스트
	//@Transactional
	//@Test
	public void findAllByUsername() {
		assertThat(askDao.findAllByUsername(1, 5, "박동민").size(),is(1));
	}
	
	//@Transactional
	//@Test
	public void findAll() {
		assertThat(askDao.findAll(1, 5).size(),is(1));
	}
	// 글답변
	//@Transactional
	//@Test
	public void askAnswer() {	
		assertThat(askDao.askAnswer(new AdminAsk(13,"박동민","개멍청이","빡고수",null,"알랄라울랄라하세요","답변완료")),is(1));
	}
	// 작성자 읽어오기
	//@Transactional
	//@Test
	public void findUsernameById() {
		assertThat(askDao.findUsernameById(16),is("박동민"));
	}
	// 글 상세
	//@Transactional
	@Test
	public void findByAdminAsk() {
		assertThat(askDao.findByAdminAsk(16),is(1));
	}
}
