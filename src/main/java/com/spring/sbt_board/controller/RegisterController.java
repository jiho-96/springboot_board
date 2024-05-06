package com.spring.sbt_board.controller;

import com.spring.sbt_board.dao.UserDao;
import com.spring.sbt_board.domain.User;
import com.spring.sbt_board.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
public class RegisterController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/register/add", method = {RequestMethod.GET, RequestMethod.POST})
    public String register() {
        return "registerForm";
    }

    @PostMapping("/register/save")
    public String save(User user, RedirectAttributes rattr, Model m) {

        try {
            Integer result = userService.insertUser(user);
            userService.selectId(user.getId());

            if (result == 2) {
                rattr.addFlashAttribute("msgs", "DUP_ERR");
                return "redirect:/register/add";
            }

            if (result != 1) {
                rattr.addFlashAttribute("msgs", "FAIL_ERR");
                return "redirect:/register/add";
            }
            return "loginForm";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msgs", "ERROR");
            return "redirect:/register/add";
        }
    }
}