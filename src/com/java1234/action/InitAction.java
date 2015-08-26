package com.java1234.action;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.java1234.entity.News;
import com.java1234.entity.Notice;
import com.java1234.entity.PageBean;
import com.java1234.entity.Product;
import com.java1234.entity.ProductBigType;
import com.java1234.entity.Tag;
import com.java1234.service.NewsService;
import com.java1234.service.NoticeService;
import com.java1234.service.ProductBigTypeService;
import com.java1234.service.ProductService;
import com.java1234.service.TagService;

@Component
public class InitAction implements ServletContextListener,ApplicationContextAware{

	private static ApplicationContext applicationContext;
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		// TODO Auto-generated method stub
		ServletContext application=servletContextEvent.getServletContext();
		ProductBigTypeService productBigTypeService=(ProductBigTypeService)applicationContext.getBean("productBigTypeService");
		List<ProductBigType> bigTypeList=productBigTypeService.findAllBigTypeList();
		application.setAttribute("bigTypeList", bigTypeList);
		
		TagService tagService=(TagService)applicationContext.getBean("tagService");
		List<Tag> tagList=tagService.findTagList(null,null);
		application.setAttribute("tagList", tagList);
		
		NoticeService noticeService=(NoticeService)applicationContext.getBean("noticeService");
		List<Notice> noticeList=noticeService.findNoticeList(null, new PageBean(1,7));
		application.setAttribute("noticeList", noticeList);
		
		NewsService newsService=(NewsService)applicationContext.getBean("newsService");
		List<News> newsList=newsService.findNewsList(null, new PageBean(1,7));
		application.setAttribute("newsList", newsList);
		
		ProductService productService=(ProductService)applicationContext.getBean("productService");
		Product s_product=new Product();
		s_product.setSpecialPrice(1);
		List<Product> specialPriceProductList=productService.findProductList(s_product, new PageBean(1,8));
		application.setAttribute("specialPriceProductList", specialPriceProductList);
		
		s_product=new Product();
		s_product.setHot(1);
		List<Product> hotProductList=productService.findProductList(s_product, new PageBean(1,6));
		application.setAttribute("hotProductList", hotProductList);
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		// TODO Auto-generated method stub
		this.applicationContext=applicationContext;
	}

}
