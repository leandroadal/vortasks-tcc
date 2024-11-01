package com.leandroadal.vortasks.services.shop.products;

import java.util.List;
import java.util.function.Consumer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.shop.product.GemsPackage;
import com.leandroadal.vortasks.repositories.shop.GemsPackageRepository;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;

import jakarta.transaction.Transactional;

@Service
public class GemsPackageService {

    @Autowired
    private GemsPackageRepository gemsPackageRepository;

    @Autowired
    private LogGemsPackage log;

    public List<GemsPackage> getAllGemsPackages() {
        return gemsPackageRepository.findAll();
    }

    public Page<GemsPackage> findPage(Integer page, Integer linesPerPage, String orderBy, String direction) {
        PageRequest pageRequest = PageRequest.of(page, linesPerPage, Direction.valueOf(direction), orderBy);
        return gemsPackageRepository.findAll(pageRequest);
    }

    public GemsPackage getGemsPackageById(Long id) {
        try {
            return gemsPackageRepository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (ObjectNotFoundException e) {
            log.logGemsPackageNotFind(id);
            throw e;
        }
    }

    public GemsPackage addGemsPackage(GemsPackage gemsPack) {
        saveGemsPackage(gemsPack);
        log.logGemsPackageCreation(gemsPack.getId());
        return gemsPack;
    }

    @Transactional
    public GemsPackage editGemsPackage(GemsPackage data) {
        GemsPackage newPackage = getGemsPackageById(data.getId());
        applyUpdates(newPackage, data);
        saveGemsPackage(newPackage);
        log.logGemsPackageEdit(data.getId());
        return newPackage;
    }

    @Transactional
    public GemsPackage partialEditGemsPackage(GemsPackage data) {
        GemsPackage newPackage = getGemsPackageById(data.getId());
        applyPartialUpdates(newPackage, data);
        saveGemsPackage(newPackage);
        log.logGemsPackagePartialEdit(data.getId());
        return newPackage;
    }

    public void deleteGemsPackage(Long id) {
        getGemsPackageById(id);
        gemsPackageRepository.deleteById(id);
        log.logGemsPackageDelete(id);
    }

    private void saveGemsPackage(GemsPackage gemsPackage) {
        gemsPackageRepository.save(gemsPackage);
    }

    private void applyUpdates(GemsPackage newPackage, GemsPackage data) {
        newPackage.setGems(data.getGems());
        newPackage.setNameOfPackage(data.getNameOfPackage());
        newPackage.setMoney(data.getMoney());
        newPackage.setIcon(data.getIcon());
        newPackage.setDiscountPercentage(data.getDiscountPercentage());
    }

    private void applyPartialUpdates(GemsPackage gemsPackage, GemsPackage data) {
        updateFieldIfNotNull(gemsPackage::setNameOfPackage, data.getNameOfPackage());
        updateFieldIfNotNull(gemsPackage::setMoney, data.getMoney());
        updateFieldIfNotNull(gemsPackage::setIcon, data.getIcon());
        updateFieldIfPositive(gemsPackage::setGems, data.getGems());
        updateFieldIfPositive(gemsPackage::setDiscountPercentage, data.getDiscountPercentage());
    }

    private <T> void updateFieldIfNotNull(Consumer<T> setter, T value) {
        if (value != null) {
            setter.accept(value);
        }
    }

    private <T extends Number> void updateFieldIfPositive(Consumer<T> setter, T value) {
        if (value != null && value.doubleValue() > 0) {
            setter.accept(value);
        }
    }

}
