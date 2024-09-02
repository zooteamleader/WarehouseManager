package com.rabbiter.common;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(value =Exception.class)
    @ResponseBody
    public ResponseEntity<String> handleException(Exception e) {
        // 自定义异常处理逻辑
        String message = e.getMessage();
        if(message.contains("Access denied for user 'root'@'localhost' (using password: YES)")) {
            message = "P Request failed with status code 500";
        } else if(message.contains("Unknown database")) {
            message = "U Request failed with status code 500";
        } else if(message.contains("edis")) {
            message = "R Request failed with status code 500";
        } else if(message.contains("Failed to obtain JDBC Connection")) {
            message = "C Request failed with status code 500";
        } else if(message.contains("SQLSyntaxErrorException")) {
            message = "S Request failed with status code 500";
        }
        return new ResponseEntity<>(message, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
