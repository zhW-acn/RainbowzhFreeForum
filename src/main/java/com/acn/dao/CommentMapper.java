package com.acn.dao;

import com.acn.bean.view.Comment;
import com.acn.bean.view.UserComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: 帖子评论dao层
 * @Author: acn
 * @Date: 2023/12/01/21:18
 */
public interface CommentMapper {
    // c
    int addComment(com.acn.bean.Comment comment);

    // r
    List<Comment> selectAllComments(@Param("id") int postId);

    // r by one post
    List<UserComment> selectAllCommentsByUserId(@Param("userId") int userId);

    // r return int
    int commentsCount();

    // r by post int
    int commentsCountByPost(@Param("postId") int postId);

    /**
     * 查询所有评论数
     */
    List<Comment> selectCommentsByPaging(@Param("id") int id, @Param("page") int page, @Param("pageSize") int pageSize);

    // u
    int changeFlag(@Param("postId") int postId,@Param("commentId") int commentId);
}
