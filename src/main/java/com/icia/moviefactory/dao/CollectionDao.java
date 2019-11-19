package com.icia.moviefactory.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.entity.Collection;

@Repository
public class CollectionDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public int add(Collection collection) {
		return tpl.insert("collectionMapper.insert", collection);
	}

	public Map read(long collNo) {
		return tpl.selectOne("collectionMapper.findByIdWithDetail", collNo);
	}

	public int addmovie(long mNo, long collNo) {
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("mNo", mNo);
		map.put("collNo", collNo);
		return tpl.insert("collectionMapper.insertDetail", map);
	}

	public int update(Collection collection) {
		return tpl.update("collectionMapper.update", collection);
	}

	public int deletemovie(long mNo, long collNo) {
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("mNo", mNo);
		map.put("collNo", collNo);
		return tpl.delete("collectionMapper.deleteDetail", map);
	}

	public int delete(long collNo) {
		return tpl.delete("collectionMapper.delete", collNo);
	}

	public int like(CollectionLike collectionLike) {
		return tpl.insert("collectionMapper.insertLike", collectionLike);
	}

	public int cancleLike(CollectionLike collectionLike) {
		return tpl.delete("collectionMapper.deleteLike", collectionLike);
	}
	
	public String collectionFindUsername(long collNo) {
		return tpl.selectOne("collectionMapper.findCollectionUsernameById", collNo);
	}

	public String collectionLikeFindUsername(long collNo, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("collNo", collNo);
		map.put("username", username);
		return tpl.selectOne("collectionMapper.findCollectionLikeUsernameById", map);
	}

	public List<Collection> movieCollectionList(long mNo) {
		return tpl.selectList("collectionMapper.findCollectionListBymNo", mNo);
	}

	public List<Collection> usernameCollectionList(String username) {
		return tpl.selectList("collectionMapper.findCollectionListByUsername", username);
	}

	public int increaselikecnt(long collNo) {
		return tpl.update("collectionMapper.increaselikecnt", collNo);
		
	}

	public int decreaselikecnt(long collNo) {
		return tpl.update("collectionMapper.decreaselikecnt", collNo);
		
	}
}
