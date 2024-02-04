package com.springboot.springboot.project.shop;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class OrderVO { // 70001
	private int order_idx;
	private int cart_idx;
	private int member_idx;
	private int product_idx;
	private String product_name;
	private int product_amount;
	private int product_price;
	private int order_price;
	private String name;
	private String phone;
	private String etc;
	private String order_today;
	private MultipartFile product_img;
	private String product_imgStr;
}
