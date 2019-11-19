package com.icia.moviefactory.service;

import java.util.*;

import org.modelmapper.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.entity.Collection;

@Service
public class CollectionService {
	@Autowired
	private CollectionDao collectionDao;
	
	@Autowired
	private ModelMapper modelMapper;
	
	public Collection add(Collection collection) {
		collectionDao.add(collection);
		return collection;
	}

	public Collection read(long collNo) {
		Collection collection = modelMapper.map(collectionDao.read(collNo), Collection.class);
		return collection;
	}

	public Collection addmovie(long mNo, long collNo, String username) {
		String collectionUsername = collectionDao.collectionFindUsername(collNo); 
		if(collectionUsername==null) {
			//해당되는 아이디가 없을경우
			return null;
		}else if(username.equals(collectionUsername)) {
			//아이디가 같을경우
			collectionDao.addmovie(mNo, collNo);
		}else {
			//DB랑 로그인한 유저랑 다를경우 
		}
		return null;
	}

	public Collection update(Collection collection) {
		String collectionUsername = collectionDao.collectionFindUsername(collection.getCollNo()); 
		if(collectionUsername==null) {
			//해당되는 아이디가 없을경우
			return null;
		}else if(collection.getUsername().equals(collectionUsername)) {
			//아이디가 같을경우
			collectionDao.update(collection);
		}else {
			//DB랑 로그인한 유저랑 다를경우 
		}
		return collection;
	}

	public Collection deletemovie(long mNo, long collNo, String username) {
		String collectionUsername = collectionDao.collectionFindUsername(collNo); 
		if(collectionUsername==null) {
			//해당되는 아이디가 없을경우
			return null;
		}else if(username.equals(collectionUsername)) {
			//아이디가 같을경우
			collectionDao.deletemovie(mNo, collNo);
		}else {
			//DB랑 로그인한 유저랑 다를경우 
		}
		return null;
	}

	public Void delete(long collNo, String username) {
		String collectionUsername = collectionDao.collectionFindUsername(collNo); 
		if(collectionUsername==null) {
			//해당되는 아이디가 없을경우
			return null;
		}else if(username.equals(collectionUsername)) {
			//아이디가 같을경우
			collectionDao.delete(collNo);
		}else {
			//DB랑 로그인한 유저랑 다를경우 
		}
		
		return null;
	}

	public Collection like(CollectionLike collectionLike) {
		
		collectionDao.like(collectionLike);
		collectionDao.increaselikecnt(collectionLike.getCollNo());
		return null;
	}

	public Void cancelLike(CollectionLike collectionLike) {
		String collectionLikeUsername = collectionDao.collectionLikeFindUsername(collectionLike.getCollNo(), collectionLike.getUsername()); 
		if(collectionLikeUsername==null) {
			//해당되는 아이디가 없을경우
			return null;
		}else if(collectionLike.getUsername().equals(collectionLikeUsername)) {
			//아이디가 같을경우
			collectionDao.decreaselikecnt(collectionLike.getCollNo());
			collectionDao.cancleLike(collectionLike);
		}else {
			//DB랑 로그인한 유저랑 다를경우 
		}
		
		
		return null;
	}

	public List<Collection> movieCollectionList(long mNo) {
		return collectionDao.movieCollectionList(mNo);
	}

	public List<Collection> usernameCollectionList(String username) {
		return collectionDao.usernameCollectionList(username);
	}

}
