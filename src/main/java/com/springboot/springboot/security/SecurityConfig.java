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
        .requestMatchers("/teacher/**", "/class/**").authenticated()
        .requestMatchers("/m/**").hasRole("M")
        .requestMatchers("/a/**").hasRole("A")
        .anyRequest().permitAll());

    http.csrf().disable();
    http.formLogin().loginPage("/login.do").defaultSuccessUrl("/loginSuccess.do", true);
    http.exceptionHandling().accessDeniedPage("/accessDenied.do");
    http.logout().invalidateHttpSession(true).logoutSuccessUrl("/login.do");
    http.userDetailsService(securityUserDetail);
    return http.build();
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return PasswordEncoderFactories.createDelegatingPasswordEncoder();
  }
}