package com.acn.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 帖子
 * @Author: acn
 * @Date: 2023/11/27/23:57
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Post {
    private int id;
    private String title;
    private String text;
    private int userId;
    private String createtime;
    private int flag;

    public Post(String title, String content, int userId, String createtime, int flag) {
        this.title = title;
        this.text = content;
        this.userId = userId;
        this.createtime =createtime;
        this.flag = flag;
    }
}
