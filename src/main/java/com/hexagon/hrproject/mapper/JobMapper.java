package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Job;

@Mapper
public interface JobMapper {

	// 이거 부서 Id 발급할 때 사용하는 id임
	int insert(Job job);

	int updateCode(Job job);

	// 직급 상세 조회
	Job select(@Param("jobId") int jobId);
	
	// 직급 전체 조회
	List<Job> selectAll();

	// 수정
	int updateName(@Param("jobId") int jobId, @Param("jobName") String jobName);

	// 직급 비활성화 (보통 삭제는 하지 않기에 그냥 비활성화로 해둠)
	int deactivate(@Param("jobId") int jobId);
	
	// 특정 직급 검색기능
	List<Job> search(@Param("jobName") String jobname);
}