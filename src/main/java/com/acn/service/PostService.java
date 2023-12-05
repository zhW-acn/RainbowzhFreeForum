package com.acn.service;

import com.acn.bean.view.Post;
import javafx.geometry.Pos;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/28/0:02
 */

public interface PostService {
    /**
     * 查询一个用户的所有帖子
     */
    List<Post> selectAllPosts(int userId);

    /**
     * 分页查询所有帖子
     */
    List<Post> selectPostByPaging(int page, int pageSize);

    /**
     * 通过id查询帖子
     */
    Post selectPostById(int id);

    /**
     * 模糊查询帖子标题和正文
     */
    List<Post> selectPostByLike(String text);

    /**
     * 返回帖子总数
     */
    int postsCount();

    /**
     * 返回用户的发帖数
     */
    int postsCountByUser(int userId);

    /**
     * 通过Id删除帖子
     */
    int deletePostById(int postId);

    int changeFlag(int postId);
}
