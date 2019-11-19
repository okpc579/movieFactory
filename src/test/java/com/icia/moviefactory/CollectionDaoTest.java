package com.icia.moviefactory;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import org.junit.*;
import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;
import org.springframework.transaction.annotation.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;

import lombok.extern.slf4j.*;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class CollectionDaoTest {
	@Autowired
	private CollectionDao dao;
	
	// 테스트에 @Transactional을 사용하면 무조건 rollback
	//@Transactional
	//@Test
	public void collectionAddTest() {
		Collection collection = new Collection(1, "컬렉션1","spring",null,"짱짱컬렉션입니다",null);
		collection.getDetail().size();
		int result = dao.add(collection);
		assertThat(result, is(1));
	}
	//@Test
	public void collectionReadTest() {
		System.out.println(dao.read(2)); 
		//assertThat(result, is(1));
	}
	//@Transactional
	//@Test
	public void collectionDetailAddTest() {
		int result = dao.addmovie(3, 2);
		assertThat(result, is(1));
	}
	
	//@Transactional
	//@Test
	public void collectionUpdateTest() {
		Collection collection = new Collection(1, "컬렉션1","spring",null,"짱짱컬렉션입니다",null);
		int result = dao.update(collection);
		assertThat(result, is(1));
	}
	//@Transactional
	//@Test
	public void collectionDeleteMovieTest() {
		int result = dao.deletemovie(1, 1);
		assertThat(result, is(1));
	}
	
	//@Transactional
	//@Test
	public void collectionDeleteTest() {
		int result = dao.delete(1);
		assertThat(result, is(1));
	}
	//@Transactional
	//@Test
	public void collectionLikeTest() {
		int result = dao.like(new CollectionLike(1,  2, "spring", null));
		assertThat(result, is(1));
	}
	@Transactional
	@Test
	public void collectionCancleLikeTest() {
		int result = dao.cancleLike(new CollectionLike(1,  1, "spring", null));
		assertThat(result, is(1));
	}
	
}
