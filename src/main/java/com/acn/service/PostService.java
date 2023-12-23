package com.acn.service;

import com.acn.bean.view.Post;
import javafx.geometry.Pos;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/28/0:02
 */

public interface  PostService {

    // 发帖
    int addPost(com.acn.bean.Post post);


    /**
     * 查询一个用户的所有帖子
     */
    List<Post> selectAllPostsByUserId(int userId);

    /**
     * 返回最后一次发帖的id
     */
    int selectLastPost(int userid);

    /**
     * 查询所有公告 flag == -1
     */
    List<Post> selectAllAnnouncements();
    /**
     * 查询所有帖子 flag == 1
     */
    List<Post> selectAllVisiblePosts();

    /**
     * 根据flag查询
     */
    List<Post> selectAllPost(int page,int pageSize);

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
     * 管理员模糊查询
     */
    List<Post> adminSelectPostByLike(String text);

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

    /**
     * 改变帖子的权限
     */
    int changeFlag(int postId,int flag);

    /**
     * 修改帖子的内容
     */
    int updatePost(HashMap<String,Object> hashMap);
}
