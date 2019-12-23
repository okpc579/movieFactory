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
	// 3. 컬렉션 목록보기 
	public List<Collections> findByUsernameCollection(String username) {
		return tpl.selectList("userMovieMapper.findByUsernameCollection", username);
	}
	
	// 4. 유저리뷰 목록보기 (유저리뷰를 보려면 유저의 아이디를 알아야되고, 영화리뷰번호, 영화리뷰내용 알아야된다)
	public List<MovieReview> findUserReview(String username, int startRowNum, int endRowNum ) { 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		return tpl.selectList("userMovieMapper.findUserReviewList", map);
	}
	
	// 5. 팔로잉 목록보기 
		public List<Follow> findFollowing(String followerUsername) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("followerUsername", followerUsername);
			//map.put("loginname", loginname);
			return tpl.selectList("userMovieMapper.findFollowingList", map);
	}
	
	// 6.팔로워 목록보기
	public List<Follow> findFollower(String followingUsername) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("followingUsername", followingUsername);
		//map.put("loginname", loginname);
		return tpl.selectList("userMovieMapper.findFollowerList", map); 		
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
	 public int insertFavoriteMovie(Long mNo, String username) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("mNo", mNo);
		 map.put("username", username);
	     return tpl.insert("userMovieMapper.insertFavoriteMovie",map);
	}
	
	// 11.좋아하는 영화 삭제
	public long deleteFavoriteMovie(Long mNo, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mNo", mNo);
		map.put("username", username);
		return tpl.delete("userMovieMapper.deleteFavoriteMovie",map);
	}

	
	// 12.좋아하는 영화 목록 보기(Favorite 영화목록을 보려면 유저의 아이디, 좋아하는영화번호, 영화번호)
	public List<FavoriteMovie> favoriteMovie(String username) {	
		return tpl.selectList("userMovieMapper.favoriteMovieList", username); 
	}
	
	// 13.내 선호영화 예상 목록 보기(좋아하는 영화 목록에 장르와 비슷한것?, 컬렉션 목록?
		public List<FavoriteMovie> findPreferenceMovie(FavoriteMovie favoritemovie) { 
			List<FavoriteMovie> list = tpl.selectList("userMovieMapper.findPreferenceMovie", favoritemovie);
			return list;
		}
		
	// 14. 영화번호로 아이디 찾기
	public long userMovieFindUsername(long mNo) {
		return tpl.selectOne("userMovieMapper.userMovieFindUsername", mNo);
	}

	public String findNickname(String username) {
		return tpl.selectOne("userMovieMapper.findNicknameByUsername", username);
	}

	public int addfollowing(String username, String loginname) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("loginname", loginname);
		return tpl.insert("userMovieMapper.addfollowing", map); 		
	}

	public int deletefollowing(String username, String loginname) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("loginname", loginname);
		return tpl.delete("userMovieMapper.deletefollowing", map); 		
	}

	public List<MovieReview> findPreferenceMovie(String username) {
		List<MovieReview> list =  tpl.selectList("userMovieMapper.findPreferenceMovieList", username);
		list.stream().forEach(s->System.out.println(s));
		return list;
	}

	public MovieReview checkwritereview(String username, long mNo) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("username", username);
		map.put("mNo", mNo);
		return tpl.selectOne("userMovieMapper.checkwritereview", map);
	}

	public String checkfollowing(String username, String loginname) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("loginname", loginname);
		return tpl.selectOne("userMovieMapper.checkfollowing", map);
	}

	
	// 전체 리뷰 개수
	public int findReviewMovieCount(String username) {
		return tpl.selectOne("userMovieMapper.findReviewMovieCount", username);
	}
	
	public MovieReview findReviewByMno(long mno) {
		return tpl.selectOne("userMovieMapper.findReviewById", mno);
	}
	
	// 전체 리뷰의 개수를 이용한 페이징
//	public List<MovieReview> usernameReviewMovieList(String username, int startRowNum, int endRowNum) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("username", username);
//		map.put("startRowNum", startRowNum);
//		map.put("endRowNum", endRowNum);
		
//		return tpl.selectList("userMovieMapper.findReviewMovieListByUsername", map);
//	}


	// db에 좋아요한 영화 있는 지 확인
	public String checkFavoriteMovie(Long mNo, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mNo", mNo);
		map.put("username", username);
		return tpl.selectOne("userMovieMapper.checkFavoriteMovie",map);
	}

}