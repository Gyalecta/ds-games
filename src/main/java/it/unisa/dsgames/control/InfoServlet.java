package it.unisa.dsgames.control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/chisiamo", "/spedizioni", "/privacy", "/contatti"})
public class InfoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();
        String pagina;

        if      (uri.endsWith("chisiamo"))  pagina = "chisiamo";
        else if (uri.endsWith("spedizioni")) pagina = "spedizioni";
        else if (uri.endsWith("privacy"))    pagina = "privacy";
        else                                 pagina = "contatti";

        req.getRequestDispatcher("/WEB-INF/view/info/" + pagina + ".jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Gestisce invio form contatti
        String nome    = req.getParameter("nome");
        String email   = req.getParameter("email");
        String oggetto = req.getParameter("oggetto");
        String messaggio = req.getParameter("messaggio");

        if (nome != null && email != null && messaggio != null
                && !nome.isEmpty() && !email.isEmpty() && !messaggio.isEmpty()) {
            req.setAttribute("successo",
                "Messaggio inviato correttamente. Ti risponderemo entro 24 ore.");
        } else {
            req.setAttribute("errore", "Compila tutti i campi obbligatori.");
        }

        req.getRequestDispatcher("/WEB-INF/view/info/contatti.jsp")
           .forward(req, resp);
    }
}