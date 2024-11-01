package com.leandroadal.vortasks.services.shop.validation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

@Constraint(validatedBy = PercentageRangeValidator.class)
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Documented
public @interface PercentageRange {
    float min() default 0.0f;
    float max() default 100.0f;
    String message() default "A porcentagem de desconto deve ser entre {min} e {max}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}

