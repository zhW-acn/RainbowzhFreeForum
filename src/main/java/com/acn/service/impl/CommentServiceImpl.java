package com.acn.service.impl;

import com.acn.bean.view.UserComment;
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
    public List<com.acn.bean.view.Comment> adminSelectAllComments(int postId) {
        return commentMapper.adminSelectAllComments(postId);
    }

    @Override
    public List<com.acn.bean.view.Comment> selectUnreadComment(int id) {
        return commentMapper.selectUnreadComment(id);
    }

    @Override
    public List<com.acn.bean.view.Comment> selectComment(int id) {
        return commentMapper.selectComment(id);
    }

    @Override
    public List<UserComment> selectAllCommentsByUserId(int userId) {
        return commentMapper.selectAllCommentsByUserId(userId);
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

    @Override
    public int changeFlag(int flag, int postId, int commentId) {
        return commentMapper.changeFlag(flag, postId, commentId);
    }
}
