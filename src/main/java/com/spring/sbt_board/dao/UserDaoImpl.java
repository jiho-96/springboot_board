package com.spring.sbt_board.dao;

import com.spring.sbt_board.domain.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    SqlSession session;
    String namespace = "com.spring.sbt_board.dao.UserMapper.";

    @Override
    public User selectUser(String id) throws Exception {
        return session.selectOne(namespace+"selectUser", id);
    }

    @Override
    public Integer insertUser(User user) {
        return session.insert(namespace+"insertUser", user);
    }

    @Override
    public Integer selectId(String id) {
        return session.selectOne(namespace+"selectId", id);
    }
}