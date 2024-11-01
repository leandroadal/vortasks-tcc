package com.leandroadal.vortasks.entities.backup.userprogress.dto.create;

import java.util.List;

import com.leandroadal.vortasks.entities.backup.Backup;
import com.leandroadal.vortasks.entities.backup.userprogress.Skill;
import com.leandroadal.vortasks.entities.social.tasks.enumerators.Theme;

public record SkillCreateDTO(
        String name,
        float xp,
        int level,
        List<Theme> themes) {

        
    public Skill toSkill(Backup backup) {
        Skill skill = new Skill();
        skill.setId(null);
        skill.setName(name);
        skill.setXp(xp);
        skill.setLevel(level);
        skill.setThemes(themes);
        skill.setUserBackup(backup);
        return skill;
    }
}
