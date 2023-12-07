package com.acn.service;

import com.acn.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/27/20:41
 */
public interface UserService {

    /**
     * 增
     */
    int insertUser(User user);

    /**
     * 不定参数
     */
    User selectUserByCond(HashMap<String,Object> hashMap);

    /**
     * 查询 by id
     */
    User selectUserById(int id);

    /**
     * 模糊查找用户
     */
    List<User> selectUserByName(@Param("name")String name);

    /**
     * 是否存在重名
     */
    int isExist(String username);

    /**
     * 查询 所有User
     */
    List<User> selectAllUsers();

    /**
     * 更新
     */
    int updateUser(HashMap<String,Object> hashMap);

    /**
     * 删除 by id
     */
    int deleteUserById(int id);

}
