package com.leandroadal.vortasks.security;

import java.io.IOException;
import java.time.Instant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leandroadal.vortasks.controllers.exceptions.StandardError;
import com.leandroadal.vortasks.services.auth.UserDetailsServiceImpl;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SecurityFilter extends OncePerRequestFilter {

    @Autowired
    private JWTService jwtService;

    @Autowired
    private UserDetailsServiceImpl authService;

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) {
        try {
            log.info("Iniciando filtro de segurança...");
            String token = recoverToken(request);
            if (token != null) {
                log.debug("Token recuperado com sucesso: {}", token);
                String login = jwtService.validateToken(token);
                log.debug("Token validado com sucesso para o login: {}", login);
                UserDetails userDetails = authService.loadUserByUsername(login);

                if (userDetails != null) {
                    UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null,
                            userDetails.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                    log.debug("Autenticação do usuário configurada com sucesso para: {}", login);
                }
            }
            filterChain.doFilter(request, response);
            log.info("Filtro de segurança concluído.");
        } catch (Exception e) {
            handleError(request, response, e);
            return;
        }

    }

    private String recoverToken(HttpServletRequest request) {
        var authHeader = request.getHeader("Authorization");
        if (authHeader == null)
            return null;
        return authHeader.replace("Bearer ", "");
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e) {
        HttpStatus status;
        String error;

        if (e instanceof JWTException) {
            status = HttpStatus.FORBIDDEN;
            error = "Token inválido";
        } else {
            status = HttpStatus.INTERNAL_SERVER_ERROR;
            error = "Erro interno no servidor";
        }   
        log.error("Erro: " + error, e);
        sendErrorResponse(request, response, status, error, e);
    }

    private void sendErrorResponse(HttpServletRequest request, HttpServletResponse response, HttpStatus status, String error, Exception e) {
        response.setStatus(status.value());
        response.setContentType("application/json;charset=UTF-8");

        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(), request.getRequestURI());
        try {
            String errorJson = objectMapper.writeValueAsString(err);
            response.getWriter().write(errorJson);
            response.getWriter().flush();
        } catch (IOException ex) {
            log.error("Erro ao enviar resposta de erro", ex);
            response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }
    }

    /*
     * private UserDetails buildUserDetails(String login) {
     * if (!login.isEmpty()) {
     * User user = userRepository.findByUsername(login).orElseThrow();
     * if (user != null) {
     * return new UserSS(user.getId(), user.getUsername(), user.getPassword(),
     * user.getRole());
     * }
     * }
     * return null;
     * }
     */

}
