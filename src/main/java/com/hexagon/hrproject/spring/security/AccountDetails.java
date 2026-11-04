package com.hexagon.hrproject.spring.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.HrRole;
import com.hexagon.hrproject.domain.Permission;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
public class AccountDetails implements UserDetails {

	private Account account;

	// 보유 권한 모아놓을 컬렉션
	private List<GrantedAuthority> authorities;

	public AccountDetails(Account account) {
		this.account = account;

		Set<GrantedAuthority> authSet = new LinkedHashSet<>();

		for (HrRole hrRole : account.getRoles()) {
			log.debug("현재 role={}", hrRole.getRoleCode());
			authSet.add(new SimpleGrantedAuthority(hrRole.getRoleCode()));

			for (Permission permission : hrRole.getPermissions()) {
				log.debug("소속 permission은{}", permission.getPermissionCode());
				authSet.add(new SimpleGrantedAuthority(permission.getPermissionCode()));
			}
		}
		authorities = new ArrayList<>(authSet);
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub

		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return account.getPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return account.getLoginId();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return account.getEnabled()==1;
	}

}
