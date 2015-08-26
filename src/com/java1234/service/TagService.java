package com.java1234.service;

import java.util.List;

import com.java1234.entity.PageBean;
import com.java1234.entity.Tag;

public interface TagService {

	public List<Tag> findTagList(Tag s_tag,PageBean pageBean);
	
	public Long getTagCount(Tag s_tag);
	
	public void saveTag(Tag tag);
	
	public void delete(Tag tag);
	
	public Tag getTagById(int tagId);
}
