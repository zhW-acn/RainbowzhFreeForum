package com.acn.controller;

import com.acn.bean.User;
import com.acn.bean.view.Comment;
import com.acn.bean.view.Post;
import com.acn.service.CommentService;
import com.acn.service.PostService;
import com.acn.service.UserService;
import com.alibaba.fastjson.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Description: 主页的controller
 * @Author: acn
 * @Date: 2023/11/25/14:34
 */
@Controller
public class IndexController {
    // 分页大小
    static final int PAGE_SIZE = 4;

    @Autowired
    UserService userService;

    @Autowired
    PostService postService;

    @Autowired
    CommentService commentService;

    /**
     * 查询PAGE_SIZE条帖子，没有登录不能查看帖子和【加载更多】
     */
    @GetMapping("/")
    public String index(
            HttpServletRequest request,
            Model model
    ) {
        // 总页数
        int count = postService.postsCount() % PAGE_SIZE != 0 ? (postService.postsCount() / PAGE_SIZE + 1) :
                postService.postsCount() / PAGE_SIZE;
        model.addAttribute("count", count);
        return "index";
    }

    @GetMapping("/ajax")
    @ResponseBody
    public String ajaxList(
            HttpServletRequest request,
            @RequestParam(name = "page") int page
    ) {
        int start = (page - 1) * PAGE_SIZE;
        List<Post> list = postService.selectPostByPaging(start, PAGE_SIZE);
        /**
         * 参数说明：
         * avatar：用户头像地址
         * userName：用户名
         * title：标题
         * content：正文
         * replyNum：回帖人数
         * postTime：发帖时间
         */
        return JSONArray.toJSONString(list);
    }

    @GetMapping("/hotpost")
    public String toHotPost(){
        return "HotPost";
    }

    @GetMapping("/getmessage")
    @ResponseBody
    public String getMessage(HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 查询评论数
        List<Comment> unreadCommentId = commentService.selectUnreadComment(user.getId());

        // 更新最后访问"消息"的时间
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("id",user.getId());
        hashMap.put("lastVisit",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        userService.updateUser(hashMap);

        return String.valueOf(unreadCommentId.size());
    }
}
