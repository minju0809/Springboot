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
  public List<CartVO> getCartList(CartVO vo) {
    return dao.getCartList(vo);
  }
}
