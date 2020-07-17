package com.cjz.controller;

import com.cjz.bean.History;
import com.cjz.bean.Msg;
import com.cjz.service.HistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: cjz
 * @Date: 2020-07-17 02:47
 * @Version 1.0
 */
@Controller
public class HistoryController {

    @Autowired
    private HistoryService historyService;

    @RequestMapping("/findAllHistory")
    @ResponseBody
    public Object findAllHistory(){
        List<History> allHistory = historyService.findAllHistory();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", allHistory.size());
        map.put("data", allHistory);
        return map;
    }

}
