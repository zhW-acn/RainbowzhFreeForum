package com.acn.service.impl;

import com.acn.bean.User;
import com.acn.dao.UserMapper;
import com.acn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/27/20:41
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public int insertUser(User user) {
        return userMapper.insertUser(user);
    }

    @Override
    public User selectUserByCond(HashMap<String, Object> hashMap) {
        return userMapper.selectUserByCond(hashMap);
    }

    @Override
    public User selectUserById(int id) {
        return null;
    }

    @Override
    public int isExist(String username) {
        return userMapper.isExist(username);
    }

    @Override
    public List<User> selectAllUsers() {
        return userMapper.selectAllUsers();
    }

    @Override
    public int updateUser(User user) {
        return 0;
    }

    @Override
    public int deleteUserById(int id) {
        return 0;
    }
}
