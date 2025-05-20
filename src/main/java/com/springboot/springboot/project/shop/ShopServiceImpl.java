package com.springboot.springboot.project.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShopServiceImpl implements ShopService {

  @Autowired
  private ShopDao dao;

  @Override
  public List<ProductVO> getProductList(ProductVO vo) {
    return dao.getProductList(vo);
  }

  @Override
  public ProductVO getProduct(ProductVO vo) {
    return dao.getProduct(vo);
  }

  @Override
  public void productInsert(ProductVO vo) {
    dao.productInsert(vo);
  }

  @Override
  public void productUpdate(ProductVO vo) {
    dao.productUpdate(vo);
  }

  @Override
  public void productDelete(ProductVO vo) {
    dao.productDelete(vo);
  }

  @Override
  public void cartInsert(CartVO vo) {
    dao.cartInsert(vo);
  }

  @Override
  public void cartUpdate(CartVO vo) {
    dao.cartUpdate(vo);
  }

  @Override
  public CartVO cartCheck(CartVO vo) {
    return dao.cartCheck(vo);
  }

  @Override
  public List<CartVO> adminGetCartList(CartVO vo) {
    return dao.adminGetCartList(vo);
  }

  @Override
  public List<CartVO> getCartList(CartVO vo) {
    return dao.getCartList(vo);
  }

  @Override
  public void cartUpdateAll(CartVO vo) {
    dao.cartUpdateAll(vo);
  }

  @Override
  public void cartDelete(CartVO vo) {
    dao.cartDelete(vo);
  }

  @Override
  public void cartDeleteAll(OrderVO vo) {
    dao.cartDeleteAll(vo);
  }

  @Override
  public int order_idx(OrderVO vo) {
    return dao.order_idx(vo);
  }

  @Override
  public void orderInsert(OrderVO vo) {
    dao.orderInsert(vo);
  }

  @Override
  public List<OrderVO> adminGetOrderList(OrderVO vo) {
    return dao.adminGetOrderList(vo);
  }
  
  @Override
  public List<OrderVO> getOrderList(OrderVO vo) {
    return dao.getOrderList(vo);
  }

  @Override
  public List<OrderVO> getDetailOrderList(OrderVO vo) {
    return dao.getDetailOrderList(vo);
  }

}
