package com.cjz.service.impl;

import com.cjz.bean.History;
import com.cjz.bean.Person;
import com.cjz.mapper.HistoryMapper;
import com.cjz.service.HistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @Author: cjz
 * @Date: 2020-07-16 17:43
 * @Version 1.0
 */
@Service
public class HistoryServiceImpl implements HistoryService {

    @Autowired
    private HistoryMapper historyMapper;

    private static final DateTimeFormatter dtf=DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm:ss");

    @Override
    public List<History> findAllHistory() {
        return historyMapper.findAllHistory();
    }

    @Override
    public int insertHistory(History history) {
        return historyMapper.insertHistory(history);
    }

    @Override
    public int updateHistory(History history) {
        return historyMapper.updateHistory(history);
    }

    @Override
    public int deleteOneHistory(String id) {
        return historyMapper.deleteOneHistory(id);
    }

    @Override
    public History findHistoryByName(String username) {
        return historyMapper.findHistoryByName(username);
    }
}
