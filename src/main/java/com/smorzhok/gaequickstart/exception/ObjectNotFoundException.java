package com.smorzhok.gaequickstart.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * @author Dmitry Smorzhok
 */
@ResponseStatus(value= HttpStatus.NOT_FOUND, reason="Requested entity not found")
public class ObjectNotFoundException extends RuntimeException {

    public ObjectNotFoundException(String message) {
        super(message);
    }
}
