package com.acn.utils;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.*;

/**
 * @Description: 用户头像和帖子处理
 * @Author: acn
 * @Date: 2023/11/29/12:03
 */
public class FileUpload {
    public static final String PATH = "F:\\rainboWzh\\users\\";

    /**
     * 创建文件夹，返回avatar文件夹目录
     */
    public static String createFolder(String username) {
        String userPath = PATH + username;
        File file = new File(userPath);
        // 是否存在，不存在创建用户文件夹和子文件夹【avatar&post】
        if (!file.exists()) {
            // 创建父文件夹
            if (file.mkdirs()) {
                System.out.println(username + "文件夹创建成功");
                new File(userPath + File.separator + "avatar").mkdir();
                System.out.println(username + "avatar子文件夹创建成功");
                new File(userPath + File.separator + "post").mkdir();
                System.out.println(username + "post子文件夹创建成功");

            } else {
                System.out.println("文件夹创建失败");
                return null;
            }
        }
        return userPath + File.separator + "avatar";
    }

    /**
     * 更新&上传头像
     *
     * @param username
     * @param avatar
     */
    public static void avatarUpload(String username, CommonsMultipartFile avatar) {
        // 拿到路径
        String avatarPath = createFolder(username);

        // 创建输出流，获取输入流
        try (OutputStream os = new FileOutputStream(avatarPath + File.separator + avatar.getOriginalFilename());
             InputStream is = avatar.getInputStream()) {

            byte[] buffer = new byte[2048];
            int length;
            // 读写
            while ((length = is.read(buffer)) != -1) {
                os.write(buffer, 0, length);
            }

        } catch (IOException e) {
            throw new RuntimeException("头像更新&上传失败" + e);
        }
    }
}
