package com.springboot.springboot.controller;

import java.io.File;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.springboot.project.member.MemberVO;
import com.springboot.springboot.project.shop.CartVO;
import com.springboot.springboot.project.shop.ProductVO;
import com.springboot.springboot.project.shop.ShopService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ShopController {

  @Autowired
  private ShopService service;

  @Autowired
  private HttpServletRequest request;

  @Autowired
  private HttpSession session;

  @GetMapping("/getProductList.do")
  String getProductList(Model model, ProductVO vo) {

    model.addAttribute("li", service.getProductList(vo));

    return "/shop/getProductList";
  }

  @GetMapping("/getProduct.do")
  String getProduct(Model model, ProductVO vo) {

    model.addAttribute("product", service.getProduct(vo));

    return "/shop/getProduct";
  }

  @GetMapping("/a/productForm.do")
  String productForm(Model model) {

    return "/shop/productForm";
  }

  @PostMapping("/a/productInsert.do")
  String productInsert(ProductVO vo) throws Exception {
    String path = request.getSession().getServletContext().getRealPath("/img/shop/");
    System.out.println("path: " + path);
    // path: /Users/minju/Springboot/src/main/webapp/img/shop/

    long time = System.currentTimeMillis();
    SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
    String timeStr = sdf.format(time);

    MultipartFile file = vo.getProduct_img();
    String fileName = file.getOriginalFilename();
    File f = new File(path + fileName);

    if (!file.isEmpty()) {
      if (f.exists()) {
        String onlyFileName = fileName.substring(0, fileName.lastIndexOf("."));
        String ext = fileName.substring(fileName.lastIndexOf("."));
        fileName = onlyFileName + "_" + timeStr + ext;
      }
      file.transferTo(new File(path + fileName));
    } else {
      fileName = "space.png";
    }

    vo.setProduct_imgStr(fileName);
    System.out.println("vo: " + vo);
    service.productInsert(vo);

    return "redirect:/getProductList.do";
  }

  @PostMapping("/cartAdd.do")
  String cartAdd(ProductVO productVO) {
    CartVO cartVO = new CartVO();
    MemberVO mvo = (MemberVO) session.getAttribute("session");
    int midx = mvo.getMember_idx();
    cartVO.setMember_idx(midx);

    System.out.println("==============================>>>>" + productVO);
    ProductVO pvo = service.getProduct(productVO);
    System.out.println("==============================>>>>" + pvo);
    cartVO.setProduct_idx(pvo.getProduct_idx());
    cartVO.setProduct_name(pvo.getProduct_name());
    cartVO.setProduct_amount(productVO.getProduct_amount());
    cartVO.setProduct_price(pvo.getProduct_price());
    cartVO.setProduct_imgStr(pvo.getProduct_imgStr());
    System.out.println("!!!!!!!!!!!!!!!cartVO: " + cartVO);

    CartVO cvo = service.cartCheck(cartVO);
    System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@cvo" + cvo);
    if (cvo == null) {
      service.cartInsert(cartVO);
    } else {
      service.cartUpdate(cartVO);
    }

    if (mvo.getRole().equals("ROLE_ADMIN")) {
      // If the username is admin, redirect to adminGetCartList
      return "redirect:/adminGetCartList.do?member_idx=" + midx;
    } else {
      // For non-admin users, redirect to getCartList
      return "redirect:/getCartList.do?member_idx=" + midx;
    }
  }

  @GetMapping("/adminGetCartList.do")
  String adminGetCartList(Model model, CartVO vo) {

    model.addAttribute("li", service.adminGetCartList(vo));

    return "/shop/getCartList";
  }

  @GetMapping("/getCartList.do")
  String getCartList(Model model, CartVO vo) {

    MemberVO mvo = (MemberVO) session.getAttribute("session");
    vo.setMember_idx(mvo.getMember_idx());
    System.out.println("cart:" + service.getCartList(vo));
    model.addAttribute("li", service.getCartList(vo));

    return "/shop/getCartList";
  }

  @GetMapping("/cartUpdateAll.do")
  public String cartUpdateAll(@RequestParam String[] member_idx,
      @RequestParam String[] cart_idx,
      @RequestParam String[] product_idx,
      @RequestParam String[] product_amount,
      @RequestParam String[] product_price
      ) {

    // Iterate through the arrays to update each cart item
    for (int i = 0; i < cart_idx.length; i++) {
      CartVO vo = new CartVO();
      vo.setMember_idx(Integer.parseInt(member_idx[i]));
      vo.setCart_idx(Integer.parseInt(cart_idx[i]));
      vo.setProduct_idx(Integer.parseInt(product_idx[i]));
      vo.setProduct_amount(Integer.parseInt(product_amount[i]));
      vo.setProduct_price(Integer.parseInt(product_price[i]));

      service.cartUpdateAll(vo);
    }

    return "redirect:/getCartList.do";
  }

  @GetMapping("/cartDelete.do")
  public String cartDelete(CartVO vo) {

    service.cartDelete(vo);

    return "redirect:/getCartList.do";
  }

}
