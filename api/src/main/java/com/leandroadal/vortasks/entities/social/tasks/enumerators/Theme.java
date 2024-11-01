package com.leandroadal.vortasks.entities.social.tasks.enumerators;

public enum Theme {
    COLLABORATION("Colaboração"),
    LEARNING("Aprendizado"),
    WELLNESS("Bem-Estar"),
    COMMUNICATION("Comunicação"),
    CREATIVITY("Criatividade"),
    HEALTH("Saúde"),
    ORGANIZATION("Organização"),
    FINANCE("Finanças"),
    HOUSEHOLD_TASKS("Tarefas Domésticas"),
    HOBBIES("Hobbies"),
    OTHER("Outro");

    private String displayName;

    Theme(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
