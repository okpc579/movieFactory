package com.icia.moviefactory.util;

import javax.mail.*;
import javax.mail.internet.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.mail.javamail.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dto.*;

@Component
public class MailUtil {
	@Autowired
	private JavaMailSender mailSender;
	public void sendMail(Mail mail) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(mail.getSender());
			helper.setTo(mail.getReceiver());
			helper.setSubject(mail.getTitle());
			// 두번째 파라미터 : text/html 또는 text/plain
			helper.setText(mail.getContent(), true);
			mailSender.send(message);
		} catch(MessagingException e) {
			e.printStackTrace();
		}
	}
}
