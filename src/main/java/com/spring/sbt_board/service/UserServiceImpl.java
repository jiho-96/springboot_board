package com.spring.sbt_board.service;

import com.spring.sbt_board.dao.UserDao;
import com.spring.sbt_board.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Override
    public Integer insertUser(User user) {
        if (!validateUser(user)) {
            return 0;
        }

        Integer idCount = selectId(user.getId());

        if (idCount != null && idCount >= 1) {
            return 2; // ID가 이미 존재하면 2를 반환
        }

        // ID가 중복되지 않은 경우, 사용자를 삽입
        return userDao.insertUser(user);
    }

    @Override
    public Integer selectId(String id) {
        return userDao.selectId(id);
    }

    private boolean validateUser(User user) {

        return user.getId() != null && !user.getId().isEmpty() &&
                user.getPwd() != null && !user.getPwd().isEmpty() &&
                user.getEmail() != null && !user.getEmail().isEmpty() &&
                user.getName() != null && !user.getName().isEmpty() &&
                user.getSns() != null && !user.getSns().isEmpty() &&
                user.getBirth() != null;

    }
}
