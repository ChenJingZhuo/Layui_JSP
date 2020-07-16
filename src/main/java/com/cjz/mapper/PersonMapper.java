package com.cjz.mapper;

import com.cjz.bean.Person;

import java.util.List;

public interface PersonMapper {
    /**
     * 添加用户
     * @param person
     * @return
     */
    int insertPerson(Person person);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deletePerson(int id);

    /**
     * 修改用户
     * @param person
     * @return
     */
    int updatePerson(Person person);

    /**
     * 根据编号查询用户
     * @param id
     * @return
     */
    Person selectByPersonId(int id);

    /**
     * 查询所有用户
     * @return
     */
    List<Person> selectPersonAll();

    /**
     * 模精查询
     * @param param
     * @return
     */
    List<Person> selectPersonByParam(String param);

    /**
     * 通过用户名和密码查找用户
     * @param person
     * @return
     */
    Person findPersonByNameAndPwd(Person person);

    /**
     * 通过用户名查找用户
     * @param person
     * @return
     */
    Person findPersonByName(Person person);

    /**
     * 修改当前用户的密码
     * @param password
     * @param username
     * @return
     */
    int updatePersonPwd(String password, String username);

}
