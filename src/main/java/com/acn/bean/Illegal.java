package com.acn.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: 违禁词
 * @Author: acn
 * @Date: 2023/12/24/15:46
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Illegal {
    int id;
    String nword;
    int flag;

    public Illegal(String nword, int flag) {
        this.nword = nword;
        this.flag = flag;
    }
}
