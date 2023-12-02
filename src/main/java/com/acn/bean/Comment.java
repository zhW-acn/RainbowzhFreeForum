package com.acn.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/02/13:15
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {
    private String commentText;
    private int postId;
    private int userId;
    private String createtime;
    private int flag;

}
