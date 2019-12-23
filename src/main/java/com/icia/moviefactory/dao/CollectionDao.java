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
	//1
	public int add(Collection collection) {
		return tpl.insert("collectionMapper.insert", collection);
	}
	//2
	public Map read(long collNo, int startRowNum, int endRowNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("collNo", collNo);
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		
		return tpl.selectOne("collectionMapper.findByIdWithDetail", map);
	}
	//3
	public int addmovie(long mNo, long collNo) {
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("mNo", mNo);
		map.put("collNo", collNo);
		return tpl.insert("collectionMapper.insertDetail", map);
	}
	//4
	public int update(Collection collection) {
		return tpl.update("collectionMapper.update", collection);
	}
	//5
	public int deletemovie(long mNo, long collNo) {
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("mNo", mNo);
		map.put("collNo", collNo);
		return tpl.delete("collectionMapper.deleteDetail", map);
	}
	//6
	public int delete(long collNo) {
		return tpl.delete("collectionMapper.delete", collNo);
	}
	//7
	public int like(CollectionLike collectionLike) {
		return tpl.insert("collectionMapper.insertLike", collectionLike);
	}
	//8
	public int cancleLike(CollectionLike collectionLike) {
		return tpl.delete("collectionMapper.deleteLike", collectionLike);
	}
	//9
	public String collectionFindUsername(long collNo) {
		return tpl.selectOne("collectionMapper.findCollectionUsernameById", collNo);
	}
	//10
	public String collectionLikeFindUsername(long collNo, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("collNo", collNo);
		map.put("username", username);
		return tpl.selectOne("collectionMapper.findCollectionLikeUsernameById", map);
	}
	//11
	public List<Collection> movieCollectionList(long mNo, int startRowNum, int endRowNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mNo", mNo);
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		
		return tpl.selectList("collectionMapper.findCollectionListBymNo", map);
	}
	//12
	public List<Collection> usernameCollectionList(String username, int startRowNum, int endRowNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		return tpl.selectList("collectionMapper.findCollectionListByUsername", map);
	}
	//13
	public int increaselikecnt(long collNo) {
		return tpl.update("collectionMapper.increaselikecnt", collNo);
		
	}
	//14
	public int decreaselikecnt(long collNo) {
		return tpl.update("collectionMapper.decreaselikecnt", collNo);
		
	}
	public int findMovieCollectionCount(long mNo) {
		return tpl.selectOne("collectionMapper.findMovieCollectionCount", mNo);
	}
	public int findUsernameCollectionCount(String username) {
		return tpl.selectOne("collectionMapper.findUsernameCollectionCount", username);
	}
	public int findcollNoCollectionDetailCount(long collNo) {
		return tpl.selectOne("collectionMapper.findcollNoCollectionDetailCount", collNo);
	}
	
	public Map read2(long collNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("collNo", collNo);
		return tpl.selectOne("collectionMapper.findByIdWithDetail2", map);
	}
	public Collection read3(long collNo) {
		return tpl.selectOne("collectionMapper.findCollectionById", collNo);
	}
	
}
