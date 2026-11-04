package com.hexagon.hrproject.service;

import static org.junit.Assert.*;
import java.util.Collections;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.annotation.*;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.support.*;
import org.springframework.dao.DuplicateKeyException;
import com.hexagon.hrproject.exception.SalaryBusinessException;
import com.hexagon.hrproject.domain.Salary;

public class SalaryServiceSecurityTest {
    // 이 프로필은 아래 setup()의 테스트 컨테이너에서만 활성화한다.
    @Configuration @Profile("payroll-isolated-unit-test")
    @EnableMethodSecurity @EnableTransactionManagement
    static class Config {
        @Bean SalaryServiceTest.Mapper mapper() { return new SalaryServiceTest.Mapper(); }
        @Bean SalaryService salaryService(SalaryServiceTest.Mapper m) { return new SalaryService(m); }
        @Bean Tx transactionManager() { return new Tx(); }
    }
    static class Tx extends AbstractPlatformTransactionManager {
        int commits, rollbacks;
        protected Object doGetTransaction() { return new Object(); }
        protected void doBegin(Object t, TransactionDefinition d) { }
        protected void doCommit(DefaultTransactionStatus s) { commits++; }
        protected void doRollback(DefaultTransactionStatus s) { rollbacks++; }
    }
    AnnotationConfigApplicationContext context;
    SalaryService service;
    @Before public void setup() {
        context = new AnnotationConfigApplicationContext();
        context.getEnvironment().setActiveProfiles("payroll-isolated-unit-test");
        context.register(Config.class);
        context.refresh();
        service = context.getBean(SalaryService.class);
    }
    @After public void cleanup() { SecurityContextHolder.clearContext(); context.close(); }
    void as(String role) {
        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(
                "unit-test-principal", null, Collections.singletonList(new SimpleGrantedAuthority(role))));
    }
    @Test public void noAuthenticationCannotList() {
        assertThrows(AuthenticationCredentialsNotFoundException.class, () -> service.getSalaryList());
    }
    @Test public void employeeCannotList() {
        as("ROLE_EMPLOYEE"); assertThrows(AccessDeniedException.class, () -> service.getSalaryList());
    }
    @Test public void employeeCannotCreate() {
        as("ROLE_EMPLOYEE"); assertThrows(AccessDeniedException.class,
                () -> service.createSalary(SalaryServiceTest.request()));
        assertEquals(0, context.getBean(SalaryServiceTest.Mapper.class).inserts);
    }
    @Test public void hrAdminCanList() { as("ROLE_HR_ADMIN"); assertTrue(service.getSalaryList().isEmpty()); }
    @Test public void noAuthenticationCannotReadDetail() {
        assertThrows(AuthenticationCredentialsNotFoundException.class, () -> service.getSalaryDetail(42L));
        assertEquals(0, context.getBean(SalaryServiceTest.Mapper.class).detailReads);
    }
    @Test public void employeeCannotReadDetail() {
        as("ROLE_EMPLOYEE");
        assertThrows(AccessDeniedException.class, () -> service.getSalaryDetail(42L));
        assertEquals(0, context.getBean(SalaryServiceTest.Mapper.class).detailReads);
    }
    @Test public void teamApproverCannotReadDetail() {
        as("ROLE_TEAM_APPROVER");
        assertThrows(AccessDeniedException.class, () -> service.getSalaryDetail(42L));
        assertEquals(0, context.getBean(SalaryServiceTest.Mapper.class).detailReads);
    }
    @Test public void hrAdminCanReadDetail() {
        as("ROLE_HR_ADMIN");
        SalaryServiceTest.Mapper m = context.getBean(SalaryServiceTest.Mapper.class);
        m.found = new Salary(); m.found.setSalaryId(42L);
        assertSame(m.found, service.getSalaryDetail(42L));
        assertEquals(1, m.detailReads);
    }
    @Test public void hrAdminCreateCommits() {
        as("ROLE_HR_ADMIN"); service.createSalary(SalaryServiceTest.request());
        assertEquals(1, context.getBean(Tx.class).commits);
    }
    @Test public void translatedDuplicateRollsBack() {
        as("ROLE_HR_ADMIN");
        context.getBean(SalaryServiceTest.Mapper.class).failure = new DuplicateKeyException("unit-test");
        assertThrows(SalaryBusinessException.class, () -> service.createSalary(SalaryServiceTest.request()));
        assertEquals(1, context.getBean(Tx.class).rollbacks);
        assertEquals(0, context.getBean(Tx.class).commits);
    }
    @Test public void testConfigurationIsNotDiscoveredByServiceComponentScan() {
        ClassPathScanningCandidateComponentProvider scanner =
                new ClassPathScanningCandidateComponentProvider(true);
        java.util.Set<String> discovered = new java.util.HashSet<>();
        scanner.findCandidateComponents("com.hexagon.hrproject.service")
                .forEach(bean -> discovered.add(bean.getBeanClassName()));
        assertTrue("Real service must remain discoverable", discovered.contains(SalaryService.class.getName()));
        assertFalse("Test-only security configuration must not be auto-scanned",
                discovered.contains(Config.class.getName()));
    }
}
