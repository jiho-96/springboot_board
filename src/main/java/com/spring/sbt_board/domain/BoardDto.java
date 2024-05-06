package com.spring.sbt_board.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardDto {
    private Integer bno;
    private String title;
    private String content;
    private String writer;
    private int viewCnt;
    private int commentCnt;
    private Date regDate;
}
