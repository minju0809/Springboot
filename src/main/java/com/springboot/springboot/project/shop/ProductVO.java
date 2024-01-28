package com.springboot.springboot.project.shop;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO { // 50001
  private int product_idx;
  private String product_name;
  private int product_price;
  private String product_desc;
  private MultipartFile product_img;
  private String product_imgStr;

  private String ch1;
  private String ch2;
}
