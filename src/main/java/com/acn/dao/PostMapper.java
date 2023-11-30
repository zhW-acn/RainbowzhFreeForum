package com.acn.dao;

import com.acn.bean.view.Post;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/28/0:00
 */
public interface PostMapper {
    // r
    List<Post> selectAllPosts();

    int postsCount();
}
