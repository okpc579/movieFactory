package com.icia.moviefactory.dao;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class CollectionDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public int add(Collection collection) {
		return tpl.insert("collectionMapper.insert", collection);
	}

}
