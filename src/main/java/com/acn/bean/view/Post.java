package com.acn.bean.view;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 用于返回查询后的帖子
 * @Author: acn
 * @Date: 2023/11/28/12:59
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Post {
    private String userAvatar;
    private String userName;
    private String title;
    private String text;
    private String createtime;
}
