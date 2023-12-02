package com.acn.service;

import com.acn.bean.view.Comment;
import com.acn.bean.view.Post;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/01/21:24
 */
public interface CommentService {
    /**
     * 根据post的id查找评论
     */
    List<Comment> selectAllComments(int postId);

    /**
     * 评论总数
     */
    int commentsCount();

    /**
     * 查询所有评论数
     */
    List<Comment> selectCommentByPaging(int id, int page, int pageSize);

    /**
     * 添加评论
     */
    int addComment(com.acn.bean.Comment comment);

    /**
     * 查询一个帖子的所有评论数
     */
    int commentsCountByPost(int postId);
}
