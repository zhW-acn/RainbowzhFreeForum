package com.acn.utils;

import com.alibaba.fastjson.JSONObject;

/**
 * @Description: 面向Layui数据表格的JSON格式工具类
 * @author: acn
 * @date: 2023/11/07/16:16
 */
public class JSONConstructor {
    Object code;
    String msg;
    String data;

    public static String o2J(Object o) {
        return JSONObject.toJSONString(o);
    }

    public JSONConstructor(Object code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = o2J(data);
    }

    @Override
    public String toString() {
        return "{" +
                "\"code\":" + code +
                ", \"msg\":\"" + msg + '\"' +
                ", \"data\":" + data +
                '}';
    }
}
