package com.icia.moviefactory;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.icia.moviefactory.dao.NoticeDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class NoticeDaoTest {
	@Autowired
	private NoticeDao noticeDao;
	
	@Test
	public void noticeFindAllCountTest() {
		assertThat(noticeDao.findAllCount(),is(1));
	}
		
}
