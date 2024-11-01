package com.leandroadal.vortasks.controllers.shop.products;

import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.leandroadal.vortasks.controllers.shop.products.doc.GemsDocSwagger;
import com.leandroadal.vortasks.entities.shop.dto.GemsPackRequestDTO;
import com.leandroadal.vortasks.entities.shop.dto.GemsPackResponseDTO;
import com.leandroadal.vortasks.entities.shop.product.GemsPackage;
import com.leandroadal.vortasks.services.shop.products.GemsPackageService;

import jakarta.validation.Valid;

@RestController
@RequestMapping(value = "/shop/gemsPackage")
public class GemsController {

    @Autowired
    private GemsPackageService service;

    @GetMapping("/page")
    @GemsDocSwagger.FindPageGemsPackageSwagger
    public ResponseEntity<Page<GemsPackResponseDTO>> findPage(
            @RequestParam(value = "page", defaultValue = "0") Integer page,
            @RequestParam(value = "linesPerPage", defaultValue = "10") Integer linesPerPage,
            @RequestParam(value = "orderBy", defaultValue = "nameOfPackage") String orderBy,
            @RequestParam(value = "direction", defaultValue = "ASC") String direction) {

        Page<GemsPackage> list = service.findPage(page, linesPerPage, orderBy, direction);
        Page<GemsPackResponseDTO> listDto = list.map(obj -> new GemsPackResponseDTO(obj));
        return ResponseEntity.ok(listDto);
    }

    @GetMapping("/{gemsPackageId}")
    @GemsDocSwagger.GetGemsPackageSwagger
    public ResponseEntity<GemsPackResponseDTO> getGemsPackage(@PathVariable Long gemsPackageId) {
        GemsPackage gemsPackage = service.getGemsPackageById(gemsPackageId);
        return ResponseEntity.ok(new GemsPackResponseDTO(gemsPackage));
    }

    // ================= ADMIN ===================

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping
    @GemsDocSwagger.CreateGemsPackageSwagger
    public ResponseEntity<String> createGemsPackage(@Valid @RequestBody GemsPackRequestDTO gemsDTO) {
        GemsPackage data = gemsDTO.toGemsPackage();
        GemsPackage newPackage = service.addGemsPackage(data);

        URI uri = ServletUriComponentsBuilder.fromCurrentRequest()
                .replacePath("/shop/gemsPackage/{gemsPackageId}")
                .buildAndExpand(newPackage.getId())
                .toUri();
        return ResponseEntity.created(uri).build();
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping
    @GemsDocSwagger.GetAllGemsPackageSwagger
    public ResponseEntity<List<GemsPackResponseDTO>> getAllGemsPackage() {
        List<GemsPackage> gemsPackage = service.getAllGemsPackages();
        return ResponseEntity.ok(gemsPackage.stream()
                .map(GemsPackResponseDTO::new)
                .toList());
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PutMapping("/{id}")
    @GemsDocSwagger.PartialEditGemsPackageSwagger
    public ResponseEntity<GemsPackResponseDTO> editGemsPackage(@PathVariable Long id,
            @Valid @RequestBody GemsPackRequestDTO gemsDTO) {

        GemsPackage data = gemsDTO.toGemsPackage();
        data.setId(id);
        GemsPackage newGemsPackage = service.editGemsPackage(data);
        return ResponseEntity.ok(new GemsPackResponseDTO(newGemsPackage));
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PatchMapping("/{id}")
    @GemsDocSwagger.PartialEditGemsPackageSwagger
    public ResponseEntity<GemsPackResponseDTO> partialUpdateGemsPackage(@PathVariable Long id,
            @RequestBody GemsPackRequestDTO gemsDTO) {

        GemsPackage data = gemsDTO.toGemsPackage();
        data.setId(id);
        GemsPackage newGemsPackage = service.partialEditGemsPackage(data);
        return ResponseEntity.ok(new GemsPackResponseDTO(newGemsPackage));
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @DeleteMapping("/{id}")
    @GemsDocSwagger.DeleteGemsPackageSwagger
    public ResponseEntity<String> deleteGemsPackage(@PathVariable Long id) {
        service.deleteGemsPackage(id);
        return ResponseEntity.noContent().build();
    }
}
