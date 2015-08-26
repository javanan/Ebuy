package com.java1234.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java1234.dao.BaseDAO;
import com.java1234.entity.Notice;
import com.java1234.entity.PageBean;
import com.java1234.service.NoticeService;
import com.java1234.util.StringUtil;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{

	@Resource
	private BaseDAO<Notice> baseDAO;
	
	@Override
	public List<Notice> findNoticeList(Notice s_notice, PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Notice");
		if(s_notice!=null){
			if(StringUtil.isNotEmpty(s_notice.getTitle())){
				hql.append(" and title like ?");
				param.add("%"+s_notice.getTitle()+"%");
			}
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return null;
		}
	}

	@Override
	public Notice getNoticeById(int noticeId) {
		return baseDAO.get(Notice.class, noticeId);
	}

	@Override
	public Long getNoticeCount(Notice s_notice) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Notice");
		if(s_notice!=null){
			if(StringUtil.isNotEmpty(s_notice.getTitle())){
				hql.append(" and title like ?");
				param.add("%"+s_notice.getTitle()+"%");
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	@Override
	public void saveNotice(Notice notice) {
		// TODO Auto-generated method stub
		baseDAO.merge(notice);
	}

	@Override
	public void delete(Notice notice) {
		// TODO Auto-generated method stub
		baseDAO.delete(notice);
	}

}
