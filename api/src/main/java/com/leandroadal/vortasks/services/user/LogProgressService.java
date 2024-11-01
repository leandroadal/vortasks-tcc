package com.leandroadal.vortasks.services.user;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogProgressService {
    
    protected void notFoundProgressById(String progressId) {
        log.error("Os dados de progresso com ID: '" + progressId + "' não foram encontrados!");
    }

    protected void notFoundProgressByUserId(String userId) {
        log.error("Os dados de progresso do usuário com ID: '" + userId + "' não foram encontrados!");
    }

    protected void editProgress(String id) {
        log.info("A Edição dos dados de progresso com ID: '" + id + "' foi concluída com sucesso!");
    }

    protected void partialEditProgress(String id) {
        log.info("A Edição parcial dos dados de progresso com ID: '" + id + "' foi concluída com sucesso!");
    }

    protected void deleteProgress(String id) {
        log.info("O apagamento dos dados de progresso com ID: '" + id + "' foi concluído com sucesso!");
    }

    protected void progressDeleteFailed(String id) {
        log.info("O apagamento dos dados de progresso com ID: '" + id + "' falhou!");
    }

    protected void progressNotModified(String userId) {
        log.info("Dados de progresso mais recentes não encontrado para o usuário {}", userId);
    }

    protected void progressRetrievalSuccess(String userId) {
        log.info("Dados mais recentes de progresso do usuário {} retornado com sucesso", userId);
    }
}
