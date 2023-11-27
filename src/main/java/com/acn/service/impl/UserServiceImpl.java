package com.acn.service.impl;

import com.acn.bean.User;
import com.acn.dao.UserMapper;
import com.acn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        return 0;
    }

    @Override
    public User selectUserByName(String name) {
        return null;
    }

    @Override
    public User selectUserById(int id) {
        return null;
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
