package com.icia.moviefactory.service;

import java.security.*;

import org.modelmapper.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;
@Service
public class UserMovieService {
	@Autowired
	private UserMovieDao usermovieDao;
	
	@Autowired
	private ModelMapper modelMapper;
	
//	public UserMovie read(long collNo) {
//		UserMovie usermovie = modelMapper.map(usermovieDao.read(mNo), favoritemovie.class);
//		return usermovie;
//	}

	// 좋아하는 영화 추가(usermovieDao 11번)
	public FavoriteMovie addFavoriteMovie(FavoriteMovie favoritemovie) {
		usermovieDao.addFavoriteMovie(favoritemovie);
		return favoritemovie;
	}
	
	// 좋아하는 영화 삭제(usermovieDao 12번)
	public UserMovieDao deletefavoritemovie(long mNo, String username) {
		long mLikeNo = usermovieDao.usermovieFindUsername(username); 
		usermovieDao.deleteFavoriteMovie(mLikeNo, mNo);
		return null;
	}
	
	// 좋아하는 영화 목록(usermovieDao 7번)
	public FavoriteMovie favoriteMovieList(Principal principal) {
// 오류	long mLikeNo = usermovieDao.usermovieFindUsername(username); 
		String username = principal.getName();
// 오류	usermovieDao.favoriteMovieList();
		return null;
	}

	public Object read(long collNo) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object findFollowingList(String username, String followingUsername) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object findFollowerList(String username, String followerUsername) {
		// TODO Auto-generated method stub
		return null;
	}

//	public UserMovieDao insertfavoritemovie(long mNo, String username) {
//		long mLikeNo = usermovieDao.usermovieFindUsername(username);
//	}
}
