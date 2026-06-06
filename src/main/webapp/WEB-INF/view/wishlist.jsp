<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Lista Desideri — DS Games"/>
<%@ include file="common/header.jsp" %>

<main>
<div class="container" style="padding-top:2rem; padding-bottom:3rem;">

    <h1 class="section-title">🤍 Lista Desideri</h1>

    <c:if test="${not empty errore}">
        <div class="alert alert-error">${errore}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty listaDesideri}">
            <div style="text-align:center; padding:4rem; color:#666;">
                <div style="font-size:3.5rem;">🤍</div>
                <h3 style="margin-top:1rem;">
                    La tua lista desideri è vuota
                </h3>
                <p style="margin-top:0.5rem;">
                    Aggiungi prodotti dalla pagina di dettaglio!
                </p>
                <a href="${pageContext.request.contextPath}/catalogo"
                   class="btn btn-primary" style="margin-top:1.5rem;">
                    Esplora il catalogo
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="products-grid">
                <c:forEach var="p" items="${listaDesideri}">
                    <div class="product-card">

                        <c:choose>
                            <c:when test="${not empty p.immagine}">
                                <img class="product-card-img"
                                     src="${pageContext.request.contextPath}/images/prodotti/${p.immagine}"
                                     alt="${p.nome}">
                            </c:when>
                            <c:otherwise>
                                <div class="product-card-img-placeholder">
                                    <c:choose>
                                        <c:when test="${p.categoria == 'CONSOLE'}">🕹️</c:when>
                                        <c:otherwise>🎮</c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="product-card-body">
                            <span class="product-card-category">
                                ${p.categoria}
                            </span>
                            <span class="product-card-name">${p.nome}</span>
                            <span class="product-card-platform">
                                ${p.piattaforma}
                            </span>
                            <div class="product-card-price">
                                <span class="price-current">
                                    <fmt:formatNumber
                                        value="${p.prezzoEffettivo}"
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
                               class="btn btn-primary btn-sm" style="flex:1">
                                Dettagli
                            </a>
                            <a href="${pageContext.request.contextPath}/carrello?azione=aggiungi&idProdotto=${p.id}"
                               class="btn btn-sm"
                               style="border:1px solid var(--color-border);"
                               title="Aggiungi al carrello">
                                🛒
                            </a>
                            <a href="${pageContext.request.contextPath}/wishlist?azione=rimuovi&idProdotto=${p.id}"
                               class="btn btn-sm"
                               style="border:1px solid var(--color-danger);
                                      color:var(--color-danger);"
                               title="Rimuovi dalla lista"
                               onclick="return confirm('Rimuovere dalla lista desideri?')">
                                🗑
                            </a>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</main>

<%@ include file="common/footer.jsp" %>