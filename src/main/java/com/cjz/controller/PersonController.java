package com.cjz.controller;

import com.cjz.bean.History;
import com.cjz.bean.Msg;
import com.cjz.bean.Person;
import com.cjz.service.HistoryService;
import com.cjz.service.PersonService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PersonController {
    @Autowired
    private PersonService personService;

    @Autowired
    private HistoryService historyService;

    private static final DateTimeFormatter dtf=DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm:ss");

    //查找所有用户信息
    @RequestMapping("/persons")
    @ResponseBody
    public Object doQueryAllPerson(@RequestParam("page") Integer pageNum, @RequestParam("limit") Integer pageSize) throws Exception {
        PageHelper.startPage(pageNum, pageSize);
        List<Person> persons = personService.findAllPerson();
        PageInfo page = new PageInfo(persons);
        Map<String, Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","");
        map.put("count",persons.size());
        map.put("data",persons);
        return map;
    }

    @RequestMapping(value = "/person", method = RequestMethod.POST)
    @ResponseBody
    public Msg doAddPerson(Person person) throws Exception {
        System.out.println("添加用户："+person);
        boolean flag = personService.insertPerson(person);
        if (flag) {
            historyService.insertHistory(new History(person.getUsername(),dtf.format(LocalDateTime.now())));
            return Msg.success();
        } else {
            return Msg.error();
        }

    }

    //批量删除和删除整合
    @RequestMapping(value = "/person/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg doDeletePersonAll(@PathVariable("ids") String ids) throws Exception {
        System.out.println("ids****" + ids);
        boolean flag = false;
        if (ids.contains(",")) {//执行的是批量删除
            String[] str_ids = ids.split(",");
            //组装id的集合
            for (String str : str_ids) {
                System.out.println("****批量删除****"+Integer.parseInt(str));
                Person person = personService.findPersonById(Integer.parseInt(str));
                flag = personService.removePerson(Integer.parseInt(str));
                historyService.deleteOneHistory(person.getUsername());
            }
            if (flag) {
                return Msg.success();
            } else {
                return Msg.error();
            }
        } else { //执行单个删除
            Person person = personService.findPersonById(Integer.parseInt(ids));
            flag = personService.removePerson(Integer.parseInt(ids));
            if (flag) {
                historyService.deleteOneHistory(person.getUsername());
                return Msg.success();
            } else {
                return Msg.error();
            }

        }

    }

    //根据id查询
    @RequestMapping(value = "/person/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg doQueryPersonById(@PathVariable("id") int id) throws Exception {
       // System.out.println("**********"+id);
        Person dept=personService.findPersonById(id);
        return Msg.success().add("dept",dept);
    }

    //修改部门
    @RequestMapping(value = "/person",method = RequestMethod.PUT)
    @ResponseBody
    public Msg doUpdatePerson(Person person) throws Exception{
        System.out.println("编辑用户："+person);
        boolean flag=personService.modifyPerson(person);
        if (flag) {
            return Msg.success();
        } else {
            return Msg.error();
        }
    }

    @RequestMapping("/selectPersonByParam")
    @ResponseBody
    public Object selectPersonByParam(String username){
        List<Person> people = personService.selectPersonByParam(username);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", people.size());
        map.put("data", people);
        return map;
    }

    @RequestMapping("/findPersonByNameAndPwd")
    @ResponseBody
    public Msg findPersonByNameAndPwd(Person person){
        Person person1 = personService.findPersonByNameAndPwd(person);
        System.out.println("findPersonByNameAndPwd:>>>>>>>"+person1);
        if (person1 != null){
            return Msg.success();
        } else {
            return Msg.error();
        }
    }

    @RequestMapping("/updatePersonPwd")
    @ResponseBody
    public Msg updatePersonPwd(String password, String username){
        int i = personService.updatePersonPwd(password, username);
        if (i>0){
            return Msg.success();
        } else {
            return Msg.error();
        }
    }

    @RequestMapping("/findAllPerson")
    @ResponseBody
    public Object findAllPerson(){
        List<Person> allPerson = personService.findAllPerson();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", allPerson.size());
        map.put("data", allPerson);
        return map;
    }

}


