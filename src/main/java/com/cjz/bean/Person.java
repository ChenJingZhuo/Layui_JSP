package com.cjz.bean;


public class Person {

  private long id;
  private String username;
  private String password;
  private long sex;
  private String city;
  private String birthday;
  private String tel;

  public Person() {
  }

  public Person(String username, String password) {
    this.id = id;
    this.username = username;
    this.password = password;
  }

  public Person(long id, String username, String password) {
    this.id = id;
    this.username = username;
    this.password = password;
  }

  public Person(long id, String username, String password, long sex, String city, String birthday, String tel) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.sex = sex;
    this.city = city;
    this.birthday = birthday;
    this.tel = tel;
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }


  public long getSex() {
    return sex;
  }

  public void setSex(long sex) {
    this.sex = sex;
  }


  public String getCity() {
    return city;
  }

  public void setCity(String city) {
    this.city = city;
  }


  public String getBirthday() {
    return birthday;
  }

  public void setBirthday(String birthday) {
    this.birthday = birthday;
  }


  public String getTel() {
    return tel;
  }

  public void setTel(String tel) {
    this.tel = tel;
  }

  @Override
  public String toString() {
    return "Person{" +
            "id=" + id +
            ", username='" + username + '\'' +
            ", password='" + password + '\'' +
            ", sex=" + sex +
            ", city='" + city + '\'' +
            ", birthday='" + birthday + '\'' +
            ", tel='" + tel + '\'' +
            '}';
  }
}
