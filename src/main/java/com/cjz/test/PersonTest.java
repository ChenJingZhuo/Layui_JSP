package com.cjz.test;

import com.cjz.bean.Person;
import com.cjz.service.PersonService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)//用来指定运行环境
@ContextConfiguration(locations = "classpath:spring.xml")//用于指定
public class PersonTest {
    @Autowired
    private PersonService personService;

    @Test
    public void testFindAllPerson(){
        List<Person> persons=personService.findAllPerson();
        for (Person person:persons) {
            System.out.println(person);
        }
    }

    @Test
    public void testAddPerson(){

        Person person=new Person("张三","123");
        boolean flag=personService.insertPerson(person);
        System.out.println(flag);
    }

    @Test
    public void TestUpdatePersonPwd(){
        int cjz = personService.updatePersonPwd("1", "cjz");
        System.out.println(cjz);
    }

    @Test
    public void selectPersonByParam(){
        List<Person> cj = personService.selectPersonByParam("c");
        for (Person person : cj) {
            System.out.println(person);
        }
    }

    @Test
    public void doUpdatePerson(){
        Person person = new Person();
        person.setId(1);
        person.setUsername("cjz");
        person.setSex(1);
        person.setCity("广州");
        person.setBirthday("2020-01-01");
        person.setTel("12345678901");
        boolean b = personService.modifyPerson(person);
        System.out.println(b);
    }

}
