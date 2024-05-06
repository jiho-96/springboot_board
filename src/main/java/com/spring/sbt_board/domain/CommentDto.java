package com.spring.sbt_board.domain;

import lombok.Data;

import java.util.Date;

@Data
public class CommentDto {
    private Integer cno;
    private Integer bno;
    private Integer pcno;
    private String comment;
    private String commenter;
    private Date regDate;
    private Date upDate;
}
