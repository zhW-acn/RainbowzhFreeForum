package com.acn.bean;

import lombok.AllArgsConstructor;
import lombok.Data;


/**
 * @Description: 用户类
 * @Author: acn
 * @Date: 2023/11/25/11:39
 */
@Data
@AllArgsConstructor
public class User {
    /**
     * 用户id
     */
    private int id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 用户密码
     */
    private String password;

    /**
     * 用户生日
     */
    private String birthday;

    /**
     * 封禁时间：
     * -1：admin
     * 0：normal
     * >0：ban
     */
    private String banTime;

    /**
     * 访问次数
     */
    private int visits;


}
