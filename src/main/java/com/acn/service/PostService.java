package com.acn.service;

import com.acn.bean.view.Post;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/28/0:02
 */

public interface PostService {
    /**
     * 查询所有帖子
     */
    List<Post> selectAllPosts();

    /**
     * 查询所有帖子数
     */
    List<Post> selectPostByPaging(int page, int pageSize);

    /**
     * 返回帖子总数
     */
    int postsCount();

}
