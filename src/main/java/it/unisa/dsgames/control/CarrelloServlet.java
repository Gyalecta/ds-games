package it.unisa.dsgames.control;

import it.unisa.dsgames.dao.DAOFactory;
import it.unisa.dsgames.dao.ProdottoDAO;
import it.unisa.dsgames.model.ItemCarrello;
import it.unisa.dsgames.model.Prodotto;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet {

    // Recupera il carrello dalla sessione, lo crea se non esiste
    @SuppressWarnings("unchecked")
    private Map<Integer, ItemCarrello> getCarrello(HttpSession session) {
        Map<Integer, ItemCarrello> carrello =
            (Map<Integer, ItemCarrello>) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new LinkedHashMap<>();
            session.setAttribute("carrello", carrello);
        }
        return carrello;
    }

    // Calcola il totale del carrello
    private double calcolaTotale(Map<Integer, ItemCarrello> carrello) {
        return carrello.values().stream()
            .mapToDouble(ItemCarrello::getSubtotale)
            .sum();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String azione = req.getParameter("azione");
        HttpSession session = req.getSession();
        Map<Integer, ItemCarrello> carrello = getCarrello(session);

        if (azione != null) {
            String idStr = req.getParameter("idProdotto");

            switch (azione) {

                case "aggiungi": {
                    if (idStr == null) break;
                    try {
                        int id = Integer.parseInt(idStr);
                        ProdottoDAO dao = DAOFactory.getProdottoDAO();
                        Prodotto prodotto = dao.doRetrieveById(id);

                        if (prodotto != null && !prodotto.isEliminato()
                                && prodotto.getQuantita() > 0) {

                            if (carrello.containsKey(id)) {
                                // Prodotto già nel carrello: incrementa quantità
                                ItemCarrello item = carrello.get(id);
                                int nuovaQt = item.getQuantita() + 1;
                                // Non superare la disponibilità
                                if (nuovaQt <= prodotto.getQuantita()) {
                                    item.setQuantita(nuovaQt);
                                }
                            } else {
                                carrello.put(id, new ItemCarrello(prodotto, 1));
                            }
                            session.setAttribute("carrello", carrello);
                        }
                    } catch (NumberFormatException |
                             SQLException | NamingException e) {
                        req.setAttribute("errore",
                            "Errore nell'aggiunta al carrello.");
                    }
                    // Torna alla pagina precedente
                    String referer = req.getHeader("Referer");
                    if (referer != null) {
                        resp.sendRedirect(referer);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/carrello");
                    }
                    return;
                }

                case "rimuovi": {
                    if (idStr != null) {
                        carrello.remove(Integer.parseInt(idStr));
                        session.setAttribute("carrello", carrello);
                    }
                    resp.sendRedirect(req.getContextPath() + "/carrello");
                    return;
                }

                case "svuota": {
                    carrello.clear();
                    session.setAttribute("carrello", carrello);
                    resp.sendRedirect(req.getContextPath() + "/carrello");
                    return;
                }
            }
        }

        // Mostra la pagina carrello
        req.setAttribute("carrello", carrello);
        req.setAttribute("totale", calcolaTotale(carrello));
        req.getRequestDispatcher("/WEB-INF/view/carrello.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Gestisce l'aggiornamento delle quantità dal form carrello
        HttpSession session = req.getSession();
        Map<Integer, ItemCarrello> carrello = getCarrello(session);

        String[] idProdotti = req.getParameterValues("idProdotto");
        String[] quantita   = req.getParameterValues("quantita");

        if (idProdotti != null && quantita != null) {
            for (int i = 0; i < idProdotti.length; i++) {
                try {
                    int id  = Integer.parseInt(idProdotti[i]);
                    int qty = Integer.parseInt(quantita[i]);

                    if (qty <= 0) {
                        carrello.remove(id);
                    } else if (carrello.containsKey(id)) {
                        ItemCarrello item = carrello.get(id);
                        // Non superare la disponibilità del prodotto
                        int maxQt = item.getProdotto().getQuantita();
                        item.setQuantita(Math.min(qty, maxQt));
                    }
                } catch (NumberFormatException ignored) {}
            }
            session.setAttribute("carrello", carrello);
        }

        resp.sendRedirect(req.getContextPath() + "/carrello");
    }
}