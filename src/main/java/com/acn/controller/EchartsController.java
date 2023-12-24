package com.acn.controller;

import com.acn.bean.view.Post;
import com.acn.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Random;

/**
 * @Description: 用于测试的
 * @Author: acn
 * @Date: 2023/12/01/1:47
 */
@Controller
public class EchartsController {

    @Autowired
    PostService postService;

    @PostMapping("/hot")
    @ResponseBody
    public String test1() {
        Random random = new Random();
        List<Post> posts = postService.selectAllVisiblePosts();

        String[] colorList = {
                "#ff7f50", "#87cefa", "#da70d6", "#32cd32", "#6495ed",
                "#ff69b4", "#ba55d3", "#cd5c5c", "#ffa500", "#40e0d0",
                "#1e90ff", "#ff6347", "#7b68ee", "#d0648a", "#ffd700",
                "#6b8e23", "#4ea397", "#3cb371", "#b8860b", "#7bd9a5"
        };
        StringBuilder stringBuilder = new StringBuilder("[");
        //name: "美国", value
        posts.forEach(post -> {
            stringBuilder.append(
                    "{ \"name\":\"" + post.getTitle() + "\"," +
                            "\"symbolSize\":" + post.getReplyCount() * 10 + "," +
                            "\"postid\":" + post.getPostId() + "," +
                            "\"draggable\": true," +
                            "\"itemStyle\": {" +
                            "\"normal\": {" +
                            "\"shadowBlur\": 100," +
                            "\"shadowColor\": \"" + colorList[random.nextInt(20)] + "\"," +
                            "\"color\": \"" + colorList[random.nextInt(20)] + "\"}" +
                            "}},"
            );
        });
        stringBuilder.setCharAt(stringBuilder.length() - 1, ']');
        System.out.println(stringBuilder);
        return stringBuilder.toString();
    }
}
