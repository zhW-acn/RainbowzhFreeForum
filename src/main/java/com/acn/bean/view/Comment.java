package com.acn.bean.view;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 帖子的评论
 * @Author: acn
 * @Date: 2023/12/01/21:05
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {
    private int id;
    private String commentText;
    private int postId;
    private String userAvatar;
    private String username;
    private String createtime;
    private int flag;
}
