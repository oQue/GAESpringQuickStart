package com.smorzhok.gaequickstart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

/**
 * @author Dmitry Smorzhok
 */
@Controller
@RequestMapping(value = "/")
public class MainPageController {

    @RequestMapping(method = RequestMethod.GET)
    public String main() {
        return "index";
    }

}
