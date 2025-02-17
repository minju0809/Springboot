package com.springboot.springboot.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
@Configuration
public class SecurityConfig {

  SecurityConfig() {
    System.out.println("==>SecurityConfig");
  }

  @Autowired
  SecurityUserDetailsService securityUserDetail;

  @SuppressWarnings("removal")
  @Bean
  SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

    http.authorizeHttpRequests(authorize -> authorize
        .requestMatchers("/a/**").hasAuthority("ROLE_ADMIN")
        .requestMatchers("/m/**").hasAnyAuthority("ROLE_MEMBER", "ROLE_ADMIN")
        .requestMatchers("/teacher/**", "/class/**").authenticated()
        .anyRequest().permitAll());

    http.csrf(csrf -> csrf.disable());
    http.formLogin(login -> login.loginPage("/login.do").defaultSuccessUrl("/loginSuccess.do", true));
    http.exceptionHandling(handling -> handling.accessDeniedPage("/accessDenied.do"));
    http.logout(logout -> logout.invalidateHttpSession(true).logoutSuccessUrl("/login.do"));
    http.userDetailsService(securityUserDetail);
    return http.build();
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return PasswordEncoderFactories.createDelegatingPasswordEncoder();
  }
}