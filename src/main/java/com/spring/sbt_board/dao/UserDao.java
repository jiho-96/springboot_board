package com.spring.sbt_board.dao;

import com.spring.sbt_board.domain.User;

public interface UserDao {
    User selectUser(String id) throws Exception;

    Integer insertUser(User user);

    Integer selectId(String id);
}