package com.springboot.springboot.controller;

import java.io.File;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.springboot.project.member.MemberVO;
import com.springboot.springboot.project.shop.CartVO;
import com.springboot.springboot.project.shop.OrderVO;
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

  @Value("${toss.client.key}")
  private String tossClientKey;

  @Value("${toss.customer.key}")
  private String tossCustomerKey;

  @Value("${toss.widget.secret.key}")
  private String tossWidgetSecretKey;

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
  String cartAdd(CartVO cartVO) {
    MemberVO mvo = (MemberVO) session.getAttribute("session");
    int midx = mvo.getMember_idx();
    cartVO.setMember_idx(midx);

    CartVO cvo = service.cartCheck(cartVO);
    if (cvo == null) {
      service.cartInsert(cartVO);
    } else {
      service.cartUpdate(cartVO);
    }

    return "redirect:/getCartList.do?member_idx=" + midx;
  }

  @GetMapping("/getCartList.do")
  public String getCartList(Model model) {
    // TossPayments 키를 Model에 추가
    model.addAttribute("tossClientKey", tossClientKey);
    model.addAttribute("tossCustomerKey", tossCustomerKey);
    model.addAttribute("tossWidgetSecretKey", tossWidgetSecretKey);
    
    MemberVO mvo = (MemberVO) session.getAttribute("session");
    if (mvo != null) {
      CartVO vo = new CartVO();
      vo.setMember_idx(mvo.getMember_idx());
      model.addAttribute("order_idx", service.order_idx(null));
      model.addAttribute("li", service.getCartList(vo));
    }
    return "/shop/getCartList";
  }

  @PostMapping("/cartUpdateAll.do")
  public String cartUpdateAll(@RequestParam String[] member_idx,
      @RequestParam String[] cart_idx,
      @RequestParam String[] product_idx,
      @RequestParam String[] product_amount,
      @RequestParam String[] product_price) {

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

  // order

  @GetMapping("/paymentSuccess.do")
  public String paymentSuccess(
          @RequestParam String order_idx,
          @RequestParam String member_idx,
          @RequestParam String[] cart_idx,
          @RequestParam String[] product_idx,
          @RequestParam String[] product_name,
          @RequestParam String[] product_amount,
          @RequestParam String[] product_price,
          @RequestParam String order_price,
          @RequestParam String[] product_imgStr,
          Model model) {

    // 주문 정보를 Model에 추가
    model.addAttribute("order_idx", order_idx);
    model.addAttribute("member_idx", member_idx);
    model.addAttribute("cart_idx", String.join(",", cart_idx));
    model.addAttribute("product_idx", String.join(",", product_idx));
    model.addAttribute("product_name", String.join(",", product_name));
    model.addAttribute("product_amount", String.join(",", product_amount));
    model.addAttribute("product_price", String.join(",", product_price));
    model.addAttribute("order_price", String.join(",", product_price));
    model.addAttribute("product_imgStr", String.join(",", product_imgStr));

    // 세션에서 회원 정보 가져오기
    MemberVO member = (MemberVO) session.getAttribute("session");
    if (member != null) {
      model.addAttribute("memberName", member.getName());
      model.addAttribute("memberEmail", member.getEmail());
      model.addAttribute("memberPhone", member.getPhone());
    }

    return "/shop/success";
  }

  @PostMapping("/orderAll.do")
  public String orderAll(
      @RequestParam String order_idx,
      @RequestParam String[] cart_idx,
      @RequestParam String[] product_idx,
      @RequestParam String[] product_name,
      @RequestParam String[] product_amount,
      @RequestParam String[] product_price,
      @RequestParam String[] order_price,
      @RequestParam String[] product_imgStr,
      @RequestParam String paymentKey,
      @RequestParam String orderId,
      @RequestParam int amount) {

    MemberVO mvo = (MemberVO) session.getAttribute("session");
    int midx = mvo.getMember_idx();
    // 배열 길이 확인
    int length = cart_idx.length;
    
    for (int i = 0; i < length; i++) {
      OrderVO vo = new OrderVO();
      vo.setMember_idx(midx);
      vo.setOrder_idx(Integer.parseInt(order_idx));
      vo.setCart_idx(Integer.parseInt(cart_idx[i]));
      vo.setProduct_idx(Integer.parseInt(product_idx[i]));
      vo.setProduct_name(product_name[i]);
      vo.setProduct_amount(Integer.parseInt(product_amount[i]));
      vo.setProduct_price(Integer.parseInt(product_price[i]));
      vo.setOrder_price(Integer.parseInt(order_price[i]));
      vo.setProduct_imgStr(product_imgStr[i]);
      vo.setPaymentKey(paymentKey);
      vo.setOrderId(orderId);
      vo.setAmount(amount);
      
      service.cartDeleteAll(vo);
      service.orderInsert(vo);
    }

    if (mvo.getRole().equals("ROLE_A")) {
      return "redirect:/a/admin.do";
    } else {
      return "redirect:/getOrderList.do?member_idx=" + midx;
    }
  }

  @GetMapping("/getOrderList.do")
  String getOrderList(Model model, OrderVO vo) {

    MemberVO mvo = (MemberVO) session.getAttribute("session");
    vo.setMember_idx(mvo.getMember_idx());
    model.addAttribute("li", service.getOrderList(vo));

    return "/shop/getOrderList";
  }

  @GetMapping("/getDetailOrderList.do")
  String getDetailOrderList(Model model, OrderVO vo) {

    model.addAttribute("li", service.getDetailOrderList(vo));

    return "/shop/getDetailOrderList";
  }
}
