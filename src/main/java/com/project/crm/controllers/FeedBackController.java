package com.project.crm.controllers;

import com.project.crm.model.Email;
import com.project.crm.validator.EmailValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Controller
public class FeedBackController {
    @Autowired
    EmailValidator emailValidator;

    @RequestMapping(value="/feedback", method= RequestMethod.GET)
    public String getMethodFeedBack(Model model) {
        return "feedback";
    }

    @RequestMapping(value="/feedback", method= RequestMethod.POST)
    public String sendFeedBack(@ModelAttribute ("Email") Email email,
                               BindingResult bindingResult, Model model) {
        emailValidator.validate(email, bindingResult);
        if (bindingResult.hasErrors()) {
            return "feedback";
        }
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        JavaMailSender mailSender = context.getBean("emailSender", JavaMailSender.class);
        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setFrom(email.getFrom());
        simpleMailMessage.setTo("netcufar@gmail.com");
        simpleMailMessage.setSubject(email.getTitle());
        simpleMailMessage.setText(email.getMessage());

        try {
             mailSender.send(simpleMailMessage);
        } catch (MailException e) {
             System.out.println("EMAIL SENDING ERROR");
             e.printStackTrace();
        }
        return "redirect: /account";
    }
}
