package com.leandroadal.vortasks.controllers.user;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.leandroadal.vortasks.controllers.user.doc.ProgressSwagger;
import com.leandroadal.vortasks.entities.user.ProgressData;
import com.leandroadal.vortasks.entities.user.dto.ProgressDataRequestDTO;
import com.leandroadal.vortasks.entities.user.dto.ProgressDataResponseDTO;
import com.leandroadal.vortasks.services.user.ProgressDataService;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping(value = "/user/progress")
public class ProgressController {

    @Autowired
    private ProgressDataService service;

    @GetMapping
    @ProgressSwagger.GetProgressSwagger
    public ResponseEntity<ProgressDataResponseDTO> getProgress() {
        ProgressData progress = service.getProgress();
        return ResponseEntity.ok(new ProgressDataResponseDTO(progress));
    }
    
    @GetMapping("/latest")
    @ProgressSwagger.GetLatestProgressSwagger
    public ResponseEntity<ProgressDataResponseDTO> moreRecentProgress(@RequestParam String lastModified) {
        ProgressData progress = service.latestProgress(lastModified);
        return ResponseEntity.ok(new ProgressDataResponseDTO(progress));
    }

    @PutMapping
    @ProgressSwagger.UpdateProgressSwagger
    public ResponseEntity<ProgressDataResponseDTO> updateProgress(@Valid @RequestBody ProgressDataRequestDTO data) {
        ProgressData progress = service.editProgress(data.toProgressData(null));
        return ResponseEntity.ok(new ProgressDataResponseDTO(progress));
    }

    @PatchMapping
    @ProgressSwagger.UpdatePartialProgressSwagger
    public ResponseEntity<ProgressDataResponseDTO> updatePartialProgress(@RequestBody ProgressDataRequestDTO data) {
        ProgressData progress = service.partialEditProgress(data.toProgressData(null));
        return ResponseEntity.ok(new ProgressDataResponseDTO(progress));
    }

    @DeleteMapping
    @ProgressSwagger.DeleteProgressSwagger
    public ResponseEntity<Object> deleteProgress() {
        service.deleteProgress();
        return ResponseEntity.noContent().build();
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PutMapping("/{id}")
    @ProgressSwagger.UpdateProgressSwagger
    public ResponseEntity<ProgressDataResponseDTO> adminUpdateProgress(@PathVariable String id, @Valid @RequestBody ProgressDataRequestDTO data) {
        ProgressData progress = service.adminEditProgress(data.toProgressData(id));
        return ResponseEntity.ok(new ProgressDataResponseDTO(progress));
    }
}
