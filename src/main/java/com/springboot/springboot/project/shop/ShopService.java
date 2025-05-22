package com.springboot.springboot.project.shop;

import java.util.List;

public interface ShopService {
  List<ProductVO> getProductList(ProductVO vo);

  ProductVO getProduct(ProductVO vo);
  
  void productInsert(ProductVO vo);
  
  void productUpdate(ProductVO vo);
  
  void productDelete(ProductVO vo);

  CartVO cartCheck(CartVO vo);
  void cartInsert(CartVO vo);
  void cartUpdate(CartVO vo);
  List<CartVO> adminGetCartList(CartVO vo);
  List<CartVO> getCartList(CartVO vo);

  void cartUpdateAll(CartVO vo);
  void cartDelete(CartVO vo);
  void cartDeleteAll(OrderVO vo);

  int order_idx(OrderVO vo);
  void orderInsert(OrderVO vo);
  List<OrderVO> adminGetOrderList(OrderVO vo);
  List<OrderVO> getOrderList(OrderVO vo);
  List<OrderVO> getDetailOrderList(OrderVO vo);

  // 전체 상품 수 조회
  int getTotalCount(ProductVO vo);
}
