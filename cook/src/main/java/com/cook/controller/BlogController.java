package com.cook.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BlogController {

	@GetMapping("/blog")
	public String getBlogList(Model model,
	                           @RequestParam(name = "page", defaultValue = "1") int page) throws Exception {
	    String url = "https://blog.naver.com/PostList.naver?from=postList&blogId=ilovezzangv2&categoryNo=38&currentPage=" + page;

	    Document doc = Jsoup.connect(url).get();
	    Elements posts = doc.select("#PostThumbnailAlbumViewArea .thumblist .item");

	    // 4개씩 자르기
	    List<List<Element>> rows = new ArrayList<>();
	    for (int i = 0; i < posts.size(); i += 4) {
	        List<Element> row = new ArrayList<>();
	        for (int j = i; j < i + 4 && j < posts.size(); j++) {
	            row.add(posts.get(j));
	        }
	        rows.add(row);
	    }

	    // 페이지 처리
	    Element pagination = doc.selectFirst(".blog2_paginate");
	    List<Element> pageLinks = pagination.select("a");
	    List<String> pageUrls = new ArrayList<>();
	    for (Element link : pageLinks) {
	        String pageUrl = link.attr("href").replaceAll("&amp;", "&");
	        pageUrls.add(pageUrl);
	    }

	    model.addAttribute("rows", rows);
	    model.addAttribute("pageUrls", pageUrls);
	    model.addAttribute("currentPage", page);

	    return "/blog";
	}
}

