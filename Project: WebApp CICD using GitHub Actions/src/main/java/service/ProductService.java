package com.example.pharmawebapp.service;

import com.example.pharmawebapp.model.Product;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Arrays;

@Service
public class ProductService {
    public List<Product> getProducts() {
        return Arrays.asList(
            new Product("Paracetamol", 20.0),
            new Product("Aspirin", 15.0)
        );
    }
}
