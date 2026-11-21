package com.example.ai_project;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.stereotype.Service;

@Service
public class GreetingService {
    public String greet(String name)
    {
        if (name == null || name.isBlank())
        {
            name = "World";
        }
        return "Hello, " + StringEscapeUtils.escapeHtml4(name.trim()) + "!";
    }
}
