package com.acn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/29/21:22
 */
@Controller
public class adminController {

    @GetMapping("/admin")
    public String toAdmin(){
        return "admin";
    }
}
