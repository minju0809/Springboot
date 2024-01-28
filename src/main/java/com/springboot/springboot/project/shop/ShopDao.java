package com.springboot.springboot.project.shop;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopDao {
  List<ProductVO> getProductList(ProductVO vo); 

  ProductVO getProduct(ProductVO vo);

  void productInsert(ProductVO vo);
}
