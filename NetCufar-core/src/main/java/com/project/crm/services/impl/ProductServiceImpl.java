package com.project.crm.services.impl;

import com.project.crm.dao.AttributeDao;
import com.project.crm.dao.ProductDao;
import com.project.crm.model.Product;
import com.project.crm.model.enums.ProductStatus;
import com.project.crm.services.ProductService;
import com.project.crm.validator.ProductValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.project.crm.services.GoogleDriveAPI.addPhotoToDrive;

/**
 * Implementation of {@link ProductService} interface.
 */
@Transactional
@Component
public class ProductServiceImpl implements ProductService {

    @Autowired
    ProductDao productDao;

    @Autowired
    AttributeDao attributeDao;

    @Autowired
    ProductValidator productValidator;

    @Override
    public Product getProductByHttpServletRequestAndPhoto(HttpServletRequest request, MultipartFile photo) {
        Product product = new Product();

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();

        Map<String, String[]> parameterMap = request.getParameterMap();

        product.setOwner(name);
        product.setSuperCategory(parameterMap.get("superCategory")[0]);
        product.setCategory(parameterMap.get("category")[0]);
        product.setCost(parameterMap.get("cost")[0].trim() + " " + parameterMap.get("COST_TYPE")[0]);
        product.setTitle(parameterMap.get("title")[0].trim());
        if (parameterMap.get("description")[0] != null)
            product.setDescription(parameterMap.get("description")[0].trim());
        if (photo.isEmpty())
            product.setPhoto("-1");
        else
            try {
                product.setPhoto(addPhotoToDrive(photo));
            } catch (IOException e) {
                e.printStackTrace();
            }

        List<String> attributes = attributeDao.getAttributesByCategory(parameterMap.get("category")[0]);

        Map<String, String> productAttributes = new HashMap<>();
        for (String attribute : attributes) {
            productAttributes.put(attribute, parameterMap.get(attribute)[0].trim());
        }

        product.setAttributesAndValues(productAttributes);
        return product;
    }

    @Override
    public void addProduct(Product product) {
        productDao.addProduct(product);
    }

    @Override
    public List<Product> getProductsByUsername(String username) {
        //return productDao.getProductsByUsername(username);
        return productDao.getProductsByOneParameter("OWNER", username);
    }

    @Override
    public void editProduct(Product product, MultipartFile photo) {
        if (photo.isEmpty())
            product.setPhoto("-1");
        else {
            try {
                product.setPhoto(addPhotoToDrive(photo));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        productDao.editProduct(product);
    }

    @Override
    public Product getProductById(String id) {
        return productDao.getProductById(id);
    }

    @Override
    public List<Product> getProductsByKeyWords(String keyWords) {
        return productDao.getProductsByKeyWords(keyWords);
    }

    @Override
    public List<Product> getProductsByCategory(String category) {
        //return productDao.getProductsByCategory(category);
        return productDao.getProductsByOneParameter("CATEGORY", category);
    }

    @Override
    public List<Product> getProductsBySuperCategory(String superCategory) {
        //return productDao.getProductsBySuperCategory(superCategory);
        return productDao.getProductsByOneParameter("SUPERCATEGORY", superCategory);
    }

    @Override
    public List<Product> getProductsByStatus(ProductStatus status) {
        //return productDao.getProductsByStatus(status);
        return productDao.getProductsByOneParameter("STATUS", status.name());
    }

    @Override
    public List<Product> getAllProducts() {
        return productDao.getAllProducts();
    }

    @Override
    public void deleteProductById(String id) {
        productDao.deleteProductById(id);
    }

    @Override
    public void changeProductStatus(String id, ProductStatus status) {
        productDao.changeProductStatus(id, status);
    }

    @Override
    public List<Product> getProductsByOneParameter(String attribute, String val) {
        return productDao.getProductsByOneParameter(attribute, val);
    }

    @Override
    public List<Product> getProductsByTwoParameters(String attribute1, String val1, String attribute2, String val2) {
        return productDao.getProductsByTwoParameters(attribute1, val1, attribute2, val2);
    }
}
