package com.icia.moviefactory.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class UserMovieDao {
	@Autowired
	private SqlSessionTemplate tpl;
//	// 1. 영화 마이페이지
//	//	(내가 좋아하는 영화, 리뷰(평가)한목록, 컬렉션 목록, 팔로잉/팔로워 목록/
//	//  문의하기/문의내역보기 / 개인정보수정 / 탈퇴)
//	public List<Member> findByUsernameMypage(String username) { 
//		return tpl.selectList("userMovieMapper.findByUsernameMypage",username);
//	}
//	
//	// 2. (타)유저 페이지 보기
//	// (고평점Top5 영화, 리뷰(평가)한목록, 장르별 평점 영화, 
//	// 컬렉션 목록, 팔로잉/팔로워 목록)
//	public List<Member> findByUsernameUserPage(String username) { 
//		return tpl.selectList("userMovieMapper.findByUsernameUserPage",username);
//	}
	
	// 3. 컬렉션 목록보기 
	public List<Collections> findByUsernameCollection(String username) {
		return tpl.selectList("userMovieMapper.findByUsernameCollection", username);
	}
	
	// 4. 유저리뷰 목록보기 (유저리뷰를 보려면 유저의 아이디를 알아야되고, 영화리뷰번호, 영화리뷰내용 알아야된다)
	public List<MovieReview> findUserReview(String username) { 
		return tpl.selectList("userMovieMapper.findUserReview", username);
	}
	
	// 5. 팔로잉 목록보기 
		public List<Follow> findFollowing(String followerUsername) {
			return tpl.selectList("userMovieMapper.findFollowing", followerUsername);
	}
	
	// 6.팔로워 목록보기
	public List<Follow> findFollower(String followingUsername) {
		return tpl.selectList("userMovieMapper.findFollower", followingUsername); 		
	}
	
	// 7.평점 상위 보기
	public List<MovieReview> findAverageRating() {
		return tpl.selectList("userMovieMapper.findAverageRating"); 		
	}
	
	// 8.(타)유저 고평점 상위 보기 			
	public List<MovieReview> findUserTopRating(String username) {
		return tpl.selectList("userMovieMapper.findUserTopRating", username); 		
	}
		
	// 9.장르별 평점 상위 보기
	public List<MovieReview> findGenretoprating(String genre) {
		return tpl.selectList("userMovieMapper.findGenretoprating", genre); 		
	}
	
	// 10.좋아하는 영화 추가
	 public int insertFavoriteMovie(FavoriteMovie favoritemovie) {
	     return tpl.insert("userMovieMapper.insertFavoriteMovie",favoritemovie);
	}
	
	// 11.좋아하는 영화 삭제
	public long deleteFavoriteMovie(long mNo) {
		return tpl.delete("userMovieMapper.deleteFavoriteMovie",mNo);
	}
//	public long deleteFavoriteMovie(long mLikeNo, long mNo) {
//		Map<String, Long> map = new HashMap<String, Long>();
//		map.put("mLikeNo", mLikeNo);
//		map.put("mNo", mNo);
//		return tpl.delete("userMovieMapper.deleteFavoriteMovie", map); 		
//	}
	
	// 12.좋아하는 영화 목록 보기(Favorite 영화목록을 보려면 유저의 아이디, 좋아하는영화번호, 영화번호)
	public List<FavoriteMovie> favoriteMovie(String username) {	
		return tpl.selectList("userMovieMapper.favoriteMovie", username); 
	}
//	public List<FavoriteMovie> favoriteMovieList(FavoriteMovie favoritemovie) {
//		return tpl.selectList("userMovieMapper.insertFavoriteMovie",favoritemovie);
//	}
//	public List<FavoriteMovie> favoriteMovieList(long mNo, String username) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("mNo", mNo);
//		map.put("username", username);
//		return tpl.selectList("userMovieMapper.favoriteMovieList", map); 		
//	}
	
	// 13.내 선호영화 예상 목록 보기(좋아하는 영화 목록에 장르와 비슷한것?, 컬렉션 목록?
		public List<FavoriteMovie> findPreferenceMovie(FavoriteMovie favoritemovie) { 
			return tpl.selectList("userMovieMapper.findPreferenceMovie", favoritemovie); 		
		}
		
	// 14. 영화번호로 아이디 찾기
	public long userMovieFindUsername(long mNo) {
		return tpl.selectOne("userMovieMapper.userMovieFindUsername", mNo);
	}	
}