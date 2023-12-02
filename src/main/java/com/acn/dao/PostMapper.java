package com.acn.dao;

import com.acn.bean.view.Post;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: 帖子dao层
 * @Author: acn
 * @Date: 2023/11/28/0:00
 */
public interface PostMapper {
    // r return list by userId
    List<Post> selectAllPosts(@Param("userId") int userId);

    // r return int
    int postsCount();

    // r by 1
    int postsCountByUser(int userId);

    // r by id
    Post selectPostById(@Param("id") int id);

    // r by paging

    /**
     * page：当前页数
     * pageShow：分页数
     */
    List<Post> selectPostByPaging(@Param("page") int page, @Param("pageSize") int pageSize);
}
