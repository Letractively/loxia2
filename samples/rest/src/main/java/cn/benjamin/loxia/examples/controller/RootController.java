package cn.benjamin.loxia.examples.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.benjamin.loxia.springmvc.BaseProfileController;

@Controller
public class RootController extends BaseProfileController{

	@RequestMapping("/desktop")
	public String desktop(Model model){
		return "desktop";
	}
}
