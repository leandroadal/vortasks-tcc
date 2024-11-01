package com.leandroadal.vortasks.entities.backup.userprogress.dto;

import java.util.List;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Skill;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Theme;

public record SkillDTO(String id, String name, float xp, int level, List<Theme> themes) {

    public SkillDTO(Skill skill) {
        this(skill.getId(), skill.getName(), skill.getXp(), skill.getLevel(), skill.getThemes());
    }

    public Skill toSkill(Backup backup) {
        Skill skill = new Skill();
        skill.setId(id);
        skill.setName(name);
        skill.setXp(xp);
        skill.setLevel(level);
        skill.setThemes(themes);
        skill.setUserBackup(backup);
        return skill;
    }
}
