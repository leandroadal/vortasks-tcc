package com.leandroadal.vortasks.services.shop.products;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import com.leandroadal.vortasks.entities.shop.product.Category;
import com.leandroadal.vortasks.repositories.shop.CategoryRepository;
import com.leandroadal.vortasks.services.exception.DatabaseException;
import com.leandroadal.vortasks.services.exception.ObjectNotFoundException;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository repository;

    @Autowired
    private LogCategory log;

    public List<Category> getAllCategories() {
        return repository.findAll();
    }

    public List<Category> getAllByIds(List<Integer> categoryIds) {
        return repository.findAllById(categoryIds);
    }

    public Category categoryById(Integer id) {
        try {
            return repository.findById(id).orElseThrow(() -> new ObjectNotFoundException(id));
        } catch (ObjectNotFoundException e) {
            log.categoryNotFound(id);
            throw e;
        }
    }

    public Category addCategory(Category data) {
        saveCategory(data);
        log.logAddCategory(data.getId());
        return data;
    }

    public Category editCategory(Category data) {
        Category category = categoryById(data.getId());
        updateData(category, data);
        saveCategory(category);
        log.logCategoryEdit(data.getId());
        return category;
    }

    private void updateData(Category category, Category data) {
        category.setName(data.getName());
    }

    public void deleteCategory(Integer id) {
        try {
            categoryById(id);
            repository.deleteById(id);
            log.logCategoryDelete(id);
        } catch (DataIntegrityViolationException e) {
            log.logCategoryDeleteFailed(id);
			throw new DatabaseException(e.getMessage());
		}
    }

    protected void saveCategory(Category data) {
        repository.save(data);
    }

}
