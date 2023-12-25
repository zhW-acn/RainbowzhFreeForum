package com.acn.controller;

import com.acn.bean.Illegal;
import com.acn.bean.User;
import com.acn.bean.view.Comment;
import com.acn.bean.view.Post;
import com.acn.service.CommentService;
import com.acn.service.IllegalService;
import com.acn.service.PostService;
import com.acn.service.UserService;
import com.acn.utils.JSONConstructor;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

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

    @Autowired
    CommentService commentService;

    @Autowired
    IllegalService illegalService;

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
        return new JSONConstructor(0, "公告", posts).toString();
    }

    @GetMapping("/admin/user")
    public String toUser() {
        return "admin/user";
    }

    @GetMapping("/admin/getusers")
    @ResponseBody
    public String getAllUser(@RequestParam("page") int page, @RequestParam("limit") int limit,
                             @RequestParam(value = "username", required = false) String username) {
        // 这个username不是必须的，当客户端发起搜索请求时才会携带username参数


        JSONObject jsonObject = new JSONObject();
        // 没有查询
        if (username == null) {
            List<User> users = userService.selectAllUsersByPaging(page, limit);
            jsonObject.put("count", userService.selectAllUsers().size());
            jsonObject.put("code", 0);
            jsonObject.put("msg", "所有用户");
            jsonObject.put("data", users);
            return jsonObject.toJSONString();
        } else {// 存在username，查询
            List<User> users = userService.selectUserByName(username);
            jsonObject.put("count", userService.selectAllUsers().size());
            jsonObject.put("code", 0);
            jsonObject.put("msg", "");
            jsonObject.put("data", users);
            return jsonObject.toJSONString();
        }
    }

    @GetMapping("/admin/post")
    public String toPost() {
        return "admin/post";
    }

    @GetMapping("/admin/getposts")
    @ResponseBody
    public String getAllPosts(@RequestParam("page") int page, @RequestParam("limit") int limit,
                              @RequestParam(value = "search", required = false) String search) {
        JSONObject jsonObject = new JSONObject();
        List<Post> posts = postService.selectAllPost(page, limit);
        int size = posts.size();
        jsonObject.put("count", size);
        jsonObject.put("code", 0);
        jsonObject.put("msg", "帖子");
        if (search == null) {
            jsonObject.put("data", posts);
        } else {
            List<Post> postsLike = postService.adminSelectPostByLike(search);
            jsonObject.put("data", postsLike);
        }
        return jsonObject.toJSONString();
    }


    @GetMapping("/admin/comment/{id}")
    public ModelAndView toComment(ModelAndView modelAndView, @PathVariable String id) {
        modelAndView.addObject("postId", id);
        modelAndView.setViewName("admin/comment");
        return modelAndView;
    }

    @GetMapping("/admin/getcomment/{postId}")
    @ResponseBody
    public String getComment(@PathVariable int postId) {
        List<Comment> comments = commentService.adminSelectAllComments(postId);

        return new JSONConstructor(0, "", comments).toString();
    }

    @PostMapping("/admin/changecomment")
    @ResponseBody
    public String changeComment(@RequestParam("flag") int flag, @RequestParam("postId") int postId,
                                @RequestParam("commentId") int commentId) {
        int i = commentService.changeFlag(flag, postId, commentId);
        return i == 1 ? "success" : "fail";
    }

    @PostMapping("/admin/changepost")
    @ResponseBody
    public String changePost(@RequestParam("flag") int flag, @RequestParam("id") int postId) {
        int i = postService.changeFlag(postId, flag);
        return i == 1 ? "success" : "fail";
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
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("id", id);
        hashMap.put("banTime", role);
        int i = userService.updateUser(hashMap);
        return i == 1 ? "success" : "fail";
    }

    @GetMapping("/admin/Illegal")
    public String toIllegal() {
        return "admin/Illegal";
    }

    @GetMapping("/admin/getIllegal")
    @ResponseBody
    public String getIllegal() {
        List<Illegal> illegals = illegalService.selectAllIllegals();
        return new JSONConstructor(0, "", illegals).toString();
    }

    @PostMapping("/admin/changeIllegal")
    @ResponseBody
    public String changeIllegal(@RequestParam("id") int id, @RequestParam("flag") int flag) {
        int i = illegalService.changeIllegalFlag(id, flag);
        return i == 1 ? "success" : "fail";
    }

    @PostMapping("/admin/addIllegal")
    @ResponseBody
    public String addIllegal(@RequestParam("nword") String nword) {
        Illegal illegal = new Illegal(nword, 1);
        int i = illegalService.addIllegal(illegal);
        return i == 1 ? "success" : "fail";
    }

    @PostMapping("/admin/checkIllAvailable")
    @ResponseBody
    public String checkIllAvailable(@RequestParam("nword") String nword) {
        int i = illegalService.checkIllAvailable(nword);
        return i == 0 ? "available" : "unavailable";
    }

    @PostMapping("/admin/deleteIll")
    @ResponseBody
    public String deleteIll(@RequestParam("id") int id) {
        int i = illegalService.deleteIll(id);
        return i == 1 ? "success" : "fail";
    }

    @GetMapping("/admin/IllegalPost")
    public String toIllegalPost() {
        return "admin/IllegalPost";
    }

    @GetMapping("/admin/getIllegalPostTable")
    @ResponseBody
    public String getIllegalPost() {
        List<Post> posts = postService.selectAllVisiblePosts();
        List<String> illegals = illegalService.selectAllAvailableIllegals();
        Set<String> illegalSet = new HashSet<>(illegals);

        List<Post> illegalPosts =
                posts.parallelStream().filter(
                        p -> illegalSet.stream().anyMatch(
                                illegal -> p.getText().contains(illegal)
                        )
                ).collect(Collectors.toList());

        return new JSONConstructor(0, "", illegalPosts).toString();
    }


}
