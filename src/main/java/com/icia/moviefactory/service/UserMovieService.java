package com.icia.moviefactory.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;
@Service
public class UserMovieService {
	@Autowired
	private UserMovieDao dao;

	// 3. 컬렉션 목록보기
	public List<Collections> findByUsernameCollection(String username) {
		return dao.findByUsernameCollection(username);
	}
	
	// 4. 유저리뷰 목록보기
	public List<MovieReview> findUserReview(String username) { 
		return dao.findUserReview(username);
	}
	
	// 5. 팔로잉 목록보기
	public List<Follow> findFollowing(String followerUsername) {
		return dao.findFollowing(followerUsername);
	}
		
	// 6. 팔로우 목록보기
	public List<Follow> findFollower(String followingUsername) {
		return dao.findFollower(followingUsername);
	}
	
	// 7. 평점상위보기
	public List<MovieReview> findAverageRating() {
		return dao.findAverageRating(); 		
	}
	
	// 8. (타)유저 고평점 상위보기
	public List<MovieReview> findUserTopRating(String username) {
		return dao.findUserTopRating(username);	
	}
	
	// 9. 장르별 평점 상위 보기
	public List<MovieReview> findGenretoprating(String genre) {
		return dao.findGenretoprating(genre); 		
	}
	
	// 10. 좋아하는 영화 추가
	public int insertFavoriteMovie(FavoriteMovie favoritemovie, String string) {
		return dao.insertFavoriteMovie(favoritemovie);
	}			
		
	// 11. 좋아하는 영화 삭제
	public long deleteFavoriteMovie(long mNo) {
		return dao.deleteFavoriteMovie(mNo); 
	}
	
	// 12. 좋아하는 영화 목록
	public List<FavoriteMovie> favoriteMovie(String username) {
		return dao.favoriteMovie(username);		
	}	
}
