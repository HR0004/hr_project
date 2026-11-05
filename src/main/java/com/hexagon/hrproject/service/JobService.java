package com.hexagon.hrproject.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

		if (name == null || name.trim().isEmpty()) {
			throw new IllegalArgumentException("직급명을 입력하세요.");
		}

		Job job = new Job();
		job.setJobName(name.trim());

		// MySQL에서 ID 자동 생성
		int result = jobMapper.insert(job);

		if (result != 1) {
			throw new IllegalStateException("직급 등록 실패");
		}

		// 최초 등록 시 코드 생성
		String code = String.format("JOB%04d", job.getJobId());

		job.setJobCode(code);

		if (jobMapper.updateCode(job) != 1) {
			throw new IllegalStateException("직급 코드 저장 실패");
		}
		
		if (name == null || name.trim().isEmpty()) {
		    throw new BusinessException(ErrorCode.INVALID_INPUT);
		}

		if (jobMapper.countByName(name.trim()) > 0) {
		    throw new BusinessException(ErrorCode.JOB_ALREADY_EXISTS);
		}

		return result;
	}

	// 직급 목록 조회
	public List<Job> getList() {
		return jobMapper.selectAll();
	}

	// 직급 상세 조회
	public Job getDetail(int jobId) {

		Job job = jobMapper.select(jobId);

		if (job == null) {
			throw new IllegalArgumentException("직급을 찾을 수 없습니다.");
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
			throw new IllegalStateException("비활성 직급은 수정할 수 없습니다.");
		}

		String name = dto == null ? null : dto.getJobName();

		if (name == null || name.trim().isEmpty()) {
			throw new IllegalArgumentException("직급명을 입력하세요.");
		}

		int result = jobMapper.updateName(jobId, name.trim());

		if (result != 1) {
			throw new IllegalStateException("직급 수정 실패");
		}

		return result;
	}

	// 직급 비활성화
	@Transactional
	public int deactivity(int jobId) {

		Job job = getDetail(jobId);

		if (job.getIsActive() != 1) {
			throw new IllegalStateException("이미 비활성화된 직급입니다.");
		}

		int result = jobMapper.deactivate(jobId);

		if (result != 1) {
			throw new IllegalStateException("직급 비활성화 실패");
		}

		return result;
	}
}
