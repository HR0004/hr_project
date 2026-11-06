
package com.hexagon.hrproject.mapper;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.hexagon.hrproject.dto.response.DepartmentAttendanceRow;

@Mapper
public interface DepartmentAttendanceMapper {

    // 로그인 사용자의 소속 부서 ID 조회
    @Select({
        "SELECT e.department_id",
        "FROM account ac",
        "JOIN emp e ON ac.emp_id = e.emp_id",
        "WHERE ac.login_id = #{loginId}"
    })
    Integer findDepartmentIdByLoginId(
        @Param("loginId") String loginId
    );

    // 부서별 직원 근태 조회
    @Select({
        "<script>",
        "SELECT",
        "    e.emp_id AS empId,",
        "    e.ename AS name,",
        "    e.department_id AS departmentId,",
        "    DATE_FORMAT(#{workDate}, '%Y-%m-%d') AS date,",
        "    DATE_FORMAT(a.clock_in, '%H:%i') AS clockIn,",
        "    DATE_FORMAT(a.clock_out, '%H:%i') AS clockOut,",

        "    CASE",
        "        WHEN a.attendance_id IS NOT NULL THEN",
        "            COALESCE(NULLIF(a.status, ''), 'UNKNOWN')",

        "        WHEN EXISTS (",
        "            SELECT 1",
        "            FROM leave_request lr",
        "            WHERE lr.emp_id = e.emp_id",
        "              AND lr.status = 'APPROVED'",
        "              AND #{workDate}",
        "                  BETWEEN lr.start_date AND lr.end_date",
        "        ) THEN 'LEAVE'",

        "        ELSE 'UNKNOWN'",
        "    END AS status,",

        "    CASE",
        "        WHEN a.attendance_id IS NOT NULL",
        "            THEN '출퇴근 기록'",

        "        WHEN EXISTS (",
        "            SELECT 1",
        "            FROM leave_request lr",
        "            WHERE lr.emp_id = e.emp_id",
        "              AND lr.status = 'APPROVED'",
        "              AND #{workDate}",
        "                  BETWEEN lr.start_date AND lr.end_date",
        "        ) THEN '승인된 휴가'",

        "        ELSE '근태 기록 없음'",
        "    END AS note",

        "FROM emp e",

        "LEFT JOIN tb_attendance a",
        "    ON a.attendance_id = (",
        "        SELECT MAX(a2.attendance_id)",
        "        FROM tb_attendance a2",
        "        WHERE a2.emp_id = e.emp_id",
        "          AND a2.work_date = #{workDate}",
        "    )",

        "WHERE e.status = 'ACTIVE'",

        "<if test='departmentId != null'>",
        "    AND e.department_id = #{departmentId}",
        "</if>",

        "ORDER BY e.department_id, e.emp_id",
        "</script>"
    })
    List<DepartmentAttendanceRow> findDepartmentAttendance(
        @Param("departmentId") Integer departmentId,
        @Param("workDate") LocalDate workDate
    );
}
