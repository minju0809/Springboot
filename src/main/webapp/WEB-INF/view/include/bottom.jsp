<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<footer>
		<div class="footer-content">
			<div class="footer-links">
				<a href="https://github.com/minju0809/Springboot" target="_blank" class="footer-button">
					<img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub" class="footer-icon">
					GitHub
				</a>
				<a href="https://www.notion.so/minju0809/500fe4e44dbf46f8b6a268134bce4c39" target="_blank" class="footer-button">
					<img src="https://upload.wikimedia.org/wikipedia/commons/4/45/Notion_app_logo.png" alt="Notion" class="footer-icon">
					Notion
				</a>
			</div>
			<div class="footer-copyright">
				KOREA Copyright &copy2024 All right reserved. Human Resources Development Service of Korea
			</div>
		</div>
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