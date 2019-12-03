package com.icia.moviefactory.controller.mvc;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class AlarmMVCController {
	@GetMapping("/alarm") 
	public String add() {
		return "alarm/alarm";
	}
}
