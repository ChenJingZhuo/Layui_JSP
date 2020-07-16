package com.cjz.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: cjz
 * @Date: 2020-07-10 10:46
 * @Version 1.0
 */
@WebFilter("/*")
public class LoginFilter implements Filter {

    // 设置编码方式
    private static String encoding = "utf-8";
    // 要放行的资源后缀
    private static final String[] passSuffix = {
            "png", "jpg", "jpeg", "gif", "css", "js", "html", "htm"
    };
    // 要放行的资源页面
    private static final String[] passPage = {
            "login.jsp", "register.jsp", "forget.jsp", "login",
            "register", "isUsernameExist"
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        request.setCharacterEncoding(encoding);
        String[] suffixs = request.getServletPath().split("\\.");
        String suffix = suffixs[suffixs.length-1];
        System.out.println("-------"+suffix);
        for (String s : passSuffix) {
            if (s.equalsIgnoreCase(suffix) && !s.equalsIgnoreCase("jsp")) {
                chain.doFilter(request,response);
                return;
            }
        }

        String[] path = request.getServletPath().split("/");
        String lastPath = path[path.length - 1];
        System.out.println(lastPath);
        for (String s : passPage) {
            // 判断资源页面是否相同
            if (s.equals(lastPath)) {
                // 如果是登录页面，判断是否可以自动登录
                if (lastPath.equals("login.jsp")) {
                    Cookie[] cookies = request.getCookies();
                    Cookie cookie = null;
                    if (cookies != null) {
                        for (Cookie cookie1 : cookies) {
                            if (cookie1.getName().equals("auto_login")) {
                                cookie = cookie1;
                            }
                        }
                    }

                    // 不能自动登录
                    if (cookie == null) { // 放行到登录页面
                        chain.doFilter(request, response);
                    } else {
                        // 设置session登录用户属性值
                        request.getSession().setAttribute("username", cookie.getValue());
                        // 重定向到主页面
                        response.sendRedirect(request.getContextPath() + "/behind/views/index.jsp");
                        //request.getRequestDispatcher("/admin/admin-index.jsp").forward(request,response);
                    }
                    return;
                }
                // 放行passPage里的页面
                chain.doFilter(request, response);
                return;
            }
        }

        String username = (String) request.getSession().getAttribute("username");
        if (username != null) {   // 放行
            chain.doFilter(request, response);
            return;
        }else {
            response.sendRedirect(request.getContextPath()+"/front/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig config) throws ServletException {
        if (encoding != null) {
            encoding = "utf-8";
        }
    }

    @Override
    public void destroy() {
        encoding = null;
    }
}
