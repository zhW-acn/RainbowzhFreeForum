package com.acn.service;

import com.acn.bean.view.Post;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/28/0:02
 */

public interface PostService {
    List<Post> selectAllPosts();
}
