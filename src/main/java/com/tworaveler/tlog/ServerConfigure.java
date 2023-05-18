package com.tworaveler.tlog;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class ServerConfigure implements WebMvcConfigurer {
	
	static String[] interceptorArr = {
			"/boardWrite","/logShare/logWrite"
	};
	
	static String[] adminInterceptorArr = {"/admin/*"};
	
	private static final List<String> URL_PATERRNS = Arrays.asList(interceptorArr);
	private static final List<String> ADMIN_URL_PATERRNS = Arrays.asList(adminInterceptorArr);
	
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginInterceptor()).addPathPatterns(URL_PATERRNS);
		registry.addInterceptor(new AdminLoginInterceptor()).addPathPatterns(ADMIN_URL_PATERRNS);
	}

	private final String uploadPath;

	public ServerConfigure(@Value("${spring.servlet.multipart.location}") String uploadPath){
		this.uploadPath = uploadPath;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry){
		registry.addResourceHandler("/upload/**")
				.addResourceLocations("file://"+uploadPath);
	}

	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
		commonsMultipartResolver.setDefaultEncoding("UTF-8");
		return commonsMultipartResolver;
	}
}