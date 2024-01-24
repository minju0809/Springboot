<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<footer>
		KOREA Copyright &copy2024 All right reserved. Human Resources Development Service of Korea
	</footer>
	</body>
	<script>
		const nav = document.querySelector("#nav");

		nav.addEventListener("mouseover", () => {
			nav.classList.add("active");
		});
		nav.addEventListener("mouseout", () => {
			nav.classList.remove("active");
		});
	</script>

	</html>


	<!-- Mouse Over Event, Mouse Out -->