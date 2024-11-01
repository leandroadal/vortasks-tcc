package com.leandroadal.vortasks.services.social.tasks;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogSocialTasks {
    
    // ------------------------ Group Tasks ------------------------

    protected void notFoundGroupTaskById(String id) {
        log.error("Grupo de tarefas com ID: '"+ id +"' não foi encontrado!");
    }

    protected void invalidNumberUsers(String id) {
        log.error("O Grupo de tarefas com ID: '"+ id + "' recebeu com lista de usuários com tamanho fora do permito e foi recusada a alteração");
    }

    protected void addGroupTask(String id) {
        log.info("Grupo de tarefas com ID: '"+ id +"' criado com sucesso!");
    }
    
    protected void editGroupTask(String id) {
        log.info("Grupo de tarefas com ID: '"+ id +"' foi editado com sucesso!");
    }

    protected void partialEditGroupTask(String id) {
        log.info("Grupo de tarefas com ID: '"+ id +"' foi editado parcialmente com sucesso!");;
    }

    protected void deleteGroupTask(String id) {
        log.info("Grupo de tarefas com ID: '"+ id +"' foi deletado com sucesso!");
    }


    protected void createGroupTaskInvite(String inviteId) {
        log.info("Convite para tarefa em grupo criado com sucesso. ID: '{}'", inviteId);
    }

    protected void acceptGroupTaskInvite(String inviteId) {
        log.info("Convite para tarefa em grupo aceito com sucesso. ID: '{}'", inviteId);
    }

    protected void rejectGroupTaskInvite(String inviteId) {
        log.info("Convite para tarefa em grupo rejeitado com sucesso. ID: '{}'", inviteId);
    }

    protected void notFoundGroupTaskInviteById(String inviteId) {
        log.error("Convite para tarefa em grupo com ID: '{}' não encontrado!", inviteId);
    }
}
