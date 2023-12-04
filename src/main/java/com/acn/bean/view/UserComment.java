package com.acn.bean.view;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 用户界面的评论
 * @Author: acn
 * @Date: 2023/12/04/18:57
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserComment {
    private int postId;
    private int commentId;
    private String userAvatar;
    private String title;
    private String comment_text;
    private String createTime;
}
