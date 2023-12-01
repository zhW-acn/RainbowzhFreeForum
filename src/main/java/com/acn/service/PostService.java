package com.acn.service;

import com.acn.bean.view.Post;
import javafx.geometry.Pos;

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
     * 通过id查询帖子
     */
    Post selectPostById(int id);

    /**
     * 返回帖子总数
     */
    int postsCount();

}
