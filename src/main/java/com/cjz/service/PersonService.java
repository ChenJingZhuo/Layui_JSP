package com.cjz.service;

import com.cjz.bean.Person;

import java.util.List;

/**
 * Description: empmsg
 * Created by lxf CTEon 2020/7/1 9:57
 */
public interface PersonService {
    // 添加
    public boolean insertPerson(Person person);

    // 更新
    public boolean modifyPerson(Person person);

    // 删除
    public boolean removePerson(int id);

    // 根据id查
    public Person findPersonById(int id);

    // 查询所有可用的部门
    public List<Person> findAllPerson();

    /**
     * 查询登录用户信息是否存在
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

    /**
     * 模精查询
     * @param param
     * @return
     */
    List<Person> selectPersonByParam(String param);

}
