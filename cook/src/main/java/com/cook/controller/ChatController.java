package com.cook.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("/chat")
public class ChatController {
    
    private final RestTemplate restTemplate = new RestTemplate();
    private final String openaiUrl = "https://api.openai.com/v1/engines/davinci-codex/completions";
    private final String openaiApiKey = "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"; // OpenAI API 키
    
    @GetMapping("/ai")
    public String chat(Model model) {
        model.addAttribute("message", "");
        return "chat/chatai";
    }
    
    @PostMapping("/chatai")
    @ResponseBody
    public String chat(@RequestParam("message") String message) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(openaiApiKey);
        String requestBody = "{\"prompt\":\"" + message + "\",\"max_tokens\":150,\"temperature\":0.5}";
        HttpEntity<String> request = new HttpEntity<>(requestBody, headers);
        try {
            ResponseEntity<String> response = restTemplate.postForEntity(openaiUrl, request, String.class);
            return response.getBody();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
}
