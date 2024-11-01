package com.leandroadal.vortasks.repositories.backup;

import org.springframework.data.jpa.repository.JpaRepository;

import com.leandroadal.vortasks.entities.backup.userprogress.Skill;

public interface SkillRepository  extends JpaRepository<Skill, String> {

}
