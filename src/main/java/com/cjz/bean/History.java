package com.cjz.bean;


public class History {

  private long id;
  private String username;
  private String addtime;
  private String lasttime;
  private long loginNum;

  public History() {
  }

  public History(String username, String addtime) {
    this.username = username;
    this.addtime = addtime;
  }

  public History(String username, String lasttime, long loginNum) {
    this.username = username;
    this.lasttime = lasttime;
    this.loginNum = loginNum;
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


  public String getAddtime() {
    return addtime;
  }

  public void setAddtime(String addtime) {
    this.addtime = addtime;
  }


  public String getLasttime() {
    return lasttime;
  }

  public void setLasttime(String lasttime) {
    this.lasttime = lasttime;
  }


  public long getLoginNum() {
    return loginNum;
  }

  public void setLoginNum(long loginNum) {
    this.loginNum = loginNum;
  }

  @Override
  public String toString() {
    return "History{" +
            "id=" + id +
            ", username='" + username + '\'' +
            ", addtime='" + addtime + '\'' +
            ", lasttime='" + lasttime + '\'' +
            ", loginNum=" + loginNum +
            '}';
  }
}
