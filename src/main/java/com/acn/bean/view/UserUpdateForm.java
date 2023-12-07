package com.acn.bean.view;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Description: 修改用户的类
 * @Author: acn
 * @Date: 2023/12/06/21:49
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserUpdateForm {
    private CommonsMultipartFile avatar;
    private String username;
    private String oldPassword;
    private String newPassword;
    private String birthday;
}
