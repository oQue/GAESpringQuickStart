package com.smorzhok.gaequickstart.dao;

import com.googlecode.objectify.cmd.Query;
import com.smorzhok.gaequickstart.entity.BaseEntity;
import com.smorzhok.gaequickstart.exception.ObjectNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 * @author Dmitry Smorzhok
 */
@Service("selectionDao")
public class SelectionDaoImpl implements SelectionDao {

    public <T extends BaseEntity> void save(T object) {
        ofy().save().entity(object).now();
    }

    public <T extends BaseEntity> void delete(T object) {
        ofy().delete().entity(object).now();
    }

    public <T extends BaseEntity> List<T> listObjectByPage(Class<T> clazz, int page, int pageSize, String order) {
        return ofy().load().type(clazz).offset((page - 1) * pageSize).limit(pageSize).order(order).list();
    }

    public <T extends BaseEntity> long countAll(Class<T> clazz) {
        return ofy().load().type(clazz).count();
    }

    public <T extends BaseEntity> T getUniqueEntity(Class<T> clazz, Map<String, Object> conditions) {
        Query<T> query = ofy().load().type(clazz);
        for (Map.Entry<String, Object> entry : conditions.entrySet()) {
            query = query.filter(entry.getKey(), entry.getValue());
        }
        List<T> list = query.list();
        if (CollectionUtils.isEmpty(list)) {
            throw new ObjectNotFoundException("Object of class " + clazz.getCanonicalName() +
                    " not found by given conditions: " + conditions);
        }
        if (list.size() > 1) {
            throw new ObjectNotFoundException("There are several objects of class " + clazz.getCanonicalName() +
                    " found by given conditions: " + conditions);
        }
        return list.get(0);
    }

}
