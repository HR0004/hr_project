package com.hexagon.hrproject.config.spring;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.flywaydb.core.Flyway;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariDataSource;
// @value 조사하기
@Configuration
@PropertySource(
	    value = "classpath:config/db-local.properties",
	    encoding = "UTF-8"
	)

@MapperScan(basePackages= {"com.hexagon.hrproject.mapper"})
@EnableTransactionManagement
@ComponentScan(basePackages= {
		"com.hexagon.hrproject.service",
		"com.hexagon.hrproject.spring.security"
		
})
public class RootConfig {

    // 개인 설정 파일에서 DB 접속 정보 읽기
    @Bean(destroyMethod = "close")
    public HikariDataSource dataSource(Environment environment) {

        HikariDataSource dataSource = new HikariDataSource();

        dataSource.setDriverClassName(
        		environment.getRequiredProperty("db.driver")
        );

        dataSource.setJdbcUrl(
                environment.getRequiredProperty("db.url")
        		
        );

        dataSource.setUsername(
                environment.getRequiredProperty("db.username")
        );

        dataSource.setPassword(
                environment.getRequiredProperty("db.password")
        );

        dataSource.setMaximumPoolSize(2);
        dataSource.setMinimumIdle(1);

        return dataSource;
    }
    
    //MyBatis 설정
    
    @Bean
    @DependsOn("flyway")
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception{
       
       SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
       
       //기존DB연결 사용
       sqlSessionFactoryBean.setDataSource(dataSource);
       
       //MyBatis  설정 XML
       sqlSessionFactoryBean.setConfigLocation(new ClassPathResource("com/hexagon/hrproject/config/mybatis/mybatis-config.xml"));
   
       //Mapper XML
       sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:/mappers/*.xml"));
  
       return sqlSessionFactoryBean.getObject();
    }
    
    //트랜잭션 관리자
    @Bean
    public PlatformTransactionManager platformTransactionManager(DataSource dataSource) {
       return new DataSourceTransactionManager(dataSource);
    }
    

    // Flyway 실행
    @Bean(initMethod = "migrate")
    public Flyway flyway(DataSource dataSource) {

        return Flyway.configure()
                .dataSource(dataSource)
                .locations("classpath:db/migration")
                .baselineOnMigrate(false)
                .baselineVersion("0")
                .load();
    }

    // Tomcat 없이 실행
    public static void main(String[] args) {

        try (AnnotationConfigApplicationContext context =
                new AnnotationConfigApplicationContext(
                        RootConfig.class
                )) {

            System.out.println(
                    "===== Flyway 처리 완료 ====="
            );
        }
    }
}