package cn.benjamin.loxia.examples.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.benjamin.loxia.springmvc.BaseProfileController;
import cn.benjamin.loxia.springmvc.annotation.CurrentOu;
import cn.benjamin.loxia.web.LoxiaWebConstants;
import cn.benjamin.loxia.web.annotation.Acl;

@Controller
public class RootController extends BaseProfileController{

	@RequestMapping("/desktop")
	public String desktop(Model model){		
		System.out.println("User:" + getCurrentUser().getLoginName());
		System.out.println("Current Ou:" + getCurrentOperatingUnit());
		return "desktop";
	}
	
	@RequestMapping("/{ouId}/desktop")
	@Acl("ACL_USER_MAINTAIN")
	public String desktop(Model model, @PathVariable("ouId") @CurrentOu Long ouId){
		System.out.println("User:" + getCurrentUser().getLoginName());
		System.out.println("Current Ou:" + getCurrentOperatingUnit());
		return "desktop";
	}
	
	@RequestMapping(value="/currentuser", method=RequestMethod.GET)
	public String getUser(Model model){
		model.addAttribute("user", getCurrentUser());
		model.addAttribute(LoxiaWebConstants.JSON_FILTER_STR,"user.*,user.ou.*");
		return "json";
	}
	
	@RequestMapping("/error")
	@Acl("ACL_NOT_EXIST")
	public String error(){
		return "";
	}
}
