package com.hexagon.hrproject.controller;

import static org.junit.Assert.*;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import org.junit.Test;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.FieldError;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import com.hexagon.hrproject.domain.Salary;
import com.hexagon.hrproject.dto.response.SalaryEmployeeOption;
import com.hexagon.hrproject.dto.request.SalaryCreateRequest;
import com.hexagon.hrproject.exception.SalaryNotFoundException;
import com.hexagon.hrproject.mapper.SalaryMapper;
import com.hexagon.hrproject.service.SalaryService;

public class SalaryControllerTest {
    static class Mapper implements SalaryMapper {
        Salary found;
        int count, inserts;
        int employeeCount = 1;
        int employeeOptionReads;
        List<SalaryEmployeeOption> employeeOptions = Collections.singletonList(employee());
        int allReads, filterReads;
        String searchedMonth, searchedKeyword;
        List<Salary> filteredSalaries = Collections.emptyList();
        RuntimeException searchFailure;
        RuntimeException failure;
        public List<Salary> selectAll() { allReads++; return Collections.emptyList(); }
        public List<Salary> selectByFilters(String month, String keyword, Long employeeId) {
            filterReads++; searchedMonth = month; searchedKeyword = keyword;
            if (searchFailure != null) throw searchFailure;
            return filteredSalaries;
        }
        public Salary selectById(Long salaryId) { return found; }
        public List<SalaryEmployeeOption> selectEmployeeOptions() {
            employeeOptionReads++; return employeeOptions;
        }
        public int countEmployeeById(Long empId) { return employeeCount; }
        public int countByEmpAndYearMonth(Long empId, String month) { return count; }
        public int insert(Salary salary) {
            inserts++;
            if (failure != null) throw failure;
            salary.setSalaryId(42L); return 1;
        }
    }

    static SalaryEmployeeOption employee() {
        SalaryEmployeeOption employee = new SalaryEmployeeOption();
        employee.setEmpId(1L); employee.setEmployeeName("박상우"); return employee;
    }

    static SalaryCreateRequest request() {
        SalaryCreateRequest request = new SalaryCreateRequest();
        request.setEmpId(1L); request.setSalaryYearMonth("2027-03");
        request.setBaseSalary(new BigDecimal("3000000"));
        request.setBonus(new BigDecimal("200000"));
        request.setDeduction(new BigDecimal("150000"));
        return request;
    }

    @Test public void filteredListRetainsConditionsAndRecords() {
        Mapper mapper = new Mapper(); mapper.filteredSalaries = Collections.singletonList(new Salary());
        ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/list", new SalaryController(new SalaryService(mapper)).list(" 2027-01 ", " 박상 ", model));
        assertEquals("2027-01", model.get("salaryYearMonth"));
        assertEquals("박상", model.get("employeeKeyword"));
        assertEquals(Boolean.TRUE, model.get("searchApplied"));
        assertSame(mapper.filteredSalaries, model.get("salaries"));
        assertFalse(model.containsAttribute("salarySearchError"));
    }
    @Test public void resetReturnsFullListWithoutSearchConditions() {
        Mapper mapper = new Mapper(); ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/list", new SalaryController(new SalaryService(mapper)).list(null, null, model));
        assertEquals("", model.get("salaryYearMonth")); assertEquals("", model.get("employeeKeyword"));
        assertEquals(Boolean.FALSE, model.get("searchApplied")); assertEquals(1, mapper.allReads);
    }
    @Test public void invalidSearchReturnsListWithErrorAndNoRecords() {
        Mapper mapper = new Mapper(); ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/list", new SalaryController(new SalaryService(mapper)).list("2027-13", "박상", model));
        assertEquals("2027-13", model.get("salaryYearMonth"));
        assertEquals("박상", model.get("employeeKeyword"));
        assertEquals("지급 연월은 yyyy-MM 형식으로 입력하세요.", model.get("salarySearchError"));
        assertTrue(((List<?>) model.get("salaries")).isEmpty());
        assertEquals(0, mapper.allReads); assertEquals(0, mapper.filterReads);
    }
    @Test public void emptySearchResultsStillKeepTheSearchForm() {
        Mapper mapper = new Mapper(); ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/list", new SalaryController(new SalaryService(mapper)).list("2027-01", "없는사원", model));
        assertTrue(((List<?>) model.get("salaries")).isEmpty());
        assertEquals("없는사원", model.get("employeeKeyword"));
        assertFalse(model.containsAttribute("salarySearchError"));
    }
    @Test public void unrelatedSearchDatabaseFailureIsNotHidden() {
        Mapper mapper = new Mapper(); mapper.searchFailure = new DataIntegrityViolationException("test-only database error");
        assertSame(mapper.searchFailure, assertThrows(DataIntegrityViolationException.class,
                () -> new SalaryController(new SalaryService(mapper)).list("2027-01", null, new ExtendedModelMap())));
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
        Mapper mapper = new Mapper();
        SalaryController controller = new SalaryController(new SalaryService(mapper));
        assertEquals("redirect:/salary/detail/42", controller.create(request,
                new BeanPropertyBindingResult(request, "salaryCreateRequest"), new ExtendedModelMap()));
        assertEquals(0, mapper.employeeOptionReads);
    }

