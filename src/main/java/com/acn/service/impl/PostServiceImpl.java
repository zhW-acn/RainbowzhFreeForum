package com.acn.service.impl;

import com.acn.bean.view.Post;
import com.acn.dao.PostMapper;
import com.acn.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/28/0:03
 */
@Service
public class PostServiceImpl implements PostService {
    @Autowired
    PostMapper postMapper;

    @Override
    public int addPost(com.acn.bean.Post post) {
        return postMapper.addPost(post);
    }

    @Override
    public List<Post> selectAllPostsByUserId(int userid) {
        return postMapper.selectAllPostsByUserId(userid);
    }

    @Override
    public int selectLastPost(int userid) {
        return postMapper.selectLastPost(userid);
    }

    @Override
    public List<Post> selectAllAnnouncements() {
        return postMapper.selectAllAnnouncements();
    }

    @Override
    public List<Post> selectAllVisiblePosts() {
        return postMapper.selectAllVisiblePosts();
    }

    @Override
    public List<Post> selectAllPost(int page, int pageSize) {
        return postMapper.selectAllPost((page - 1) * pageSize, pageSize);
    }


    @Override
    public List<Post> selectPostByPaging(int page, int pageSize) {
        return postMapper.selectPostByPaging(page, pageSize);
    }

    @Override
    public Post selectPostById(int id) {
        return postMapper.selectPostById(id);
    }

    @Override
    public List<Post> selectPostByLike(String text) {
        return postMapper.selectPostByLike(text);
    }

    @Override
    public int postsCount() {
        return postMapper.postsCount();
    }

    @Override
    public int postsCountByUser(int userId) {
        return postMapper.postsCountByUser(userId);
    }

    @Override
    public int deletePostById(int postId) {
        return postMapper.ADMIN_deletePostById(postId);
    }

    @Override
    public int changeFlag(int postId,int flag) {
        return postMapper.changeFlag(postId,flag);
    }

    @Override
    public int updatePost(HashMap<String, Object> hashMap) {
        return postMapper.updatePost(hashMap);
    }
}
