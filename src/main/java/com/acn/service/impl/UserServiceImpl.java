package com.acn.service.impl;

import com.acn.bean.User;
import com.acn.dao.UserMapper;
import com.acn.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
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
        return userMapper.selectUserById(id);
    }

    @Override
    public List<User> selectUserByName(String name) {
        return userMapper.selectUserByName(name);
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
    public List<User> selectAllUsersByPaging(int page, int limit) {

        return userMapper.selectAllUsersByPaging((page - 1) * limit, limit);
    }

    @Override
    public int updateUser(HashMap<String, Object> hashMap) {
        return userMapper.updateUser(hashMap);
    }

    @Override
    public int deleteUserById(int id) {
        return userMapper.deleteUserById(id);
    }
}
