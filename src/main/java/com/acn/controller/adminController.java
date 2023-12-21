package com.acn.controller;

import com.acn.bean.User;
import com.acn.bean.view.Post;
import com.acn.service.PostService;
import com.acn.service.UserService;
import com.acn.utils.JSONConstructor;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Description:
 * @Author: acn
 * @Date: 2023/11/29/21:22
 */
@Controller
public class adminController {

    @Autowired
    UserService userService;

    @Autowired
    PostService postService;

    @GetMapping("/admin")
    public String toAdmin() {
        return "admin/admin";
    }

    @GetMapping("/admin/announcement")
    public String toAnnouncement() {
        return "admin/announcement";
    }

    @GetMapping("/getannouncement")
    @ResponseBody
    public String getAnnouncement() {
        List<Post> posts = postService.selectAllAnnouncements();
        System.out.println(new JSONConstructor(0, "公告", posts));
        return new JSONConstructor(0, "公告", posts).toString();
    }

    @GetMapping("/admin/user")
    public String toUser() {
        return "admin/user";
    }

    @GetMapping("/admin/getusers")
    @ResponseBody
    public String getAllUser(@RequestParam("page") int page, @RequestParam("limit") int limit) {
        List<User> users = userService.selectAllUsersByPaging(page, limit);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("count", userService.selectAllUsers().size());
        jsonObject.put("code", 0);
        jsonObject.put("msg", "所有用户");
        jsonObject.put("data", users);
        return jsonObject.toJSONString();
    }

    @GetMapping("/admin/post")
    public String toPost() {
        return "admin/post";
    }

    @PostMapping("admin/addAnnAjax")
    @ResponseBody
    public String addAnn(@RequestParam("title") String title, @RequestParam("text") String text, HttpSession session) {
        User user = (User) session.getAttribute("user");
        com.acn.bean.Post post = new com.acn.bean.Post(title, text, user.getId(), new SimpleDateFormat("yyyy-MM-dd " +
                "HH:mm:ss").format(new Date()),
                -1);
        int i = postService.addPost(post);
        return i == 1 ? "success" : "fail";
    }

    @PostMapping("/admin/updAnnAjax")
    @ResponseBody
    public String updAnn(@RequestParam("field") String filed, @RequestParam("value") String value,
                         @RequestParam("postId") int postId) {
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("id", postId);
        hashMap.put(filed, value);
        int i = postService.updatePost(hashMap);
        return i == 1 ? "success" : "fail";
    }

    @PostMapping("/admin/deleteAnno")
    @ResponseBody
    public String delAnno(@RequestParam("id") int postId) {
        int i = postService.deletePostById(postId);
        return i == 1 ? "success" : "fail";
    }

    @PostMapping("/admin/role")
    @ResponseBody
    public String updRole(@RequestParam("id") int id, @RequestParam("role") int role) {
        System.out.println(id + "------" + role);
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("id", id);
        hashMap.put("banTime", role);
        int i = userService.updateUser(hashMap);
        return i == 1 ? "success" : "fail";
    }
}
