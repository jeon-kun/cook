package com.cook.util;

public class YoutubeSearchItem {
    private YoutubeVideoId id;
    private YoutubeSnippet snippet;

    public YoutubeVideoId getId() {
        return id;
    }

    public void setId(YoutubeVideoId id) {
        this.id = id;
    }

    public YoutubeSnippet getSnippet() {
        return snippet;
    }

    public void setSnippet(YoutubeSnippet snippet) {
        this.snippet = snippet;
    }
}
