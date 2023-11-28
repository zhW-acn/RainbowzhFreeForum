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
    private String text;
    private int userId;
    private String createtime;
    private int flag;
    private String tag;
}
