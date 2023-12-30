package com.acn.controller;

import com.acn.bean.User;
import com.acn.bean.view.Comment;
import com.acn.bean.view.Post;
import com.acn.bean.view.UserComment;
import com.acn.constant.Constant;
import com.acn.service.CommentService;
import com.acn.service.PostService;
import com.acn.service.UserService;
import com.acn.utils.JSONConstructor;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Description: 用户主页
 * @Author: acn
 * @Date: 2023/12/01/10:42
 */
@Controller
@RequestMapping("/user/{userId}")
public class UserPageController {
    @Autowired
    PostService postService;

    @Autowired
    UserService userService;

    @Autowired
    CommentService commentService;

    @GetMapping("")
    public String toUserPage(@PathVariable("userId") int userid, Model model, HttpServletRequest request) {
        int postCount = postService.postsCountByUser(userid);
        model.addAttribute("postCount", postCount);

        // 给前端判断是否是自己的主页
        User userOwner = userService.selectUserById(userid);
        request.setAttribute("userOwner", userOwner);
        return "/user/userHomePage";
    }


    @GetMapping("/ajax")
    @ResponseBody
    public String ajax(@PathVariable("userId") int userid) {
        // 查找用户创建的所有帖子，不分页
        List<Post> posts = postService.selectAllPostsByUserId(userid);
        return JSONArray.toJSONString(posts);
    }

    @GetMapping("/commentsList/{userId}")
    @ResponseBody
    public String commentsList(@PathVariable int userId) {
        List<UserComment> comments = commentService.selectAllCommentsByUserId(userId);
        return JSONArray.toJSONString(comments);
    }

    // 去发帖
    @GetMapping("/post")
    public String toPostPage(@PathVariable int userId) {
        return "user/post";
    }


    // 发帖
    @PostMapping("/addPost")
    @ResponseBody
    public String addPost(@PathVariable int userId, @RequestParam("title") String title,
                          @RequestParam("content") String content) {

        com.acn.bean.Post post = new com.acn.bean.Post(title, content, userId, new SimpleDateFormat("yyyy-MM-dd " +
                "HH:mm:ss").format(new Date()), Constant.POST_NORMAL);
        int i = postService.addPost(post);
        int postId = postService.selectLastPost(userId);
        return i == 1 ? new JSONConstructor(postId, "成功", "success").toString() :
                new JSONConstructor(0, "失败", "fail").toString();
    }

    @GetMapping("/message")
    public String toMessage(@PathVariable String userId){

        return "user/message";
    }

    @PostMapping("/message")
    @ResponseBody
    public String getMessage(@PathVariable int userId){

        // 得到未读消息ID列表
        List<Comment> unreadComment = commentService.selectUnreadComment(userId);

        // 全部消息
        List<Comment> readedComment = commentService.selectComment(userId);

        // 从全部消息中移除未读消息
        readedComment.removeAll(unreadComment);

        // 更新最后访问"消息"的时间
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("id",userId);
        hashMap.put("lastVisit",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        userService.updateUser(hashMap);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("unread",unreadComment);
        jsonObject.put("readed",readedComment);

        return jsonObject.toJSONString();
    }

}
