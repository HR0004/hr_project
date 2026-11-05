package com.hexagon.hrproject.common.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pager {

    private List<?> list;

    private int totalCount;
    private int pageSize = 10;
    private int totalPage;
    private int blockSize = 10;

    private int currentPage = 1;
    private int firstPage;
    private int lastPage;
    private int num;
    private int offset;

    public void init(HttpServletRequest request) {

        // 1. 총 페이지 수 계산
        totalPage = (int) Math.ceil((double) totalCount / pageSize);

        // 2. 사용자가 요청한 현재 페이지
        currentPage = 1;

        String pageParam = request.getParameter("currentPage");

        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // 3. 페이지 범위 보정
        if (currentPage < 1) {
            currentPage = 1;
        }

        if (totalPage > 0 && currentPage > totalPage) {
            currentPage = totalPage;
        }

        // 4. 페이지 블록 계산
        firstPage = currentPage - (currentPage - 1) % blockSize;

        lastPage = firstPage + (blockSize - 1);

        if (lastPage > totalPage) {
            lastPage = totalPage;
        }

        // 5. DB 조회 시작 위치
        offset = (currentPage - 1) * pageSize;

        // 6. 목록 번호
        num = totalCount - offset;
    }
}