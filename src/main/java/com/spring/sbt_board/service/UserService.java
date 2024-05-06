package com.spring.sbt_board.service;

import com.spring.sbt_board.domain.User;

public interface UserService {
    Integer insertUser(User user);

    Integer selectId(String id);
}
