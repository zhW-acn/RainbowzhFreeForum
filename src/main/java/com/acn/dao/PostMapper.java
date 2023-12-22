package com.acn.dao;

import com.acn.bean.view.Post;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

/**
 * @Description: 帖子dao层
 * @Author: acn
 * @Date: 2023/11/28/0:00
 */
public interface PostMapper {

    int addPost(com.acn.bean.Post post);

    // r return list by userId
    List<Post> selectAllPostsByUserId(@Param("userId") int userId);

    List<Post> selectAllPosts();

    // r return int
    int postsCount();

    // r by 1
    int postsCountByUser(int userId);

    int selectLastPost(int userId);

    // r by id
    Post selectPostById(@Param("id") int id);

    // r by text
    List<Post> selectPostByLike(String text);

    // r by paging
    List<Post> selectPostByPaging(@Param("page") int page, @Param("pageSize") int pageSize);

    // d
    int ADMIN_deletePostById(@Param("postId")int postId);

    // d
    int changeFlag(@Param("postId")int postId);


    List<Post> selectAllAnnouncements();

    int updatePost(HashMap<String, Object> hashMap);
}