    @Test public void missingSalaryDoesNotReturnAnEmptyDetail() {
        SalaryController controller = new SalaryController(new SalaryService(new Mapper()));
        assertThrows(SalaryNotFoundException.class, () -> controller.detail(999L, new ExtendedModelMap()));
        ExtendedModelMap model = new ExtendedModelMap();
        SalaryNotFoundException error = new SalaryNotFoundException();
        assertEquals("salary/error", controller.handle(error, model));
        assertEquals(error.getMessage(), model.get("errorMessage"));
    }

    @Test public void initialFormDefaultsDoNotRequireHardcodedJspValues() {
        ExtendedModelMap model = new ExtendedModelMap();
        Mapper mapper = new Mapper();
        SalaryController controller = new SalaryController(new SalaryService(mapper));
        assertEquals("salary/create", controller.createForm(model));
        SalaryCreateRequest form = (SalaryCreateRequest) model.get("salaryCreateRequest");
        assertEquals(BigDecimal.ZERO, form.getBonus());
        assertEquals(BigDecimal.ZERO, form.getDeduction());
        assertNull(form.getBaseSalary());
        assertSame(mapper.employeeOptions, model.get("salaryEmployees"));
        assertEquals(1, mapper.employeeOptionReads);
    }

    @Test public void bindingFailurePreservesRejectedStringAndSkipsInsert() {
        Mapper mapper = new Mapper(); SalaryCreateRequest request = request();
        BeanPropertyBindingResult errors = new BeanPropertyBindingResult(request, "salaryCreateRequest");
        errors.addError(new FieldError("salaryCreateRequest", "empId", "abc", true,
                new String[] {"typeMismatch"}, null, "internal conversion details"));
        ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/create", new SalaryController(new SalaryService(mapper)).create(request, errors, model));
        assertEquals("abc", errors.getFieldValue("empId"));
        assertEquals(0, mapper.inserts);
        assertTrue(model.containsAttribute("errorMessage"));
        assertSame(mapper.employeeOptions, model.get("salaryEmployees"));
    }

    @Test public void unknownEmployeeReturnsFormAndPreservesEnteredValues() {
        Mapper mapper = new Mapper(); mapper.employeeCount = 0;
        SalaryCreateRequest request = request(); request.setEmpId(999999L);
        BeanPropertyBindingResult errors = new BeanPropertyBindingResult(request, "salaryCreateRequest");
        ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/create", new SalaryController(new SalaryService(mapper)).create(request, errors, model));
        assertSame(request, errors.getTarget());
        assertEquals(Long.valueOf(999999L), errors.getFieldValue("empId"));
        assertEquals(new BigDecimal("3000000"), errors.getFieldValue("baseSalary"));
        assertEquals("존재하지 않는 사원 번호입니다. 사원 번호를 확인하세요.", model.get("errorMessage"));
        assertSame(mapper.employeeOptions, model.get("salaryEmployees"));
        assertEquals(0, mapper.inserts);
    }

    @Test public void duplicateKeepsSameRequestAndErrorMessage() {
        Mapper mapper = new Mapper(); mapper.count = 1;
        SalaryCreateRequest request = request();
        BeanPropertyBindingResult errors = new BeanPropertyBindingResult(request, "salaryCreateRequest");
        ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/create", new SalaryController(new SalaryService(mapper)).create(request, errors, model));
        assertSame(request, errors.getTarget());
        assertEquals(new BigDecimal("200000"), request.getBonus());
        assertEquals("해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.", model.get("errorMessage"));
        assertSame(mapper.employeeOptions, model.get("salaryEmployees"));
        assertEquals(0, mapper.inserts);
    }

    @Test public void duplicateDuringInsertAlsoReturnsTheForm() {
        Mapper mapper = new Mapper(); mapper.failure = new DuplicateKeyException("test-only duplicate");
        SalaryCreateRequest request = request(); ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/create", new SalaryController(new SalaryService(mapper)).create(request,
                new BeanPropertyBindingResult(request, "salaryCreateRequest"), model));
        assertEquals("해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.", model.get("errorMessage"));
        assertEquals(1, mapper.inserts);
    }

    @Test public void netOverflowKeepsAmountsAndSkipsInsert() {
        Mapper mapper = new Mapper(); SalaryCreateRequest request = request();
        request.setBaseSalary(new BigDecimal("999999999999999"));
        request.setBonus(BigDecimal.ONE); request.setDeduction(BigDecimal.ZERO);
        ExtendedModelMap model = new ExtendedModelMap();
        assertEquals("salary/create", new SalaryController(new SalaryService(mapper)).create(request,
                new BeanPropertyBindingResult(request, "salaryCreateRequest"), model));
        assertEquals(new BigDecimal("999999999999999"), request.getBaseSalary());
        assertEquals("실수령액은 15자리 이내의 금액이어야 합니다.", model.get("errorMessage"));
        assertEquals(0, mapper.inserts);
    }

    @Test public void unrelatedDatabaseFailureIsNotPresentedAsAValidationError() {
        Mapper mapper = new Mapper(); mapper.failure = new DataIntegrityViolationException("test-only foreign key");
        SalaryCreateRequest request = request();
        assertSame(mapper.failure, assertThrows(DataIntegrityViolationException.class,
                () -> new SalaryController(new SalaryService(mapper)).create(request,
                        new BeanPropertyBindingResult(request, "salaryCreateRequest"), new ExtendedModelMap())));
    }
}
