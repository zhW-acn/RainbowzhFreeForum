package com.acn.service.impl;

import com.acn.bean.Post;
import com.acn.dao.PostMapper;
import com.acn.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public List<Post> selectAllPosts() {
        return postMapper.selectAllPosts();
    }
}
