package com.springboot.springboot.project.shop;

import java.util.List;

public interface ShopService {
  List<ProductVO> getProductList(ProductVO vo);

  ProductVO getProduct(ProductVO vo);
  
  void productInsert(ProductVO vo);
}
