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
}
