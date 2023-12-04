package com.acn.utils;

import com.acn.bean.view.Post;
import com.acn.service.PostService;
import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.NlpAnalysis;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 中文分词并排序
 * @Author: acn
 * @Date: 2023/12/03/22:03
 */
public class SortTextUtil {
    /**
     *
     * @param text 排序文本
     * @param topN 排序长度
     * @return list
     */
    public static List<Map.Entry<String, Integer>> findMostCommonWords(String text, int topN) {
        // 去除标点符号
        text = removePunctuation(text);

        // 中文分词
        List<Term> terms = NlpAnalysis.parse(text).getTerms();

        // 统计词频
        Map<String, Integer> wordCounts = new HashMap<>();
        for (Term term : terms) {
            String word = term.getName();
            wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
        }

        // 将词频排序
        List<Map.Entry<String, Integer>> sortedWords = new ArrayList<>(wordCounts.entrySet());
        sortedWords.sort((entry1, entry2) -> entry2.getValue().compareTo(entry1.getValue()));

        // 截取前topN个
        return sortedWords.subList(0, Math.min(topN, sortedWords.size()));
    }

    private static String removePunctuation(String text) {
        // 去除标点符号
        return text.replaceAll("[\\pP\\p{Punct}\\s]", " ");
    }

    public static void main(String[] args) {

        ClassPathXmlApplicationContext classPathXmlApplicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");

        PostService postService = classPathXmlApplicationContext.getBean("postServiceImpl", PostService.class);
        List<Post> posts = postService.selectPostByPaging(0, 100000);
        StringBuilder sb = new StringBuilder();
        posts.forEach(post -> {
            sb.append(post.getText());
        });
        // 找到最频繁的5个词
        List<Map.Entry<String, Integer>> result = findMostCommonWords(sb.toString(), 10);

        // 打印结果
        for (Map.Entry<String, Integer> entry : result) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
    }
}
