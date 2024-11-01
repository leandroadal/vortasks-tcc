package com.leandroadal.vortasks.entities.social.tasks.enumerators;

public enum Difficulty {
    EASY("Fácil"),
    MEDIUM("Médio"),
    HARD("Difícil"),
    VERY_HARD("Muito Difícil");

    private final String description;

    Difficulty(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
