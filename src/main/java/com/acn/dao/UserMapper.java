package com.acn.dao;

import com.acn.bean.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
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
     * r by id
     */
    User selectUserById(@Param("id")int id);

    /**
     * r by name
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
     * 普通删除 by id
     */
    int deleteUserById(@Param("id") int id);

    /**
     * 分页查找
     */
    List<User> selectAllUsersByPaging(@Param("pageSize") int page, @Param("pageIndex") int limit);
}
