package com.leandroadal.vortasks.services.shop.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PercentageRangeValidator implements ConstraintValidator<PercentageRange, Float> {
    private float min;
    private float max;

    @Override
    public void initialize(PercentageRange constraintAnnotation) {
        this.min = constraintAnnotation.min();
        this.max = constraintAnnotation.max();
    }

    @Override
    public boolean isValid(Float value, ConstraintValidatorContext context) {
        if (value == null) {
            return false; // null é considerado falso
        }
        return value >= min && value <= max;
    }
    
}
