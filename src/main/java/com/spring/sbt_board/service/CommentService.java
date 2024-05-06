package com.spring.sbt_board.service;

import com.spring.sbt_board.domain.CommentDto;

import java.util.List;

public interface CommentService {
    int modify(CommentDto dto) throws Exception;

    int write(CommentDto dto) throws Exception;

    int remove(Integer cno, Integer bno, String commenter) throws Exception;

    List<CommentDto> getList(Integer bno) throws Exception;

    int getCount(Integer bno) throws Exception;

    CommentDto read(Integer cno) throws Exception;
}
