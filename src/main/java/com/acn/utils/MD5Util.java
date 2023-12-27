package com.acn.utils;

import com.acn.constant.Constant;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/12/27/3:14
 */
public class MD5Util {
    public static String digest(String text) {
        String saltTest = text + Constant.SALT;
        MessageDigest md5 = null;
        try {
            md5 = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        byte[] digest = md5.digest(saltTest.getBytes());
        // 换成更友好的字符而不是乱码
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encode = encoder.encode(digest);
        return new String(encode);
    }

    public static void main(String[] args) {
        System.out.println(digest("mgsd"));
    }
}
