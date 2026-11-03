package com.hexagon.config.spring;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

/*-------------------------------------------------------------------------------------------------------------------------
	스프링 프레임웍에서는 개발자가 직접 인스턴스를 new 해서 생성하는 것이 아니라, 
	프레임웍 자체적으로 관리하도록 등록해야 함..이때 등록될 클래스들을 가리켜 빈이라고 하고, 이 빈들을 관리해주는 스프링의 관리주체를 
	스프링 컨테이너라 하며 자료형은 ApplicationContext  
----------------------------------------------------------------------------------------------------------------------------*/
@EnableWebMvc
@Configuration//이 클래스는 로직용이 아니라, 빈 설정용이다!
@ComponentScan(basePackages = {
		"com.hexagon.joo.controller", 
		"com.hexagon.joo.rest.controller", 
		"com.hexagon.springmvc.common.web"
})
public class AppConfig {
	//스프링 컨테이너가 보유할 빈들의 목록을 어노테이션으로 등록하자
	
	@Bean
	public InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/component/");//접두어를 결정 
		resolver.setSuffix(".jsp");
		//접미어를 결정
		return resolver;
	}
}











