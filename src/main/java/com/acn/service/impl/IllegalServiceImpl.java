package com.acn.service.impl;

import com.acn.bean.Illegal;
import com.acn.dao.IllegalMapper;
import com.acn.service.IllegalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/24/15:45
 */
@Service
public class IllegalServiceImpl implements IllegalService {

    @Autowired
    IllegalMapper illegalMapper;

    @Override
    public List<Illegal> selectAllIllegals() {
        return illegalMapper.selectAllIllegals();
    }

    @Override
    public List<String> selectAllAvailableIllegals() {
        return illegalMapper.selectAllAvailableIllegals();
    }

    @Override
    public int addIllegal(Illegal illegal) {
        return illegalMapper.addIllegal(illegal);
    }

    @Override
    public int checkIllAvailable(String nword) {
        return illegalMapper.checkIllAvailable(nword);
    }

    @Override
    public int deleteIll(int id) {
        return illegalMapper.deleteIll(id);
    }

    @Override
    public int changeIllegalFlag(int id, int flag) {
        return illegalMapper.changeIllegalFlag(id, flag);
    }
}
