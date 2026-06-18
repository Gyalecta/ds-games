<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Contatti — DS Games"/>
<%@ include file="../common/header.jsp" %>

<main>
<div class="container" style="padding-top:2rem; padding-bottom:4rem; max-width:860px;">

    <h1 style="font-size:1.6rem; font-weight:800; margin-bottom:0.25rem;">Contatti</h1>
    <p style="color:var(--c-text-muted); margin-bottom:2rem; font-size:0.9rem;">
        Siamo qui per aiutarti
    </p>

    <div style="display:grid; grid-template-columns:1fr 1.4fr; gap:1.5rem; align-items:start;">

        <!-- Info contatti -->
        <div style="display:flex; flex-direction:column; gap:1rem;">

            <div style="background:white; border:1px solid var(--c-border);
                        border-radius:var(--radius-lg); padding:1.5rem;">
                <div style="font-weight:700; font-size:0.8rem; text-transform:uppercase;
                            letter-spacing:1px; color:var(--c-text-muted); margin-bottom:0.75rem;">
                    Email
                </div>
                <div style="font-weight:600;">info@dsgames.it</div>
                <div style="font-size:0.8rem; color:var(--c-text-muted); margin-top:0.25rem;">
                    Risposta entro 24 ore lavorative
                </div>
            </div>

            <div style="background:white; border:1px solid var(--c-border);
                        border-radius:var(--radius-lg); padding:1.5rem;">
                <div style="font-weight:700; font-size:0.8rem; text-transform:uppercase;
                            letter-spacing:1px; color:var(--c-text-muted); margin-bottom:0.75rem;">
                    Orari assistenza
                </div>
                <div style="font-size:0.875rem; line-height:1.8;">
                    Lunedì — Venerdì<br>
                    <strong>9:00 — 18:00</strong>
                </div>
            </div>

            <div style="background:white; border:1px solid var(--c-border);
                        border-radius:var(--radius-lg); padding:1.5rem;">
                <div style="font-weight:700; font-size:0.8rem; text-transform:uppercase;
                            letter-spacing:1px; color:var(--c-text-muted); margin-bottom:0.75rem;">
                    Sede
                </div>
                <div style="font-size:0.875rem; line-height:1.8; color:#444;">
                    Università degli Studi di Salerno<br>
                    Via Giovanni Paolo II, 132<br>
                    84084 Fisciano (SA)
                </div>
            </div>

        </div>

        <!-- Form contatti -->
        <div style="background:white; border:1px solid var(--c-border);
                    border-radius:var(--radius-lg); padding:2rem;">

            <h2 style="font-size:1rem; font-weight:700; margin-bottom:1.5rem;">
                Inviaci un messaggio
            </h2>

            <c:if test="${not empty successo}">
                <div class="alert alert-success">${successo}</div>
            </c:if>
            <c:if test="${not empty errore}">
                <div class="alert alert-error">${errore}</div>
            </c:if>

            <form id="formContatti" method="post"
                  action="${pageContext.request.contextPath}/contatti">

                <div style="display:grid; grid-template-columns:1fr 1fr; gap:1rem;">
                    <div class="form-group">
                        <label for="nome">Nome *</label>
                        <input type="text" id="nome" name="nome"
                               placeholder="Il tuo nome">
                        <div class="form-error" id="nome-error"></div>
                    </div>
                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email"
                               placeholder="tua@email.com">
                        <div class="form-error" id="email-error"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="oggetto">Oggetto</label>
                    <select id="oggetto" name="oggetto">
                        <option value="">Seleziona un argomento</option>
                        <option value="ordine">Domanda su un ordine</option>
                        <option value="prodotto">Informazioni su un prodotto</option>
                        <option value="reso">Richiesta di reso</option>
                        <option value="tecnico">Problema tecnico</option>
                        <option value="altro">Altro</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="messaggio">Messaggio *</label>
                    <textarea id="messaggio" name="messaggio" rows="5"
                              placeholder="Descrivi la tua richiesta..."
                              style="resize:vertical;"></textarea>
                    <div class="form-error" id="messaggio-error"></div>
                </div>

                <button type="submit" class="btn btn-primary btn-full">
                    Invia messaggio
                </button>

            </form>
        </div>

    </div>
</div>
</main>

<script src="${pageContext.request.contextPath}/scripts/validazione.js"></script>
<script>
document.getElementById('formContatti').addEventListener('submit', function(e) {
    let valid = true;
    const nome = document.getElementById('nome');
    const email = document.getElementById('email');
    const msg = document.getElementById('messaggio');

    if (!nome.value.trim()) {
        document.getElementById('nome-error').textContent = 'Il nome è obbligatorio.';
        document.getElementById('nome-error').classList.add('visible');
        nome.style.borderColor = 'var(--c-danger)';
        valid = false;
    } else {
        document.getElementById('nome-error').classList.remove('visible');
        nome.style.borderColor = '';
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email.value.trim() || !emailRegex.test(email.value)) {
        document.getElementById('email-error').textContent = 'Inserisci un\'email valida.';
        document.getElementById('email-error').classList.add('visible');
        email.style.borderColor = 'var(--c-danger)';
        valid = false;
    } else {
        document.getElementById('email-error').classList.remove('visible');
        email.style.borderColor = '';
    }

    if (!msg.value.trim()) {
        document.getElementById('messaggio-error').textContent = 'Il messaggio è obbligatorio.';
        document.getElementById('messaggio-error').classList.add('visible');
        msg.style.borderColor = 'var(--c-danger)';
        valid = false;
    } else {
        document.getElementById('messaggio-error').classList.remove('visible');
        msg.style.borderColor = '';
    }

    if (!valid) e.preventDefault();
});
</script>

<%@ include file="../common/footer.jsp" %>