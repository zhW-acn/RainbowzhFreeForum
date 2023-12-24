package com.acn.service;

import com.acn.bean.Illegal;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/24/15:44
 */
public interface IllegalService {

    /**
     * r
     */
    List<Illegal> selectAllIllegals();

    List<String> selectAllAvailableIllegals();

    int addIllegal(Illegal illegal);

    /**
     * 是否存在重复违禁词
     */
    int checkIllAvailable(String nword);

    int deleteIll(int id);

    /**
     * 修改违禁词状态
     */
    int changeIllegalFlag(int id,int flag);
}
