package com.acn.bean;

import com.acn.enums.UserRole;
import lombok.Data;


/**
 * @Description: 用户类
 * @Author: acn
 * @Date: 2023/11/25/11:39
 */
@Data
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
     * 用户身份，默认为normal
     */
    private UserRole role = UserRole.NORMAL;

    /**
     * 封禁时间
     */
    private String banTime;

    /**
     * 访问次数
     */
    private int visits;

    public static void main(String[] args) {
        User user = new User();
        System.out.println(user.role);
    }
}
