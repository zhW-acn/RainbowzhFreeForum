package com.acn.dao;

import com.acn.bean.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
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
     * 不定参数
     */
    User selectUserByCond(HashMap<String,Object> hashMap);

    /**
     * 查询 by id
     */
    User selectUserById(int id);

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
    int updateUser(User user);

    /**
     * 删除 by id
     */
    int deleteUserById(int id);

}
