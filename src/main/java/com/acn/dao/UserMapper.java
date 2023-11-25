package com.acn.dao;

import com.acn.bean.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description: UserDao层
 * @Author: acn
 * @Date: 2023/11/25/13:52
 */

public interface UserMapper {

    /**
     * 增
     */
    int insertUser(User user);

    /**
     * 查询 by name
     */
    User selectUserByName(String name);

    /**
     * 查询 by id
     */
    User selectUserById(int id);

    /**
     * 查询 所有User
     */
    List<User> selectAllUsers();

    /**
     * 更新
     */
    int updateUser(User user);

    /**
     * 删除 by id
     */
    int deleteUserById(int id);

}
