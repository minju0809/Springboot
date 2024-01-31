package com.springboot.springboot.project.shop;

import java.util.List;

public interface ShopService {
  List<ProductVO> getProductList(ProductVO vo);

  ProductVO getProduct(ProductVO vo);
  
  void productInsert(ProductVO vo);

  CartVO cartCheck(CartVO vo);
  void cartInsert(CartVO vo);
  void cartUpdate(CartVO vo);
  List<CartVO> adminGetCartList(CartVO vo);
  List<CartVO> getCartList(CartVO vo);

  void cartUpdateAll(CartVO vo);
  void cartDelete(CartVO vo);
}
