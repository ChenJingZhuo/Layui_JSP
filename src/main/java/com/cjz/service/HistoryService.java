package com.cjz.service;

import com.cjz.bean.History;

import java.util.List;

/**
 * @Author: cjz
 * @Date: 2020-07-16 17:42
 * @Version 1.0
 */
public interface HistoryService {
    /**
     * 查询所有的登录信息
     * @return
     */
    List<History> findAllHistory();

    /**
     * 首次注册，添加历史信息
     * @param history
     * @return
     */
    int insertHistory(History history);

    /**
     * 每次次登录，更新历史信息
     * @param history
     * @return
     */
    int updateHistory(History history);

    /**
     * 删除一条历史记录
     * @param history
     * @return
     */
    int deleteOneHistory(History history);

    /**
     * 通过用户名查询一条历史信息
     * @param username
     * @return
     */
    History findHistoryByName(String username);
}
