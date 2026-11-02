package com.hexagon.config.spring;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/*------------------------------------------------------------------------------------------------------------------------------------------------------
web.xml로 개발해도 되지만, 스프링부트를 포함한 최신 스프링들은  xml 보다는  java 로 설정을 대체하는 분위기.. 
코드에는 명시되어 잇지 않지만, DispatcherServlet 이 생성될때 스프링 컨테이너인 ApplicationContext 도 1개 생성되어 
설정파일에 명시된 빈들의 인스턴스를 올리고 관리하기 시작한다..또한 이 컨테이너가 관리하고 있는 빈들은 오직 DispatcherServlet  의 요청을 통해서만 접근할 수 있다
--------------------------------------------------------------------------------------------------------------------------------------------------------*/
public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer{

	/*
	 * 하나의 애플리케이션에서 DisparcharServlet은 당연히 여러개 정의할 수 있다. 이때 스프링은 각 DisparcharServlet 마다 스프링 컨테이너를 하나씩 할당해준다
	 * 하지만 각 모델 영역의 객체들(DAO, Service, Mybatis Mapper 등을)을 어느 한족 DispatcharServlet 의 스프링 컨테이너에 넣거나(문제점1)
	 * 또는 양쪽 모두에 생성할 경우 문제가 발생함(문제점2)
	 * 문제점1) 모델(DAO 등)을 어느 한쪽에 생성하여 관리할 경우, 아직 메모리에 올라오지 못할 경우 사용자체가 불가능한 문제가 발생한다(생성 시점)
	 * 문제점2) 그렇다고 하여 모델 객체들을 모든 DispatcharServlet 이 관리하는 스프링 컨테이너마다 생성하면 인스턴스가 너무 많이 만들어진다(메모리 효츌 문제)
	 * 해결책) 서블릿이 태어나기도 전에 먼저 생성될수 있는 주체, 모든 서블잇이 쳐다볼 수 있는 즉 참조할수 있는 전역 객체가 있어야 함
	 * 			 이 두조건을 만족하는 자(者) = application 내장객체(jsp) 즉 자료형으로써는 ServletContext 이다!!
	 * 
	 * 결론) 톰켓을 가동하자 마자 톰켓에 배포된 각 애플리케이션 마다 무조건 1:1 대응 ServletContext 가 관리하는 스프링 컨테이너에 빈을 등록하려면 아래의
	 * 			getRootConfigClasses() 메서드에 등록하면 됨
	 * */
	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class<?>[] {
			RootConfig.class //모든 DispatcharServlet 들이 참조할 수 있는 공통의 모델과 관련된 빈즈들을 등록할 설정 클래스
		};
	}

	//서블릿 수준의 컨테이너가 보유할 빈들을 명시한 클래스 등록
	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class<?>[] {
			AppConfig.class
		};
		
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] {"/"};
	}
	
	//한글 인코딩 처리하자!! web.xml 에서 등록했던 거 그대로
	@Override
	protected Filter[] getServletFilters() {
		// TODO Auto-generated method stub
		CharacterEncodingFilter encodingFilter =  new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true);//UTF-8이외의 인코딩 요청이 들어와도 무시한다, 즉 무조건 UTF-8을 강제함
		
		//스프링 시큐리티 필터 프록시 생성 및 등록(이때 빈의 이름은 반드시 "SpringSecurityFilterChain" 으로 해야함)
		DelegatingFilterProxy securityFilter = new DelegatingFilterProxy("springSecurityFilterChain");
		return new Filter[] {
			encodingFilter //, securityFilter
		};
	}
}
