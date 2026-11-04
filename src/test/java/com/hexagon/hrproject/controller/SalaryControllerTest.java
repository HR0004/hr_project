package com.hexagon.hrproject.controller;

import static org.junit.Assert.*;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import org.junit.Test;
import org.springframework.ui.ExtendedModelMap;
import com.hexagon.hrproject.domain.Salary;
import com.hexagon.hrproject.dto.request.SalaryCreateRequest;
import com.hexagon.hrproject.exception.SalaryNotFoundException;
import com.hexagon.hrproject.mapper.SalaryMapper;
import com.hexagon.hrproject.service.SalaryService;

public class SalaryControllerTest {
    static class Mapper implements SalaryMapper {
        Salary found;
        public List<Salary> selectAll() { return Collections.emptyList(); }
        public Salary selectById(Long salaryId) { return found; }
        public int countByEmpAndYearMonth(Long empId, String month) { return 0; }
        public int insert(Salary salary) { salary.setSalaryId(42L); return 1; }
    }

    @Test public void detailAddsStoredRecordToModel() {
        Mapper mapper = new Mapper(); mapper.found = new Salary();
        mapper.found.setSalaryId(42L);
        ExtendedModelMap model = new ExtendedModelMap();
        SalaryController controller = new SalaryController(new SalaryService(mapper));
        assertEquals("salary/detail", controller.detail(42L, model));
        assertSame(mapper.found, model.get("salary"));
    }

    @Test public void successfulCreateRedirectsToGeneratedId() {
        SalaryCreateRequest request = new SalaryCreateRequest();
        request.setEmpId(1L); request.setSalaryYearMonth("2027-02");
        request.setBaseSalary(new BigDecimal("3000000"));
        request.setBonus(new BigDecimal("200000"));
        request.setDeduction(new BigDecimal("150000"));
        SalaryController controller = new SalaryController(new SalaryService(new Mapper()));
        assertEquals("redirect:/salary/detail/42", controller.create(request));
    }

    @Test public void missingSalaryDoesNotReturnAnEmptyDetail() {
        SalaryController controller = new SalaryController(new SalaryService(new Mapper()));
        assertThrows(SalaryNotFoundException.class, () -> controller.detail(999L, new ExtendedModelMap()));
        ExtendedModelMap model = new ExtendedModelMap();
        SalaryNotFoundException error = new SalaryNotFoundException();
        assertEquals("salary/error", controller.handle(error, model));
        assertEquals(error.getMessage(), model.get("errorMessage"));
    }
}
