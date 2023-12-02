package com.acn.service.impl;

import com.acn.bean.Comment;
import com.acn.dao.CommentMapper;
import com.acn.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/01/21:24
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentMapper commentMapper;

    @Override
    public List<com.acn.bean.view.Comment> selectAllComments(int postId) {
        return commentMapper.selectAllComments(postId);
    }

    @Override
    public int commentsCount() {
        return commentMapper.commentsCount();
    }

    @Override
    public List<com.acn.bean.view.Comment> selectCommentByPaging(int id, int page, int pageSize) {
        return commentMapper.selectCommentsByPaging(id, page, pageSize);
    }

    @Override
    public int addComment(com.acn.bean.Comment comment) {
        return commentMapper.addComment(comment);
    }

    @Override
    public int commentsCountByPost(int postId) {
        return commentMapper.commentsCountByPost(postId);
    }
}
