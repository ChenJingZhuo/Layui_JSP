package com.cjz.controller;

import com.cjz.bean.History;
import com.cjz.bean.Msg;
import com.cjz.bean.Person;
import com.cjz.service.HistoryService;
import com.cjz.service.PersonService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    //查找所有部门信息
    @RequestMapping("/persons")
    public String doQueryAllPerson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) throws Exception {
        //这不是一个分页查询，引入PageHelper分页插件，在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询是一个分页查询
        List<Person> depts = personService.findAllPerson();
        //使用PageInfo 包装查询后的结果，只需要将pageInfo交给页面就行
        //pageInfo封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数,分页连续显示的页数
        PageInfo page = new PageInfo(depts, 5);
        model.addAttribute("pageInfo", page);
        return "/admin/admin-dept.jsp";
    }

    @RequestMapping(value = "/person", method = RequestMethod.POST)
    @ResponseBody
    public Msg doAddPerson(Person person) throws Exception {
        boolean flag = personService.insertPerson(person);
        if (flag) {
            return Msg.success();
        } else {
            return Msg.error();
        }

    }

    //批量删除和删除整合
    @RequestMapping(value = "/person/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg doDeletePersonAll(@PathVariable("ids") String ids) throws Exception {
        //System.out.println("****" + ids);
        boolean flag = false;
        if (ids.contains(",")) {//执行的是批量删除
            String[] str_ids = ids.split(",");
            //组装id的集合
            for (String str : str_ids) {
                //  System.out.println("****"+Integer.parseInt(str));
                flag = personService.removePerson(Integer.parseInt(str));
            }
            if (flag) {
                return Msg.success();
            } else {
                return Msg.error();
            }
        } else { //执行单个删除
            flag = personService.removePerson(Integer.parseInt(ids));
            if (flag) {
                historyService.deleteOneHistory(ids);
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
    @RequestMapping(value = "person",method = RequestMethod.PUT)
    @ResponseBody
    public Msg doUpdatePerson(Person person) throws Exception{
       /// System.out.println(dept);
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
        /*Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", people.size());
        map.put("data", people);
        return map;*/
        return people;
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


