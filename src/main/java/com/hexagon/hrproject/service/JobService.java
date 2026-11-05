
package com.hexagon.hrproject.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.common.web.Pager;
import com.hexagon.hrproject.domain.Job;
import com.hexagon.hrproject.dto.JobDTO;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.mapper.JobMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JobService {

    private final JobMapper jobMapper;

    // 직급 등록
    @Transactional
    public int regist(JobDTO jobDTO) {

        String name = jobDTO == null ? null : jobDTO.getJobName();

        // 1. 입력값 검사
        if (name == null || name.trim().isEmpty()) {
            throw new BusinessException(ErrorCode.JOB_NAME_REQUIRED);
        }

        name = name.trim();

        // 2. 직급명 중복 검사
        if (jobMapper.countByName(name) > 0) {
        	System.out.println("직급 중복 검사 실행됨: " + name);
            throw new BusinessException(ErrorCode.JOB_ALREADY_EXISTS);
        }

        // 3. 직급 등록
        Job job = new Job();
        job.setJobName(name);

        int result = jobMapper.insert(job);

        if (result != 1) {
            throw new BusinessException(ErrorCode.JOB_REGIST_FAIL);
        }

        // 4. 직급 코드 자동 생성
        String code = String.format("JOB%04d", job.getJobId());
        job.setJobCode(code);

        if (jobMapper.updateCode(job) != 1) {
            throw new BusinessException(
                ErrorCode.JOB_CODE_GENERATION_FAIL
            );
        }

        return result;
    }

    // 직급 목록 조회
    public List<Job> getList() {
        return jobMapper.selectAll();
    }
    

 // 직급 페이징 목록 조회
    public Pager getPageList(HttpServletRequest request) {

        Pager pager = new Pager();

        // 전체 직급 수
        pager.setTotalCount(jobMapper.countAll());

        // 현재 페이지, offset 계산
        pager.init(request);

        // 현재 페이지 데이터
        List<Job> jobList = jobMapper.selectPage(
            pager.getOffset(),
            pager.getPageSize()
        );

        pager.setList(jobList);

        return pager;
    }


    // 직급 상세 조회
    public Job getDetail(int jobId) {

        Job job = jobMapper.select(jobId);

        if (job == null) {
            throw new BusinessException(ErrorCode.JOB_NOT_FOUND);
        }

        return job;
    }

    // 직급 검색
    public List<Job> search(String jobName) {

        if (jobName == null || jobName.trim().isEmpty()) {
            return jobMapper.selectAll();
        }

        return jobMapper.search(jobName.trim());
    }

    // 직급 수정
    @Transactional
    public int update(int jobId, JobDTO dto) {

        Job job = getDetail(jobId);

        if (job.getIsActive() != 1) {
            throw new BusinessException(
                ErrorCode.JOB_INACTIVE_UPDATE
            );
        }

        String name = dto == null ? null : dto.getJobName();

        if (name == null || name.trim().isEmpty()) {
            throw new BusinessException(ErrorCode.JOB_NAME_REQUIRED);
        }

        name = name.trim();

        // 자기 자신은 제외하고 동일한 직급명이 있는지 확인
        if (jobMapper.countByNameExcludingId(name, jobId) > 0) {
            throw new BusinessException(ErrorCode.JOB_ALREADY_EXISTS);
        }

        int result = jobMapper.updateName(jobId, name);

        if (result != 1) {
            throw new BusinessException(ErrorCode.JOB_UPDATE_FAIL);
        }

        return result;
    }

    // 직급 비활성화
    @Transactional
    public int deactivity(int jobId) {

        Job job = getDetail(jobId);

        if (job.getIsActive() != 1) {
            throw new BusinessException(
                ErrorCode.JOB_ALREADY_INACTIVE
            );
        }

        int result = jobMapper.deactivate(jobId);

        if (result != 1) {
            throw new BusinessException(ErrorCode.JOB_DELETE_FAIL);
        }

        return result;
    }
}
