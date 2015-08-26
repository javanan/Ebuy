package com.java1234.service;

import java.util.List;

import com.java1234.entity.Comment;
import com.java1234.entity.PageBean;

public interface CommentService {

	public List<Comment> findCommentList(Comment s_Comment,PageBean pageBean);
	
	public Long getCommentCount(Comment s_Comment);
	
	public void saveComment(Comment comment);
	
	public Comment getCommentById(int commentId);
	
	public void delete(Comment comment);
}
