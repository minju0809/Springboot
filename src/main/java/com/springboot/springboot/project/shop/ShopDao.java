package com.springboot.springboot.project.shop;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopDao {
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
  void cartDeleteAll(OrderVO vo);
  

  int order_idx(OrderVO vo);
  void orderInsert(OrderVO vo);
  List<OrderVO> adminGetOrderList(OrderVO vo);
  List<OrderVO> getOrderList(OrderVO vo);
}
