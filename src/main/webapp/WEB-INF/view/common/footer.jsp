<%@ page contentType="text/html;charset=UTF-8" %>

<footer>
    <div class="footer-inner">
        <div class="footer-col">
            <div class="footer-brand">DS<span>Games</span></div>
            <p style="font-size:0.82rem; line-height:1.7; max-width:260px;">
                Piattaforma e-commerce dedicata alla vendita di console e videogiochi.
                Ampia scelta, prezzi competitivi, spedizione rapida.
            </p>
        </div>
        <div class="footer-col">
            <h4>Catalogo</h4>
            <a href="${pageContext.request.contextPath}/catalogo">Tutti i prodotti</a>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=CONSOLE">Console</a>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=VIDEOGIOCO">Videogiochi</a>
            <a href="${pageContext.request.contextPath}/offerte">Offerte</a>
        </div>
        <div class="footer-col">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/login">Accedi</a>
            <a href="${pageContext.request.contextPath}/registrazione">Registrati</a>
            <a href="${pageContext.request.contextPath}/ordini">I miei ordini</a>
            <a href="${pageContext.request.contextPath}/wishlist">Lista desideri</a>
        </div>
		<div class="footer-col">
    		<h4>Assistenza</h4>
    			<a href="${pageContext.request.contextPath}/chisiamo">Chi siamo</a>
    			<a href="${pageContext.request.contextPath}/spedizioni">Spedizioni e resi</a>
    			<a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
    			<a href="${pageContext.request.contextPath}/contatti">Contatti</a>
		</div>
    </div>
    <div class="footer-bottom">
        <span>&copy; 2026 DSGames &mdash; Tutti i diritti riservati</span>
        <span>Progetto TSW &mdash; Università degli Studi di Salerno</span>
    </div>
</footer>

</body>
</html>