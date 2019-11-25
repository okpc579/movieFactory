package com.icia.moviefactory.dao;

import java.util.*;
import java.util.Collection;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class UserMovieDao {
	@Autowired
	private SqlSessionTemplate tpl;
	// 1. 영화 마이페이지
	public List<User> findByUsernameMypage(String username) { 
		return tpl.selectList("userMovieMapper.findByUsernameMypage",username);
	}
	
	// 2. (타)유저 페이지 보기 // 루비의 페이지 정보를 가져오려면 어떤게 필요할까?
	public List<User> findByUsernameUserPage(String username) { 
		return tpl.selectList("userMovieMapper.findByUsernameUserPage",username);
	}
	
	// 3. 컬렉션 목록보기 
	public List<Collection> findByUsernameCollectionList(String username) {
		return tpl.selectList("userMovieMapper.findByUsernameCollectionList", username);
	}
	
	// 4. 유저리뷰 목록보기 (유저리뷰를 보려면 유저의 아이디를 알아야되고, 영화리뷰번호, 영화리뷰내용 알아야된다)
	public List<MovieReview> findUserReviewList(String username, long mRevNo, String mRevContent) { 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("mRevNo", mRevNo);
		map.put("mRevContent", mRevContent);
		return tpl.selectList("userMovieMapper.findUserReviewList", map);
	}
	
	// 5. 팔로잉 목록보기 
		public List<Follow> findFollowingList(Follow followingUsername) {
		return tpl.selectList("userMovieMapper.findfollowingList", followingUsername); 		
	}
	
	// 6.팔로워 목록보기
	public List<Follow> findFollowerList(Follow followerUsername) {
		return tpl.selectList("userMovieMapper.findfollowerList", followerUsername); 		
	}
	
	// 7.평점상위보기
	public List<MovieReview> findAverageRating(String username, long rating, long mNo ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("rating", rating);
		map.put("mNo", mNo);
		return tpl.selectList("userMovieMapper.findAverageRating", map); 		
	}
	
	// 8.유저 고평점 상위보기 (유저 고평점을 알려면 유저의 아이디, 별점<점수를알아야되니>, 영화번호)			
	public List<MovieReview> findUserTopRating(String username, long rating, long mNo ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("rating", rating);
		map.put("mNo", mNo);
		return tpl.selectList("userMovieMapper.findUserTopRating", map); 		
	}
		
	// 9.장르별 평점 상위 보기
	public List<MovieReview> findGenretopratingList(MovieReview moviereview) {
		return tpl.selectList("userMovieMapper.findGenretopratingList", moviereview); 		
	}
	
	// 10.좋아하는 영화 추가
	 public int addFavoriteMovie(FavoriteMovie favoritemovie) {
	      return tpl.insert("userMovieMapper.insertFavoriteMovie",favoritemovie);
	}
	
	// 11.좋아하는 영화 삭제
	public long deleteFavoriteMovie(long mLikeNo, long mNo) {
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("mLikeNo", mLikeNo);
		map.put("mNo", mNo);
		return tpl.update("userMovieMapper.deleteFavoriteMovie", map); 		
	}
	
	// 12.좋아하는 영화 목록 보기(Favorite 영화목록을 보려면 유저의 아이디, 좋아하는영화번호, 영화번호)
	public List<FavoriteMovie> favoriteMovieList(String username, long mLikeNo, long mNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("mLikeNo", mLikeNo);
		map.put("mNo", mNo);
		return tpl.selectList("userMovieMapper.favoriteMovieList", map); 		
	}
	
	// 13.내 선호영화 예상 목록 보기(좋아하는 영화 목록에 장르와 비슷한것?, 컬렉션 목록?
		public List<FavoriteMovie> findPreferenceMovieList(FavoriteMovie favoritemovie) { 
			return tpl.selectList("userMovieMapper.findPreferenceMovieList", favoritemovie); 		
		}
		
	// 14. 아이디로유저영화찾기
	public long usermovieFindUsername(String username) {
		return tpl.selectOne("userMovieMapper.usermsovieFindUsername", username);
	}
	
}