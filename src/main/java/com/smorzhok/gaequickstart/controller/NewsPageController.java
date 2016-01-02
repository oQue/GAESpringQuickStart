package com.smorzhok.gaequickstart.controller;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;
import com.smorzhok.gaequickstart.entity.NewsEntity;
import com.smorzhok.gaequickstart.exception.ObjectNotFoundException;
import com.smorzhok.gaequickstart.service.SelectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Dmitry Smorzhok
 */
@Controller
@RequestMapping(value = "/news")
public class NewsPageController {

    private static final int RECORDS_PER_PAGE = 5;

    @Autowired
    private SelectionService selectionService;

    static {
        ObjectifyService.register(NewsEntity.class);
    }

    @RequestMapping(method = RequestMethod.GET)
    public String news(ModelMap model) {
        preparePagedModel(model, 1);
        return "news";
    }

    @RequestMapping(value = "/page/{id}", method = RequestMethod.GET)
    public String newsPage(ModelMap model, @PathVariable("id") int id) {
        preparePagedModel(model, id);
        return "news";
    }

    private void preparePagedModel(ModelMap model, int index) {
        model.put("currentIndex", index);
        long totalRecords = selectionService.countAll(NewsEntity.class);
        if (totalRecords < (index - 1) * RECORDS_PER_PAGE) {
            // requested page doesn't exist
            throw new ObjectNotFoundException("Requested page doesn't exist");
        }
        model.put("pages", Math.ceil(totalRecords / (float) RECORDS_PER_PAGE));
        List<NewsEntity> newsList = selectionService.listObjectByPage(NewsEntity.class, index,
                RECORDS_PER_PAGE, "-date");
        model.put("entries", newsList);
    }

    @RequestMapping(value = "/view/{link}", method = RequestMethod.GET)
    public String newsEntry(ModelMap model, @PathVariable("link") String link,
                           @ModelAttribute("entry") NewsEntity entity, HttpServletRequest request) {
        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("link", link);
        entity = selectionService.getUniqueEntity(NewsEntity.class, conditions);
        model.put("entry", entity);
        model.put("backLink", request.getHeader("referer"));
        UserService userService = UserServiceFactory.getUserService();
        if (userService.getCurrentUser() != null && userService.isUserAdmin()) {
            model.put("isAdmin", true);
        }
        return "newsEntry";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addNewsGet(@ModelAttribute("entry") NewsEntity entry) {
        return "addNews";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addNewsPost(ModelMap model, @ModelAttribute("entry") NewsEntity entry) {
        try {
            // server validation. Link should be unique
            Map<String, Object> conditions = new HashMap<String, Object>();
            conditions.put("link", entry.getLink().toLowerCase());
            selectionService.getUniqueEntity(NewsEntity.class, conditions);
            model.put("notUniqueLink", true);
            return "addNews";
        } catch (RuntimeException ignored) {
            // getUniqueEntity should throw exception
        }
        entry.setDate(Calendar.getInstance().getTime());
        selectionService.save(entry);
        return "redirect:/news";
    }

    @RequestMapping(value = "/delete/{link}", method = RequestMethod.POST)
    public String deleteNews(@PathVariable("link") String link) {
        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("link", link);
        NewsEntity entity = selectionService.getUniqueEntity(NewsEntity.class, conditions);
        selectionService.delete(entity);
        return "redirect:/news";
    }

    @ExceptionHandler(ObjectNotFoundException.class)
    public String error404() {
        return "error";
    }

}
