package com.haohuimin.cms.service;

import com.github.pagehelper.PageInfo;
import com.haohuimin.cms.domain.Favorite;

public interface FavoriteService {

	PageInfo<Favorite> findFavorite(Favorite favorite, Integer pageNum, Integer pageSize);

	boolean deleteFavorite(String id);

	void add(Favorite favorite);

}
