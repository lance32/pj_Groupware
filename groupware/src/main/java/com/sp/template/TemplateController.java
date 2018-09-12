package com.sp.template;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("templateController")
public class TemplateController {
	
	@RequestMapping(value="/template/template")
	public String template() {

		return ".template.template";
	}
	
}
