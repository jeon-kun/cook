package com.cook.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.cook.util.YoutubeSearchItem;
import com.cook.util.YoutubeSearchResult;

@Controller
public class YoutubeController {

    @Autowired
    private RestTemplate restTemplate;

    @RequestMapping("/search")
    public String search(@RequestParam("q") String query, Model model) {
    	String url = "https://www.googleapis.com/youtube/v3/search?key={apiKey}&part=snippet&q={query}&maxResults=12";
        String apiKey = "AIzaSyAim6qc6g-42sOqXdULZslZh12JCzJpHNo";

        List<String> videoIds = new ArrayList<>();

        try {
            YoutubeSearchResult result = restTemplate.getForObject(url, YoutubeSearchResult.class, apiKey, query);
            for (YoutubeSearchItem item : result.getItems()) {
                videoIds.add(item.getId().getVideoId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("videoIds", videoIds);

        return "searchResults";
    }

}
