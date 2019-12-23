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
	public List<Follow> findFollowing(String followerUsername, String loginname) {
		return dao.findFollowing(followerUsername, loginname);
	}
		
	// 6. 팔로우 목록보기
	public List<Follow> findFollower(String followingUsername, String loginname) {
		return dao.findFollower(followingUsername, loginname);
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
}
