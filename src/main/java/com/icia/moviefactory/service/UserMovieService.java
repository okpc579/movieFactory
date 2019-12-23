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

	// 3. 컬렉션 목록보기
	public List<Collections> findByUsernameCollection(String username) {
		return dao.findByUsernameCollection(username);
	}
	
	// 4. 유저리뷰 목록보기
	/*
	public List<MovieReview> findUserReview(String username) { 
		return dao.findUserReview(username);
	}
	*/
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

	public List<MovieReview> findPreferenceMovie(String username) {
		/*
		1. 장르로 묶고 평균 평점이 상위인 장르를 뽑음
		select r.avgrating, r.genre from (select avg(rating) avgrating, genre from m_rev where username='ieb6721' group by genre) r, (select max(avg(rating)) maxrating from m_rev where username='ieb6721' group by genre) r2 where r.avgrating=r2.maxrating;
		2. 해당장르의 평균 평점이 높은걸 뽑음
		select m_no 영화번호, avg(rating)영화평점 from m_rev where m_rev.genre = (select r.genre from (select avg(rating) avgrating, genre from m_rev where username='ieb6721' group by genre) r, (select max(avg(rating)) maxrating from m_rev where username='ieb6721' group by genre) r2 where r.avgrating=r2.maxrating)
		    		group by m_no                            
		    		order by avg(rating) desc;
		3. 반복문 돌려서 그 영화가 리뷰를쓴 영화가 아니라면 리스트에 집어넣음
		4. 리스트 사이즈가 10개가 될때까지 돌림
		 */
		List<MovieReview> list = dao.findPreferenceMovie(username);
		List<MovieReview> newlist = new ArrayList<MovieReview>();
		for(int i=0; i<list.size(); i++) {
			if(dao.checkwritereview(username, list.get(i).getMNo())==null) {
				newlist.add(new MovieReview().builder().mNo(list.get(i).getMNo()).rating2(list.get(i).getRating2()).build());
				if(newlist.size()>9)
					break;
			}
			
		}
		
		return newlist;
	}

	public String checkfollowing(String username, String loginname) {
		return dao.checkfollowing(username,loginname)==null?"false":"true";
	}

	// db에 좋아요한 영화 있는 지 확인
	public String checkFavoriteMovie(Long mNo, String username) {
		String checkFavoriteMovie = dao.checkFavoriteMovie(mNo,username);
		return checkFavoriteMovie==null?"false":"true";
	}

		
//	public Page usernameReviewMovieList(String username, int pageno) {
//		System.out.println("===페이징 서비스=====");
//		int pagesize=10;
//		int count = UserMovieDao.usernameReviewMovieList(username);
//		int startRowNum = ((pageno-1) * pagesize + 1);
//		int endRowNum = startRowNum + pagesize -1;
//		if(endRowNum >= count)
//			endRowNum = count;
//		List<MovieReview> movieReviews = UserMovieDao.usernameReviewMovieList(username);
//		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviews(movieReviews).build();
//	}
}
