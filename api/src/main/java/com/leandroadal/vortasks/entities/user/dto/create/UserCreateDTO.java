package com.leandroadal.vortasks.entities.user.dto.create;

import org.hibernate.validator.constraints.Length;

import com.leandroadal.vortasks.entities.user.User;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

public record UserCreateDTO(
        @NotEmpty(message="Preenchimento obrigatório")
	    @Length(min=5, max=120, message="O tamanho deve ser entre 5 e 120 caracteres")
        String name,

        @NotEmpty(message="Preenchimento obrigatório")
        @Size(min = 6, max = 16, message = "O username deve ter entre 6 e 16 caracteres")
        String username,

        @NotEmpty(message="Preenchimento obrigatório")
	    @Email(message="Email inválido")
        String email,

        @NotEmpty(message="Preenchimento obrigatório")
        @Size(min = 6, max = 40, message = "A senha deve ter entre 6 e 40 caracteres")
        String password) {

    public User toUser() {
        return new User(this.name, this.username, this.email, this.password);
    }
}
