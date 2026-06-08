package it.unisa.dsgames.control;

import it.unisa.dsgames.dao.DAOFactory;
import it.unisa.dsgames.dao.ListaDesideriDAO;
import it.unisa.dsgames.model.Prodotto;
import it.unisa.dsgames.model.Utente;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Solo utenti loggati
        if (session == null || session.getAttribute("utente") == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=wishlist");
            return;
        }

        Utente utente = (Utente) session.getAttribute("utente");
        String azione  = req.getParameter("azione");
        String idStr   = req.getParameter("idProdotto");

        try {
            ListaDesideriDAO dao = DAOFactory.getListaDesideriDAO();

            if (azione != null && idStr != null && !idStr.isEmpty()) {
                int idProdotto = Integer.parseInt(idStr);

                switch (azione) {
                    case "aggiungi":
                        dao.doAdd(utente.getId(), idProdotto);
                        // Torna alla pagina prodotto
                        String referer = req.getHeader("Referer");
                        if (referer != null) {
                            resp.sendRedirect(referer);
                        } else {
                            resp.sendRedirect(
                                req.getContextPath() + "/wishlist");
                        }
                        return;

                    case "rimuovi":
                        dao.doRemove(utente.getId(), idProdotto);
                        resp.sendRedirect(req.getContextPath() + "/wishlist");
                        return;
                }
            }

            // Mostra la lista desideri
            List<Prodotto> lista = dao.doRetrieveByUtente(utente.getId());
            req.setAttribute("listaDesideri", lista);

        } catch (SQLException | NamingException e) {
            req.setAttribute("errore",
                "Errore nel caricamento della lista desideri.");
        }

        req.getRequestDispatcher("/WEB-INF/view/wishlist.jsp")
           .forward(req, resp);
    }
}