package com.icia.moviefactory;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import java.util.*;

import org.junit.*;
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
public class UserMovieDaoTest {
   @Autowired
   private UserMovieDao dao;
   // 테스트에 @Transactional을 사용하면 무조건 rollback
   
//   // 1. 영화 마이페이지 보기
//   //@Transactional
//   //@Test
//   public void findByUsernameMypageTest() {
//
//   }
//   
//   // 2. 유저 페이지 보기
//   // @Transactional
//   // @Test
//   public void findByUsernameUserPageTest() {
//		assertThat(dao.findByUsernameUserPage(""));
//   }
   
   // 3. 컬렉션 목록보기 OK
   // @Transactional
   // @Test
   public void findByUsernameCollectionTest() {
	   	List<Collections> result = dao.findByUsernameCollection("ieb6721");
	   	assertThat(result.size(), is(3));
   }
   
   // 4. 유저리뷰 목록보기 OK
   // @Transactional
   // @Test
   public void findUserReviewTest() {
	   	List<MovieReview> result = dao.findUserReview("ieb6721");
	   	assertThat(result.size(), is(5));
	   	// System.out.println();
   }
   
   // 5. 팔로잉 목록보기(followingUsername) OK
   // @Transactional
   // @Test
   public void findFollowingTest() {
	   	//List<Follow> result = dao.findFollowing("ieb6721");
	   	//assertThat(result.size(), is(3));
//		System.out.println(dao.findFollowingList("xogh8121"));
//		assertThat(result, is(1));
//		List<Follow> result = dao.findFollowingList("abcdef", "123456");
//		assertThat(result.size(), is(1));
  }
   
   // 6. 팔로워 목록보기(followerUsername) OK
   // @Transactional
   // @Test
   public void findFollowerTest() {
	  // 	List<Follow> result = dao.findFollower("xogh8122");
	   	//assertThat(result.size(), is(0));
//		System.out.println(dao.findFollowerList("xogh8122"));
//		assertThat(result, is(1));
   }
   
   // 7. 평점 상위보기 OK
   // @Transactional
   //@Test
   public void findAverageRatingTest() {
    	List<MovieReview> result = dao.findAverageRating();
    	//System.out.println(dao.findAverageRating());
    	assertThat(result.size(), is(5));
    	// assertThat(dao.findAverageRating());
   }
   
   // 8. 유저 고평점 상위보기 OK
   // @Transactional
   // @Test
   // @Test
   public void findUserTopRatingTest() {
    	List<MovieReview> result = dao.findUserTopRating("ieb6721");
    	//System.out.println(dao.findAverageRating());
    	assertThat(result.size(), is(5));
    	// assertThat(dao.findAverageRating());
   }

   
   // 9. 장르별 고평점 상위보기 OK
   // @Transactional
   @Test
   public void findGenretopratingTest() {
	   List<MovieReview> result = dao.findGenretoprating("액션");
   		//System.out.println(dao.findGenretoprating());
   		assertThat(result.size(), is(5));
   		//assertThat(dao.findGenretoprating());
	   
  }
   
   // 10. 좋아하는 영화 추가 (mNo, username, sysdate) OK
   // @Transactional
   // @Test
	/*
	 * public void insertFavoriteMovieTest() {
	 * assertThat(dao.insertFavoriteMovie(new FavoriteMovie(119,"ieb6721",null)),
	 * is(1)); assertThat(dao.insertFavoriteMovie(new
	 * FavoriteMovie(120,"ieb67210",null)), is(1));
	 * assertThat(dao.insertFavoriteMovie(new FavoriteMovie(125,"xogh8121",null)),
	 * is(1)); assertThat(dao.insertFavoriteMovie(new
	 * FavoriteMovie(1556,"xogh8123",null)), is(0)); }
	 */
   
   // 11. 좋아하는 영화 삭제 (long mNo) OK
   // @Transactional
   //@Test
	/*
	 * public void deleteFavoriteMovieTest() { long result
	 * =dao.deleteFavoriteMovie(1556); // assertThat(result, is(0L)); }
	 */
   // 12. 좋아하는 영화 목록 보기 (String username) OK
   // @Transactional
   // @Test
   public void favoriteMovieTest() {
	   // assertThat(dao.favoriteMovieList(new FavoriteMovie(20, "ieb6721"));
	   	List<FavoriteMovie> result =dao.favoriteMovie("ieb67210");
	    assertThat(result.size(), is(2));
//		List<FavoriteMovie> result =dao.favoriteMovieList("ieb6721");
//	    assertThat(result.size(), is(4));
   }
   
//   // 13. 내 선호영화 예상 목록 보기 (어려울거라고 동윤이형이 해준다고는 함..)
//   // @Transactional
//   // @Test
//   public void findPreferenceMovieListTest() {
//	   System.out.println(dao.findPreferenceMovieList(favoritemovie);
//		// assertThat(result, is(1));
//   }
   
//   // 14. 아이디로유저영화찾기
//   //@Transactional
//   //@Test
//   public void usermovieFindUsernameTest() {
//		int result = dao.usermovieFindUsername(1);
//		assertThat(result, is(1));
//   }

   
}
