package com.project.crm.services;

import com.project.crm.model.Product;
import com.project.crm.model.enums.ProductStatus;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Service class for {@link Product}
 */
public interface ProductService {
    Product getProductByHttpServletRequestAndPhoto(HttpServletRequest request, MultipartFile photo);

    void addProduct(Product product);

    void editProduct(Product product, MultipartFile photo);

    Product getProductById(String id);

    List<Product> getProductsByKeyWords(String keyWords);

    List<Product> getProductsByUsername(String username);

    List<Product> getProductsByCategory(String category);

    List<Product> getProductsBySuperCategory(String superCategory);

    List<Product> getProductsByStatus(ProductStatus status);

    List<Product> getAllProducts();

    void deleteProductById(String id);

    void changeProductStatus(String id, ProductStatus status);

    List<Product> getProductsByOneParameter(String attribute, String val);

    List<Product> getProductsByTwoParameters(String attribute1, String val1, String attribute2, String val2);
}
