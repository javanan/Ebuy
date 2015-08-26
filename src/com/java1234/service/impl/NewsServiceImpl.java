package com.java1234.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java1234.dao.BaseDAO;
import com.java1234.entity.News;
import com.java1234.entity.Notice;
import com.java1234.entity.PageBean;
import com.java1234.service.NewsService;
import com.java1234.util.StringUtil;

@Service("newsService")
public class NewsServiceImpl implements NewsService{

	@Resource
	private BaseDAO<News> baseDAO;
	
	@Override
	public List<News> findNewsList(News s_news, PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from News");
		if(s_news!=null){
			if(StringUtil.isNotEmpty(s_news.getTitle())){
				hql.append(" and title like ?");
				param.add("%"+s_news.getTitle()+"%");
			}
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return null;
		}
	}

	@Override
	public News getNewsById(int newsId) {
		return baseDAO.get(News.class, newsId);
	}

	@Override
	public Long getNewsCount(News s_news) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from News");
		if(s_news!=null){
			if(StringUtil.isNotEmpty(s_news.getTitle())){
				hql.append(" and title like ?");
				param.add("%"+s_news.getTitle()+"%");
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	@Override
	public void saveNews(News news) {
		baseDAO.merge(news);
	}

	@Override
	public void delete(News news) {
		baseDAO.delete(news);
	}

}
