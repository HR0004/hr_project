package com.hexagon.hrproject.domain;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Account {

   private int accountId;
   private Emp emp;
   private String loginId;
   private String password;
   private int enabled;
   private LocalDateTime createdAt;
   private LocalDateTime lastLoginAt;
   
   //한명의 사원 계정은 여러개의 롤을 보유할 수 있음
   private List<HrRole> roles;
}
