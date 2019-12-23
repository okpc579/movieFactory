package com.icia.moviefactory.service;

import java.util.*;

import org.modelmapper.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.dto.*;
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

	public Map read(long collNo, int pageno) {
		int pagesize=10;
		int count = collectionDao.findcollNoCollectionDetailCount(collNo);
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		Map map = new HashMap(); 
		map = collectionDao.read(collNo, startRowNum, endRowNum);
		map.put("pageno", pageno);
		map.put("pagesize", pagesize);
		map.put("totalcount", count);
		
		return map;
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
		System.out.println(collection);
		String collectionUsername = collectionDao.collectionFindUsername(collection.getCollNo());
		if(collectionUsername==null) {
			//해당되는 아이디가 없을경우
			System.out.println(1);
			return null;
		}else if(collection.getUsername().equals(collectionUsername)) {
			//아이디가 같을경우
			System.out.println(2);
			collectionDao.update(collection);
		}else {
			System.out.println(3);
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

	public Page movieCollectionList(long mNo, int pageno) {
		System.out.println("===페이징 서비스=====");
		int pagesize=10;
		int count = collectionDao.findMovieCollectionCount(mNo);
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<Collection> collections = collectionDao.movieCollectionList(mNo, startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).collections(collections).build();
	}

	public Page usernameCollectionList(String username, int pageno) {
		System.out.println("===페이징 서비스=====");
		int pagesize=10;	
		int count = collectionDao.findUsernameCollectionCount(username);
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<Collection> collections = collectionDao.usernameCollectionList(username, startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).collections(collections).build();
	}

	public String checklike(long collNo, String name) {
		String collectionLikeUsername = collectionDao.collectionLikeFindUsername(collNo, name);
		return collectionLikeUsername==null?"false":"true";
	}

	
	public Map read2(long collNo) {
		return collectionDao.read2(collNo);
	}

	public Collection read3(long collNo) {
		return collectionDao.read3(collNo);
	}
	
}
