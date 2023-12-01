package com.acn.dao;

import com.acn.bean.view.Comment;
import com.acn.bean.view.Post;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: 帖子评论dao层
 * @Author: acn
 * @Date: 2023/12/01/21:18
 */
public interface CommentMapper {

    // r
    List<Comment> selectAllComments(@Param("id")int postId);

    // r return int
    int commentsCount();

    /**
     * 查询所有评论数
     */
    List<Comment> selectCommentsByPaging(@Param("id")int id,@Param("page")int page, @Param("pageSize")int pageSize);
}
