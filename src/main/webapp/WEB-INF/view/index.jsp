<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <c:import url="${path}/WEB-INF/view/include/top.jsp" />

    <section>
      <br>
      <div align=center>
        시작페이지<br><br>

        <span>서버 </span>:
        <%=application.getServerInfo()%><br>
        <span>서블릿 </span>:
        <%=application.getMajorVersion()%>.<%=application.getMinorVersion()%><br>
        <span>JSP </span>:
        <%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()%>
      </div>
      <br>
    </section>

    <c:import url="${path}/WEB-INF/view/include/bottom.jsp" />