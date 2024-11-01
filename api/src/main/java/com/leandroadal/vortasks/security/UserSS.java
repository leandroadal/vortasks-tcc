package com.leandroadal.vortasks.security;

import java.util.Collection;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.leandroadal.vortasks.entities.user.UserRole;

public class UserSS implements UserDetails {
    
    private String id;
	private String username;
	private String password;
	private UserRole role;
	
	public UserSS() {
	}
	
	public UserSS(String id, String username, String senha, UserRole role) {
		super();
		this.id = id;
		this.username = username;
		this.password = senha;
		this.role = role;
	}

	public String getId() {
		return id;
	}

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if(this.role == UserRole.ADMIN) return List.of(new SimpleGrantedAuthority("ROLE_ADMIN"), new SimpleGrantedAuthority("ROLE_USER"));
        else return List.of(new SimpleGrantedAuthority("ROLE_USER"));
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
