<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'DS Games'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body data-context="${pageContext.request.contextPath}">

<nav class="navbar">
    <div class="navbar-top">
        Spedizione gratuita su tutti gli ordini &nbsp;|&nbsp; Supporto clienti: info@dsgames.it
    </div>
    <div class="navbar-inner">

        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            DS<span>Games</span>
        </a>

        <form class="navbar-search"
              action="${pageContext.request.contextPath}/catalogo" method="get">
            <input type="text" name="q"
                   placeholder="Cerca console, videogiochi, piattaforme..."
                   value="${param.q}" autocomplete="off">
            <button type="submit">CERCA</button>
        </form>

        <div class="navbar-links" id="navLinks">
            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <a href="${pageContext.request.contextPath}/ordini">I miei ordini</a>
                    <a href="${pageContext.request.contextPath}/wishlist">Lista desideri</a>
                    <a href="${pageContext.request.contextPath}/profilo">
                        ${sessionScope.utente.nome} ${sessionScope.utente.cognome}
                    </a>
                    <c:if test="${sessionScope.utente.admin}">
                        <a href="${pageContext.request.contextPath}/admin/prodotti"
                           class="nav-cta">Admin</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout">Esci</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Accedi</a>
                    <a href="${pageContext.request.contextPath}/registrazione"
                       class="nav-cta">Registrati</a>
                </c:otherwise>
            </c:choose>

            <a href="${pageContext.request.contextPath}/carrello" class="cart-icon">
                Carrello
                <c:if test="${not empty sessionScope.carrello and sessionScope.carrello.size() > 0}">
                    <span class="cart-badge">${sessionScope.carrello.size()}</span>
                </c:if>
            </a>
        </div>

        <button class="navbar-toggle" id="navToggle"
                onclick="document.getElementById('navLinks').classList.toggle('open')"
                aria-label="Menu">&#9776;</button>
    </div>

    <div class="navbar-nav">
        <div class="navbar-nav-inner">
            <a href="${pageContext.request.contextPath}/catalogo">Tutto il catalogo</a>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=CONSOLE">Console</a>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=VIDEOGIOCO">Videogiochi</a>
            <a href="${pageContext.request.contextPath}/offerte">Offerte</a>
        </div>
    </div>
</nav>