package com.acn.dao;

import com.acn.bean.Illegal;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/24/16:01
 */
public interface IllegalMapper {

    List<Illegal> selectAllIllegals();

    int changeIllegalFlag(@Param("id") int id, @Param("flag") int flag);

    int addIllegal(Illegal illegal);

    int checkIllAvailable(@Param("nword")String nword);

    int deleteIll(@Param("id") int id);

    List<String> selectAllAvailableIllegals();
}
