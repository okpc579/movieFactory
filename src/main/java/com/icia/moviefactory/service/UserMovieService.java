package com.icia.moviefactory.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.dto.*;
import com.icia.moviefactory.entity.*;
@Service
public class UserMovieService {
	@Autowired
	private UserMovieDao dao;
	
	// 4. 유저리뷰 목록보기
	public Page findUserReview(String username, int pageno) {
		int pagesize=10;
		int count = dao.findReviewMovieCount(username);//내 리뷰가 몇개있는지 세는거
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReview> movieReviews = dao.findUserReview(username, startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviews(movieReviews).build();
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
	public int insertFavoriteMovie(Long mNo, String username) {
		return dao.insertFavoriteMovie(mNo,username);
	}			
		
	// 11. 좋아하는 영화 삭제
	public long deleteFavoriteMovie(Long mNo,String username) {
		return dao.deleteFavoriteMovie(mNo,username); 
	}
	
	// 12. 좋아하는 영화 목록
	public List<MovieReview> favoriteMovie(String username) {
		//dao.favoriteMovie(username);
		List<FavoriteMovie> favoritemovies = dao.favoriteMovie(username);
		List<MovieReview> moviereviews = new ArrayList<MovieReview>();
		for(int i=0; i< favoritemovies.size(); i++) {
			if(dao.findReviewByMno(favoritemovies.get(i).getMNo())==null) {
				moviereviews.add(new MovieReview().builder().mNo(favoritemovies.get(i).getMNo()).rating2(0).build());
			}else {
				moviereviews.add(dao.findReviewByMno(favoritemovies.get(i).getMNo()));
			}
		}
		return moviereviews;		
	}

	public String findNickname(String username) {
		return dao.findNickname(username);
	}

	public Void addfollowing(String username, String loginname) {
		dao.addfollowing(username, loginname);
		return null;
	}

	public Void deletefollowing(String username, String loginname) {
		dao.deletefollowing(username, loginname);
		return null;
	}
	
	public String checkfollowing(String username, String loginname) {
		return dao.checkfollowing(username,loginname)==null?"false":"true";
	}

	// db에 좋아요한 영화 있는 지 확인
	public String checkFavoriteMovie(Long mNo, String username) {
		String checkFavoriteMovie = dao.checkFavoriteMovie(mNo,username);
		return checkFavoriteMovie==null?"false":"true";
	}
}
