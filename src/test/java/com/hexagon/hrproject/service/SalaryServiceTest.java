package com.hexagon.hrproject.service;

import static org.junit.Assert.*;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import org.junit.Test;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import com.hexagon.hrproject.domain.Salary;
import com.hexagon.hrproject.dto.request.SalaryCreateRequest;
import com.hexagon.hrproject.exception.SalaryBusinessException;
import com.hexagon.hrproject.mapper.SalaryMapper;

public class SalaryServiceTest {
    static class Mapper implements SalaryMapper {
        int count, inserts, result = 1;
        RuntimeException failure;
        Salary inserted;
        public List<Salary> selectAll() { return Collections.emptyList(); }
        public int countByEmpAndYearMonth(Long empId, String month) { return count; }
        public int insert(Salary salary) {
            inserts++;
            if (failure != null) throw failure;
            inserted = salary;
            salary.setSalaryId(42L);
            return result;
        }
    }
    static SalaryCreateRequest request() {
        SalaryCreateRequest r = new SalaryCreateRequest();
        r.setEmpId(1L); r.setSalaryYearMonth("2027-01");
        r.setBaseSalary(new BigDecimal("3000000"));
        r.setBonus(new BigDecimal("200000")); r.setDeduction(new BigDecimal("150000"));
        return r;
    }
    @Test public void successfulInsertReturnsGeneratedIdAndCalculatedAmount() {
        Mapper m = new Mapper();
        assertEquals(Long.valueOf(42), new SalaryService(m).createSalary(request()));
        assertEquals(new BigDecimal("3050000"), m.inserted.getNetSalary());
        assertNull(m.inserted.getPaymentDate());
    }
    @Test public void existingSalaryStopsBeforeInsert() {
        Mapper m = new Mapper(); m.count = 1;
        SalaryBusinessException e = assertThrows(SalaryBusinessException.class,
                () -> new SalaryService(m).createSalary(request()));
        assertEquals("해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.", e.getMessage());
        assertEquals(0, m.inserts);
    }
    @Test public void duplicateAfterSuccessfulPrecheckIsTranslatedWithCause() {
        Mapper m = new Mapper(); m.failure = new DuplicateKeyException("test-only duplicate");
        SalaryBusinessException e = assertThrows(SalaryBusinessException.class,
                () -> new SalaryService(m).createSalary(request()));
        assertEquals("해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.", e.getMessage());
        assertSame(m.failure, e.getCause()); assertEquals(1, m.inserts);
    }
    @Test public void unrelatedIntegrityFailureIsNotReportedAsDuplicate() {
        Mapper m = new Mapper(); m.failure = new DataIntegrityViolationException("test-only foreign key");
        assertSame(m.failure, assertThrows(DataIntegrityViolationException.class,
                () -> new SalaryService(m).createSalary(request())));
    }
    @Test public void zeroAffectedRowsRemainBusinessFailure() {
        Mapper m = new Mapper(); m.result = 0;
        assertEquals("급여 등록에 실패했습니다.", assertThrows(SalaryBusinessException.class,
                () -> new SalaryService(m).createSalary(request())).getMessage());
    }
    @Test public void maximumAmountStillAccepted() {
        Mapper m = new Mapper(); SalaryCreateRequest r = request();
        r.setBaseSalary(new BigDecimal("999999999999999"));
        r.setBonus(BigDecimal.ZERO); r.setDeduction(BigDecimal.ZERO);
        new SalaryService(m).createSalary(r);
        assertEquals(new BigDecimal("999999999999999"), m.inserted.getNetSalary());
    }
    @Test public void overflowStillRejectedBeforeInsert() {
        Mapper m = new Mapper(); SalaryCreateRequest r = request();
        r.setBaseSalary(new BigDecimal("999999999999999"));
        r.setBonus(BigDecimal.ONE); r.setDeduction(BigDecimal.ZERO);
        assertThrows(SalaryBusinessException.class, () -> new SalaryService(m).createSalary(r));
        assertEquals(0, m.inserts);
    }
    @Test public void missingRequestStillRejected() {
        assertThrows(SalaryBusinessException.class, () -> new SalaryService(new Mapper()).createSalary(null));
    }
}
