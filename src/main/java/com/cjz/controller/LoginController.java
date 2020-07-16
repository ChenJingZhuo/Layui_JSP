package com.cjz.controller;

import com.cjz.bean.History;
import com.cjz.bean.Msg;
import com.cjz.bean.Person;
import com.cjz.mapper.HistoryMapper;
import com.cjz.service.HistoryService;
import com.cjz.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @Author: cjz
 * @Date: 2020-07-16 12:37
 * @Version 1.0
 */
@Controller
public class LoginController {

    @Autowired
    private PersonService personService;

    @Autowired
    private HistoryService historyService;

    private static final DateTimeFormatter dtf=DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm:ss");

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Msg login(HttpServletRequest request){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println(username+">>>>>>>>>>>>");
        System.out.println(password+">>>>>>>>>>>>");
        Person person = new Person(username, password);
        Person person1 = personService.findPersonByNameAndPwd(person);
        System.out.println(person1+">>>>>>>>>>>");
        if (person1 != null){
            request.getSession().setAttribute("username",username);
            History history = historyService.findHistoryByName(username);
            if (history != null){
                historyService.updateHistory(new History(username,dtf.format(LocalDateTime.now()),Long.valueOf(history.getLoginNum())+1));
            }
            return Msg.success();
        } else {
            return Msg.error();
        }
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Msg register(String username, String password, HttpServletRequest request){
        boolean flag = personService.insertPerson(new Person(username, password));
        if (flag){
            request.getSession().setAttribute("login_name",username);
            historyService.insertHistory(new History(username, password));
            return Msg.success();
        } else {
            return Msg.error();
        }
    }

    @RequestMapping(value = "/isUsernameExist", method = RequestMethod.POST)
    @ResponseBody
    public Msg isUsernameExist(Person person){
        System.out.println(person.getUsername()+"<<<<<<<<<<");
        System.out.println(person.getPassword()+"<<<<<<<<<<");
        Person person1 = personService.findPersonByName(person);
        System.out.println(person1+"<<<<<<<<<<");
        if (person1 != null){
            return Msg.success();
        } else {
            return Msg.error();
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        request.getSession().invalidate();
        return "redirect:/front/login.jsp";
    }

}
