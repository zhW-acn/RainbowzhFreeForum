package com.acn.constant;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/27/3:31
 */
public class Constant {
    /**
     * 盐
     */
    public static final String SALT = "114514NullPoint";

    /**
     * 普通用户
     */
    public static final int USER_NORMAL = 0;

    /**
     * 管理员
     */
    public static final int USER_ADMIN = -1;

    /**
     * 已注销用户
     */
    public static final int USER_Unregistered = -2;

    /**
     * 封禁用户
     */
    public static final int USER_Ban = -3;


    /**
     * 可见帖子
     */
    public static final int POST_NORMAL = 1;

    /**
     * 公告
     */
    public static final int POST_ANNOUNCEMENT = -1;

    /**
     * 封禁帖子
     */
    public static final int POST_BAN = 0;


    /**
     * 可见评论
     */
    public static final int COMMENT_NORMAL = 1;

    /**
     * 封禁评论
     */
    public static final int COMMENT_BAN = 0;


    /**
     * 启用的违禁词
     */
    public static final int NWORD_ON = 1;

    /**
     * 未启用的违禁词
     */
    public static final int NWORD_OFF = 0;


}
