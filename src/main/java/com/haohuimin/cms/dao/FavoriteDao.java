package com.haohuimin.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.springframework.web.bind.annotation.RequestParam;

import com.haohuimin.cms.domain.Favorite;


public interface FavoriteDao {

	List<Favorite> findFavorite(Favorite favorite);

	@Delete("delete from cms_favorite where id=#{id}")
	int deleteFavorite(@RequestParam("id")String id);

	void add(Favorite favorite);

}
