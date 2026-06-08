/**
 * DS Games — Funzionalità AJAX
 */

// Escaping HTML per evitare XSS e bug nei template literals
function escHtml(str) {
    if (!str) return '';
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

function getCtx() {
    return document.body.dataset.context || '';
}

// =============================================
// TOAST
// =============================================
function showToast(messaggio, tipo) {
    const esistente = document.getElementById('ds-toast');
    if (esistente) esistente.remove();

    if (!document.getElementById('toast-style')) {
        const style = document.createElement('style');
        style.id = 'toast-style';
        style.textContent = `
            @keyframes toastIn  { from { transform:translateX(110%); opacity:0; }
                                  to   { transform:translateX(0);    opacity:1; } }
            @keyframes toastOut { from { transform:translateX(0);    opacity:1; }
                                  to   { transform:translateX(110%); opacity:0; } }
        `;
        document.head.appendChild(style);
    }

    const colors = { success: '#2d7a3a', error: '#c0392b', info: '#0070d1' };
    const toast = document.createElement('div');
    toast.id = 'ds-toast';
    toast.textContent = messaggio;
    Object.assign(toast.style, {
        position:     'fixed',
        bottom:       '1.5rem',
        right:        '1.5rem',
        padding:      '0.75rem 1.25rem',
        borderRadius: '4px',
        fontSize:     '0.875rem',
        fontWeight:   '600',
        color:        '#fff',
        zIndex:       '9999',
        boxShadow:    '0 4px 16px rgba(0,0,0,0.3)',
        animation:    'toastIn 0.25s ease forwards',
        background:   colors[tipo] || colors.info,
        maxWidth:     '320px',
        lineHeight:   '1.4'
    });

    document.body.appendChild(toast);
    setTimeout(() => {
        toast.style.animation = 'toastOut 0.25s ease forwards';
        setTimeout(() => toast.remove(), 260);
    }, 3000);
}

// =============================================
// CARRELLO AJAX
// =============================================
function aggiungiAlCarrello(idProdotto, bottone) {
    const ctx = getCtx();
    if (bottone) { bottone.disabled = true; bottone.textContent = '...'; }

    fetch(ctx + '/ajax/carrello', {
        method:  'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body:    'azione=aggiungi&idProdotto=' + encodeURIComponent(idProdotto)
    })
    .then(r => {
        if (!r.ok) throw new Error('HTTP ' + r.status);
        return r.json();
    })
    .then(data => {
        if (data.success) {
            showToast(data.messaggio, 'success');
            aggiornaCartBadge(data.cartSize);
        } else {
            showToast(data.messaggio, 'error');
        }
    })
    .catch(() => showToast('Errore di connessione al server.', 'error'))
    .finally(() => {
        if (bottone) {
            bottone.disabled = false;
            bottone.textContent = 'Aggiungi al carrello';
        }
    });
}

function aggiornaCartBadge(size) {
    let badge = document.querySelector('.cart-badge');
    if (size > 0) {
        if (!badge) {
            badge = document.createElement('span');
            badge.className = 'cart-badge';
            const icon = document.querySelector('.cart-icon');
            if (icon) icon.appendChild(badge);
        }
        badge.textContent = size;
    } else if (badge) {
        badge.remove();
    }
}

// =============================================
// WISHLIST AJAX
// =============================================
function toggleWishlist(idProdotto, bottone) {
    const ctx       = getCtx();
    const inWishlist = bottone.dataset.inWishlist === 'true';
    const azione    = inWishlist ? 'rimuovi' : 'aggiungi';

    fetch(ctx + '/ajax/wishlist', {
        method:  'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body:    'azione=' + azione + '&idProdotto=' + encodeURIComponent(idProdotto)
    })
    .then(r => {
        if (!r.ok) throw new Error('HTTP ' + r.status);
        return r.json();
    })
    .then(data => {
        if (data.loginRequired) {
            window.location.href = ctx + '/login';
            return;
        }
        if (data.success) {
            bottone.dataset.inWishlist = data.inWishlist ? 'true' : 'false';
            bottone.classList.toggle('wishlist-active', data.inWishlist);
            bottone.title = data.inWishlist
                ? 'Rimuovi dalla lista desideri'
                : 'Aggiungi alla lista desideri';
            showToast(data.messaggio, data.inWishlist ? 'success' : 'info');
        } else {
            showToast(data.messaggio, 'error');
        }
    })
    .catch(() => showToast('Errore di connessione al server.', 'error'));
}

// =============================================
// RICERCA REAL-TIME
// =============================================
function buildProductCard(p, ctx) {
    const prezzoHtml = p.inOfferta
        ? `<span class="price-current">&euro;${p.prezzoEffettivo.toFixed(2)}</span>
           <span class="price-original">&euro;${p.prezzo.toFixed(2)}</span>
           <span class="badge-sale">OFFERTA</span>`
        : `<span class="price-current">&euro;${p.prezzoEffettivo.toFixed(2)}</span>`;

    const imgHtml = p.immagine
        ? `<img class="product-card-img"
               src="${ctx}/images/prodotti/${escHtml(p.immagine)}"
               alt="${escHtml(p.nome)}"
               loading="lazy">`
        : `<div class="product-card-img-placeholder">
               <span class="placeholder-label">${escHtml(p.categoria)}</span>
           </div>`;

    const btnCarrello = p.quantita > 0
        ? `<button class="btn btn-cart btn-sm"
                   data-id="${p.id}"
                   onclick="aggiungiAlCarrello(${p.id}, this)">
               Aggiungi
           </button>`
        : `<span class="sold-out-label">Esaurito</span>`;

    return `
        <article class="product-card">
            <a href="${ctx}/prodotto?id=${p.id}" class="product-card-img-link">
                ${imgHtml}
            </a>
            <div class="product-card-body">
                <span class="product-card-category">${escHtml(p.categoria)}</span>
                <a href="${ctx}/prodotto?id=${p.id}" class="product-card-name">
                    ${escHtml(p.nome)}
                </a>
                <span class="product-card-platform">${escHtml(p.piattaforma || '')}</span>
                <div class="product-card-price">${prezzoHtml}</div>
            </div>
            <div class="product-card-footer">
                <a href="${ctx}/prodotto?id=${p.id}" class="btn btn-details btn-sm">
                    Dettagli
                </a>
                ${btnCarrello}
            </div>
        </article>`;
}

function initRicercaAjax() {
    const input    = document.getElementById('inputRicerca');
    const grid     = document.getElementById('gridProdotti');
    const contatore = document.getElementById('contatoreProdotti');
    if (!input || !grid) return;

    const ctx = getCtx();
    let timer = null;

    input.addEventListener('input', function () {
        clearTimeout(timer);
        timer = setTimeout(() => {
            const q          = this.value.trim();
            const categoria  = (document.querySelector('input[name="categoria"]:checked') || {}).value || '';
            const piattaforma = (document.getElementById('selectPiattaforma') || {}).value || '';

            grid.innerHTML = '<div class="search-loading">Ricerca in corso...</div>';

            const params = new URLSearchParams({ q, categoria, piattaforma });

            fetch(ctx + '/ajax/ricerca?' + params.toString())
            .then(r => {
                if (!r.ok) throw new Error('HTTP ' + r.status);
                return r.json();
            })
            .then(data => {
                if (!data.success) {
                    grid.innerHTML = '<div class="alert alert-error">Errore nella ricerca.</div>';
                    return;
                }
                if (contatore) {
                    contatore.textContent = data.totale + (data.totale === 1 ? ' prodotto' : ' prodotti');
                }
                if (data.prodotti.length === 0) {
                    grid.innerHTML = `
                        <div class="empty-results">
                            <p class="empty-results-title">Nessun prodotto trovato</p>
                            <p>Prova a modificare i termini di ricerca.</p>
                        </div>`;
                    return;
                }
                grid.innerHTML = data.prodotti.map(p => buildProductCard(p, ctx)).join('');
            })
            .catch(() => {
                grid.innerHTML = '<div class="alert alert-error">Errore di connessione.</div>';
            });
        }, 400);
    });
}

document.addEventListener('DOMContentLoaded', initRicercaAjax);