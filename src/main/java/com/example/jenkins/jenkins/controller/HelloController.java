package com.example.jenkins.jenkins.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String hello() {
        return "¡Hola! Jenkins está funcionando correctamente con Spring Boot!";
    }

    @GetMapping("/health")
    public String health() {
        return "OK - Aplicación funcionando";
    }

    @GetMapping("/version")
    public String version() {
        return "Versión 1.0.0 - Laboratorio Jenkins";
    }
}
