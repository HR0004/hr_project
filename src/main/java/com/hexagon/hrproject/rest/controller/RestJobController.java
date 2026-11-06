package com.hexagon.hrproject.rest.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.common.response.ApiResponse;
import com.hexagon.hrproject.common.web.Pager;
import com.hexagon.hrproject.domain.Job;
import com.hexagon.hrproject.dto.JobDTO;
import com.hexagon.hrproject.service.JobService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestJobController {

	private final JobService jobService;

	@PostMapping("/api/jobs")
	public ResponseEntity<ApiResponse<Void>> regist(@RequestBody JobDTO jobDTO) {

		jobService.regist(jobDTO);

		ApiResponse<Void> response = ApiResponse.success("직급 등록 성공", null);

		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}

	@GetMapping("/api/jobs")
	public ResponseEntity<ApiResponse<List<Job>>> getList() {
		List<Job> jobList = jobService.getList();

		ApiResponse<List<Job>> response = ApiResponse.success("직급 목록 가져오기 성공", jobList);

		return ResponseEntity.status(HttpStatus.OK).body(response);

	}

	@GetMapping("/api/jobs/{jobId}")
	public ResponseEntity<ApiResponse<Job>> getDetail(@PathVariable int jobId) {

		Job job = jobService.getDetail(jobId);

		ApiResponse<Job> response = ApiResponse.success("직급 상세 조회 성공", job);

		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	@GetMapping("/api/jobs/search")
	public ResponseEntity<ApiResponse<List<Job>>> search(
			@RequestParam(value = "jobName", required = false) String jobName) {

		List<Job> jobList = jobService.search(jobName);

		ApiResponse<List<Job>> response = ApiResponse.success("직급 검색 성공", jobList);

		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	@PutMapping("/api/jobs/{jobId}")
	public ResponseEntity<ApiResponse<Void>> update(@PathVariable int jobId, @RequestBody JobDTO jobDTO) {
		jobService.update(jobId, jobDTO);

		ApiResponse<Void> response = ApiResponse.success("직급 수정 성공", null);

		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	// 직급 비활성화
	@DeleteMapping("/api/jobs/{jobId}")
	public ResponseEntity<ApiResponse<Void>> deactivity(@PathVariable int jobId) {

		jobService.deactivity(jobId);

		ApiResponse<Void> response = ApiResponse.success("직급 비활성화 성공", null);

		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	// 직급 페이징 목록 조회
	@GetMapping("/api/jobs/page")
	public ResponseEntity<ApiResponse<Pager>> getPageList(HttpServletRequest request) {

		// Service에서 페이지 계산 및 목록 조회
		Pager pager = jobService.getPageList(request);

		// 공통 API 응답 생성
		ApiResponse<Pager> response = ApiResponse.success("직급 페이지 조회 성공", pager);

		return ResponseEntity.ok(response);
	}

}
