package cn.benjamin.loxia.examples.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.benjamin.loxia.springmvc.BaseProfileController;
import cn.benjamin.loxia.web.annotation.Acl;

@Controller
public class RootController extends BaseProfileController{

	@RequestMapping("/desktop")
	@Acl("ACL_DO_NOT_HAVE")
	public String desktop(Model model){
		System.out.println("User:" + getCurrentUser().getLoginName());
		System.out.println("Current Ou:" + getCurrentOperatingUnit());
		return "desktop";
	}
}
