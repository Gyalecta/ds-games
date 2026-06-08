<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="DS Games — Console e Videogiochi"/>
<%@ include file="common/header.jsp" %>

<main>

    <section class="hero">
        <div class="hero-inner">
            <h1>Console e Videogiochi<br><em>al miglior prezzo</em></h1>
            <p>Ampia selezione di console e videogiochi per tutte le piattaforme.
               Spedizione gratuita su tutti gli ordini.</p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/catalogo?categoria=CONSOLE"
                   class="btn btn-primary">Scopri le Console</a>
                <a href="${pageContext.request.contextPath}/catalogo?categoria=VIDEOGIOCO"
                   class="btn btn-outline">Tutti i Videogiochi</a>
            </div>
        </div>
    </section>

    <div class="container">

        <c:if test="${not empty offerte}">
            <section style="margin-top:2.5rem;">
                <h2 class="section-title">Offerte in corso</h2>
                <div class="products-grid">
                    <c:forEach var="p" items="${offerte}">
                        <article class="product-card">
                            <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}"
                               class="product-card-img-link">
                                <c:choose>
                                    <c:when test="${not empty p.immagine}">
                                        <img class="product-card-img"
                                             src="${pageContext.request.contextPath}/images/prodotti/${p.immagine}"
                                             alt="${p.nome}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-card-img-placeholder">
                                            <span class="placeholder-label">${p.categoria}</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <div class="product-card-body">
                                <span class="product-card-category">${p.categoria}</span>
                                <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}"
                                   class="product-card-name">${p.nome}</a>
                                <span class="product-card-platform">${p.piattaforma}</span>
                                <div class="product-card-price">
                                    <span class="price-current">
                                        <fmt:formatNumber value="${p.prezzoEffettivo}"
                                            type="currency" currencySymbol="€"/>
                                    </span>
                                    <span class="price-original">
                                        <fmt:formatNumber value="${p.prezzo}"
                                            type="currency" currencySymbol="€"/>
                                    </span>
                                    <span class="badge-sale">OFFERTA</span>
                                </div>
                            </div>
                            <div class="product-card-footer">
                                <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}"
                                   class="btn btn-details btn-sm">Dettagli</a>
                                <c:if test="${p.quantita > 0}">
                                    <button class="btn btn-cart btn-sm"
                                            onclick="aggiungiAlCarrello(${p.id}, this)">
                                        Aggiungi
                                    </button>
                                </c:if>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </section>
        </c:if>

        <c:if test="${not empty prodotti}">
            <section style="margin-top:2.5rem;">
                <h2 class="section-title">Tutto il catalogo</h2>
                <div class="products-grid">
                    <c:forEach var="p" items="${prodotti}">
                        <article class="product-card">
                            <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}"
                               class="product-card-img-link">
                                <c:choose>
                                    <c:when test="${not empty p.immagine}">
                                        <img class="product-card-img"
                                             src="${pageContext.request.contextPath}/images/prodotti/${p.immagine}"
                                             alt="${p.nome}" loading="lazy">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-card-img-placeholder">
                                            <span class="placeholder-label">${p.categoria}</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <div class="product-card-body">
                                <span class="product-card-category">${p.categoria}</span>
                                <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}"
                                   class="product-card-name">${p.nome}</a>
                                <span class="product-card-platform">${p.piattaforma}</span>
                                <div class="product-card-price">
                                    <span class="price-current">
                                        <fmt:formatNumber value="${p.prezzoEffettivo}"
                                            type="currency" currencySymbol="€"/>
                                    </span>
                                    <c:if test="${p.inOfferta}">
                                        <span class="price-original">
                                            <fmt:formatNumber value="${p.prezzo}"
                                                type="currency" currencySymbol="€"/>
                                        </span>
                                        <span class="badge-sale">OFFERTA</span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="product-card-footer">
                                <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}"
                                   class="btn btn-details btn-sm">Dettagli</a>
                                <c:if test="${p.quantita > 0}">
                                    <button class="btn btn-cart btn-sm"
                                            onclick="aggiungiAlCarrello(${p.id}, this)">
                                        Aggiungi
                                    </button>
                                </c:if>
                                <c:if test="${p.quantita == 0}">
                                    <span class="sold-out-label">Esaurito</span>
                                </c:if>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </section>
        </c:if>

        <c:if test="${empty prodotti and empty offerte}">
            <div style="text-align:center; padding:5rem 0; color:var(--c-text-muted);">
                <p style="font-size:1rem; font-weight:700; text-transform:uppercase;
                          letter-spacing:1px;">Catalogo in aggiornamento</p>
                <p style="margin-top:0.5rem; font-size:0.875rem;">
                    I prodotti saranno disponibili a breve.
                </p>
            </div>
        </c:if>

    </div>
</main>

<script src="${pageContext.request.contextPath}/scripts/ajax.js"></script>
<%@ include file="common/footer.jsp" %>