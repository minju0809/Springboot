package com.springboot.springboot.project.shop;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CartVO { // 60001
  private int cart_idx;
  private int member_idx;
  private int product_idx;
  private String product_name;
  private int product_amount;
  private int product_price;
  private MultipartFile product_img;
  private String product_imgStr;
}
