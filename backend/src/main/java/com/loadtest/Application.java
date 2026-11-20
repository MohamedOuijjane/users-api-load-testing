package com.loadtest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onStartup() {
        System.out.println("Application démarrée sur le port 8080");
        System.out.println("Endpoints disponibles :");
        System.out.println("   - http://localhost:8080/api/users");
        System.out.println("   - http://localhost:8080/actuator/health");
        System.out.println("   - http://localhost:8080/actuator/metrics");
    }
}
