package com.spring.sbt_board.domain;

import lombok.Data;
import org.springframework.web.util.UriComponentsBuilder;

@Data
public class SearchCondition {
    private Integer page = 1;
    private Integer pageSize = 10;
    private String keyword = "";
    private String option = "";

    public String getQueryString(Integer page) {
        // ?page=1&pageSize=10&option=T&keyword="title"

        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("pageSize", pageSize)
                .queryParam("option", option)
                .queryParam("keyword", keyword)
                .build().toString();
    }

    public String getQueryString() {
        return getQueryString(page);
    }

    public Integer getOffset() {return (page-1) * pageSize;}
}


