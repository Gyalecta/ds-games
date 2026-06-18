<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Spedizioni e Resi — DS Games"/>
<%@ include file="../common/header.jsp" %>

<main>
<div class="container" style="padding-top:2rem; padding-bottom:4rem; max-width:860px;">

    <h1 style="font-size:1.6rem; font-weight:800; margin-bottom:0.25rem;">Spedizioni e Resi</h1>
    <p style="color:var(--c-text-muted); margin-bottom:2rem; font-size:0.9rem;">
        Tutto quello che devi sapere sulle consegne e i ritorni
    </p>

    <!-- Spedizioni -->
    <div style="background:white; border:1px solid var(--c-border);
                border-radius:var(--radius-lg); padding:2rem; margin-bottom:1.5rem;">
        <h2 style="font-size:1.1rem; font-weight:700; margin-bottom:1.25rem;
                   padding-bottom:0.75rem; border-bottom:2px solid var(--c-accent);">
            Spedizioni
        </h2>

        <div style="display:grid; gap:1rem;">

            <div style="display:flex; gap:1rem; align-items:flex-start;">
                <div style="background:var(--c-accent); color:white; border-radius:50%;
                            width:32px; height:32px; display:flex; align-items:center;
                            justify-content:center; font-weight:800; flex-shrink:0;">1</div>
                <div>
                    <div style="font-weight:700; margin-bottom:0.25rem;">
                        Spedizione gratuita su tutti gli ordini
                    </div>
                    <div style="font-size:0.875rem; color:#555; line-height:1.6;">
                        Tutti gli ordini vengono spediti gratuitamente, senza soglia minima di spesa.
                    </div>
                </div>
            </div>

            <div style="display:flex; gap:1rem; align-items:flex-start;">
                <div style="background:var(--c-accent); color:white; border-radius:50%;
                            width:32px; height:32px; display:flex; align-items:center;
                            justify-content:center; font-weight:800; flex-shrink:0;">2</div>
                <div>
                    <div style="font-weight:700; margin-bottom:0.25rem;">
                        Tempi di consegna: 2-3 giorni lavorativi
                    </div>
                    <div style="font-size:0.875rem; color:#555; line-height:1.6;">
                        Gli ordini confermati entro le 14:00 vengono elaborati lo stesso giorno.
                        La consegna avviene tipicamente entro 2-3 giorni lavorativi sull'intero territorio italiano.
                    </div>
                </div>
            </div>

            <div style="display:flex; gap:1rem; align-items:flex-start;">
                <div style="background:var(--c-accent); color:white; border-radius:50%;
                            width:32px; height:32px; display:flex; align-items:center;
                            justify-content:center; font-weight:800; flex-shrink:0;">3</div>
                <div>
                    <div style="font-weight:700; margin-bottom:0.25rem;">
                        Tracking della spedizione
                    </div>
                    <div style="font-size:0.875rem; color:#555; line-height:1.6;">
                        Una volta spedito l'ordine, riceverai una email con il numero di tracking
                        per seguire la spedizione in tempo reale.
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Resi -->
    <div style="background:white; border:1px solid var(--c-border);
                border-radius:var(--radius-lg); padding:2rem; margin-bottom:1.5rem;">
        <h2 style="font-size:1.1rem; font-weight:700; margin-bottom:1.25rem;
                   padding-bottom:0.75rem; border-bottom:2px solid var(--c-accent);">
            Politica di reso
        </h2>

        <p style="line-height:1.8; color:#444; margin-bottom:1rem;">
            Accettiamo resi entro <strong>30 giorni</strong> dalla data di consegna.
            Il prodotto deve essere restituito nelle condizioni originali, nella confezione integra
            e con tutti gli accessori inclusi.
        </p>

        <div style="background:var(--c-bg); border-radius:var(--radius);
                    padding:1rem; margin-bottom:1rem;">
            <div style="font-weight:700; font-size:0.875rem; margin-bottom:0.5rem;">
                Come richiedere un reso:
            </div>
            <ol style="padding-left:1.5rem; font-size:0.875rem; line-height:1.8; color:#444;">
                <li>Accedi al tuo account e vai su "I miei ordini"</li>
                <li>Seleziona l'ordine e il prodotto da restituire</li>
                <li>Scegli il motivo del reso e invia la richiesta</li>
                <li>Riceverai le istruzioni di spedizione via email entro 24 ore</li>
                <li>Il rimborso viene elaborato entro 5-7 giorni lavorativi</li>
            </ol>
        </div>

        <div class="alert alert-info" style="font-size:0.875rem;">
            Per prodotti difettosi o danneggiati alla consegna, il reso è gratuito
            e garantiamo la sostituzione immediata o il rimborso completo.
        </div>
    </div>

    <!-- Tabella metodi -->
    <div style="background:white; border:1px solid var(--c-border);
                border-radius:var(--radius-lg); padding:2rem;">
        <h2 style="font-size:1.1rem; font-weight:700; margin-bottom:1rem;">
            Corrieri e metodi di spedizione
        </h2>
        <table style="width:100%; border-collapse:collapse; font-size:0.875rem;">
            <thead>
                <tr style="background:var(--c-header); color:white;">
                    <th style="padding:0.6rem 1rem; text-align:left;">Corriere</th>
                    <th style="padding:0.6rem 1rem; text-align:left;">Tempi</th>
                    <th style="padding:0.6rem 1rem; text-align:left;">Costo</th>
                </tr>
            </thead>
            <tbody>
                <tr style="border-bottom:1px solid var(--c-border);">
                    <td style="padding:0.7rem 1rem;">BRT / Bartolini</td>
                    <td style="padding:0.7rem 1rem;">2-3 giorni lavorativi</td>
                    <td style="padding:0.7rem 1rem; color:var(--c-success); font-weight:700;">GRATIS</td>
                </tr>
                <tr style="border-bottom:1px solid var(--c-border); background:#fafafa;">
                    <td style="padding:0.7rem 1rem;">GLS</td>
                    <td style="padding:0.7rem 1rem;">2-4 giorni lavorativi</td>
                    <td style="padding:0.7rem 1rem; color:var(--c-success); font-weight:700;">GRATIS</td>
                </tr>
                <tr>
                    <td style="padding:0.7rem 1rem;">Espresso (24h)</td>
                    <td style="padding:0.7rem 1rem;">1 giorno lavorativo</td>
                    <td style="padding:0.7rem 1rem;">€ 4,99</td>
                </tr>
            </tbody>
        </table>
    </div>

</div>
</main>
<%@ include file="../common/footer.jsp" %>