package com.cjz.service.impl;

import com.cjz.bean.Person;
import com.cjz.mapper.PersonMapper;
import com.cjz.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PersonServiceImpl implements PersonService {

    @Autowired
    private PersonMapper personMapper;

    @Override
    public boolean insertPerson(Person person) {
        int count = personMapper.insertPerson(person);
        if (count > 0) {
            return true;
        }
        return false;
    }

    @Override
    public boolean modifyPerson(Person person) {
        int count = personMapper.updatePerson(person);
        if (count > 0) {
            return true;
        }
        return false;
    }

    @Override
    public boolean removePerson(int id) {
        int count = personMapper.deletePerson(id);
        if (count > 0) {
            return true;
        }
        return false;
    }

    @Override
    public Person findPersonById(int id) {
        Person person = (Person) personMapper.selectByPersonId(id);
        if (person != null) {
            return person;
        }
        return null;
    }

    @Override
    public List<Person> findAllPerson() {
        List<Person> persons = personMapper.selectPersonAll();
        if (persons.size() > 0) {
            return persons;
        }
        return null;
    }

    @Override
    public Person findPersonByNameAndPwd(Person person) {
        return personMapper.findPersonByNameAndPwd(person);
    }

    @Override
    public Person findPersonByName(Person person) {
        return personMapper.findPersonByName(person);
    }

    @Override
    public int updatePersonPwd(String password, String username) {
        return personMapper.updatePersonPwd(password, username);
    }

    @Override
    public List<Person> selectPersonByParam(String param) {
        return personMapper.selectPersonByParam(param);
    }
}
