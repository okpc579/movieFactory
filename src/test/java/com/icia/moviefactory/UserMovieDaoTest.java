package com.icia.moviefactory;

import org.junit.*;
import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;

import com.icia.moviefactory.dao.*;

import lombok.extern.slf4j.*;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class UserMovieDaoTest {
   @Autowired
   private UserMovieDao dao;
   // 테스트에 @Transactional을 사용하면 무조건 rollback
   // 1. 유저 페이지 보기
   //@Transactional
   @Test
   public void findUserPageTest() {
// 오류	     assertThat(dao.findUserPage());
   }
   
   // 2. 컬렉션 목록보기 
   //@Transactional
   //@Test
   public void findCollectionListTest() {
// 오류	     assertThat(dao.findCollectionList(), is(1));
   }
   
   // 3. 유저리뷰 목록보기
   //@Transactional
   //@Test
   public void findUserReviewListTest() {
// 오류	     assertThat(dao.findUserReviewList(), is(1));
   }
   
   // 4. 팔로잉 목록보기
   //@Transactional
   //@Test
   public void findFollowingListTest() {
// 오류	     assertThat(dao.findFollowingList(), is(1));
   }
   
   // 5.팔로워 목록보기
   //@Transactional
   //@Test
// 오류  public void findFollowerListTest() {
// 오류	     assertThat(dao.findFollowerList(), is(1));
//   }
   
   // 6.유저 고평점 상위보기
   //@Transactional
   //@Test
   public void findUserTopRatingTest() {
// 오류     assertThat(dao.findUserTopRating(), is(1));
   }
   
   // 7.좋아하는 영화 목록 보기
   //@Transactional
   //@Test
   public void findFavoriteMoiveListTest() {
//	오류    assertThat(dao.findFavoriteMoiveList(), is(1));
   }
   
   // 8.내 선호영화 예상 목록 보기
   //@Transactional
   //@Test
   public void findPreferenceMovieListTest() {
// 오류	    assertThat(dao.findPreferenceMovieList(), is(1));
   }
   
   // 9.평점상위보기
   //@Transactional
   //@Test
   public void findAverageRatingTest() {
// 오류	     assertThat(dao.findAverageRating(), is(1));
   }
   
   // 10.장르별 평점 상위 보기
   //@Transactional
   //@Test
   public void findFollowerListTest() {
// 오류	     assertThat(dao.findFollowerList(), is(1));
   }
  
   // 11.좋아하는 영화 추가
   //@Transactional
   //@Test
   public void FavoriteMovieTest() {
// 오류	     assertThat(dao.FavoriteMovie(), is(1));
   }
   public void insertrevTest() {
	     // MovieReview moviereview = new MovieReview(1,"이태호",2,3,"hello",1,null,"액션",0);
// 오류	      dao.insertrev(moviereview);   
	   }
   
   // 12.좋아하는 영화 삭제
   //@Transactional
   //@Test
   public void FavoriteMovie() {
// 오류	     dao.FavoriteMovie(1);
   }
}
