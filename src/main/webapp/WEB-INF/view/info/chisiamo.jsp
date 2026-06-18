<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Chi siamo — DS Games"/>
<%@ include file="../common/header.jsp" %>

<main>
<div class="container" style="padding-top:2rem; padding-bottom:4rem; max-width:860px;">

    <h1 style="font-size:1.6rem; font-weight:800; margin-bottom:0.25rem;">Chi siamo</h1>
    <p style="color:var(--c-text-muted); margin-bottom:2rem; font-size:0.9rem;">
        La nostra storia
    </p>

    <div style="background:white; border:1px solid var(--c-border);
                border-radius:var(--radius-lg); padding:2rem; margin-bottom:1.5rem;">
        <h2 style="font-size:1.1rem; font-weight:700; margin-bottom:1rem;">
            DS Games — appassionati di gaming
        </h2>
        <p style="line-height:1.8; color:#444; margin-bottom:1rem;">
            DS Games nasce dalla passione di due studenti universitari per il mondo dei videogiochi.
            La nostra piattaforma offre un'ampia selezione di console e videogiochi per tutte le
            piattaforme, con l'obiettivo di diventare il punto di riferimento per gli appassionati
            di gaming in Italia.
        </p>
        <p style="line-height:1.8; color:#444;">
            Crediamo che ogni giocatore meriti di trovare facilmente i prodotti che cerca,
            a prezzi onesti e con un servizio clienti affidabile. Per questo offriamo
            spedizione gratuita su tutti gli ordini, una politica di reso semplice
            e un catalogo sempre aggiornato con le ultime uscite.
        </p>
    </div>

    <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(220px, 1fr));
                gap:1rem; margin-bottom:1.5rem;">
        <div style="background:white; border:1px solid var(--c-border);
                    border-radius:var(--radius-lg); padding:1.5rem; text-align:center;">
            <div style="font-size:2rem; font-weight:900; color:var(--c-accent);">500+</div>
            <div style="font-size:0.875rem; color:var(--c-text-muted); margin-top:0.25rem;">
                Prodotti in catalogo
            </div>
        </div>
        <div style="background:white; border:1px solid var(--c-border);
                    border-radius:var(--radius-lg); padding:1.5rem; text-align:center;">
            <div style="font-size:2rem; font-weight:900; color:var(--c-accent);">24h</div>
            <div style="font-size:0.875rem; color:var(--c-text-muted); margin-top:0.25rem;">
                Supporto clienti
            </div>
        </div>
        <div style="background:white; border:1px solid var(--c-border);
                    border-radius:var(--radius-lg); padding:1.5rem; text-align:center;">
            <div style="font-size:2rem; font-weight:900; color:var(--c-accent);">Free</div>
            <div style="font-size:0.875rem; color:var(--c-text-muted); margin-top:0.25rem;">
                Spedizione gratuita
            </div>
        </div>
    </div>

    <div style="background:white; border:1px solid var(--c-border);
                border-radius:var(--radius-lg); padding:2rem;">
        <h2 style="font-size:1.1rem; font-weight:700; margin-bottom:1rem;">
            Il nostro team
        </h2>
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:1rem;">
            <div style="padding:1rem; background:var(--c-bg);
                        border-radius:var(--radius); text-align:center;">
                <div style="font-weight:700; margin-bottom:0.25rem;">Domenico Avino</div>
                <div style="font-size:0.85rem; color:var(--c-text-muted);">Co-fondatore & Sviluppatore</div>
            </div>
            <div style="padding:1rem; background:var(--c-bg);
                        border-radius:var(--radius); text-align:center;">
                <div style="font-weight:700; margin-bottom:0.25rem;">Simone Boccia</div>
                <div style="font-size:0.85rem; color:var(--c-text-muted);">Co-fondatore & Sviluppatore</div>
            </div>
        </div>
    </div>

</div>
</main>
<%@ include file="../common/footer.jsp" %>