package com.icia.moviefactory.service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;

@Service
public class CollectionService {
	@Autowired
	private CollectionDao collectionDao;
	
	public Collection add(Collection collection) {
		collectionDao.add(collection);
		return collection;
	}

}
