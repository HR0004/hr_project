package com.hexagon.hrproject.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.mapper.AccountMapper;
import com.hexagon.hrproject.spring.security.AccountDetails;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustormUserDetailsService implements UserDetailsService{
	private final AccountMapper accountMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		Account account = accountMapper.selectById(username);
		
		return new AccountDetails(account);
	}

	
}
