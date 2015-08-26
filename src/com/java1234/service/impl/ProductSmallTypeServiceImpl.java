package com.java1234.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.java1234.dao.BaseDAO;
import com.java1234.entity.PageBean;
import com.java1234.entity.ProductSmallType;
import com.java1234.service.ProductSmallTypeService;
import com.java1234.util.StringUtil;

@Service("productSmallTypeService")
public class ProductSmallTypeServiceImpl implements ProductSmallTypeService{

	@Resource
	private BaseDAO<ProductSmallType> baseDAO;
	
	@Override
	public List<ProductSmallType> findProductSmallTypeList(
			ProductSmallType s_productSmallType,PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from ProductSmallType");
		if(s_productSmallType!=null){
			if(StringUtil.isNotEmpty(s_productSmallType.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_productSmallType.getName()+"%");
			}
			if(s_productSmallType.getBigType()!=null && s_productSmallType.getBigType().getId()!=0){
				hql.append(" and bigType.id=?");
				param.add(s_productSmallType.getBigType().getId());
			}
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param);
		}
	}

	@Override
	public boolean existSmallTypeWithBigTypeId(int bigTypeId) {
		String hql="from ProductSmallType where bigType.id="+bigTypeId;
		if(baseDAO.find(hql).size()>0){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public Long getProductSmallTypeCount(ProductSmallType s_productSmallType) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from ProductSmallType");
		if(s_productSmallType!=null){
			if(StringUtil.isNotEmpty(s_productSmallType.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_productSmallType.getName()+"%");
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	@Override
	public void saveProductSmallType(ProductSmallType productSmallType) {
		// TODO Auto-generated method stub
		baseDAO.merge(productSmallType);
	}

	@Override
	public void delete(ProductSmallType productSmallType) {
		// TODO Auto-generated method stub
		baseDAO.delete(productSmallType);
	}

	@Override
	public ProductSmallType getProductSmallTypeById(int id) {
		return baseDAO.get(ProductSmallType.class, id);
	}

}
