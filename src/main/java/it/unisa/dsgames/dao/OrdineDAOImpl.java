package it.unisa.dsgames.dao;

import it.unisa.dsgames.model.DettaglioOrdine;
import it.unisa.dsgames.model.Ordine;
import it.unisa.dsgames.model.Prodotto;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAOImpl implements OrdineDAO {

    private final DataSource dataSource;

    public OrdineDAOImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private Ordine mapRow(ResultSet rs) throws SQLException {
        Ordine o = new Ordine();
        o.setId(rs.getInt("id"));
        o.setIdUtente(rs.getInt("id_utente"));
        o.setDataOrdine(rs.getTimestamp("data_ordine"));
        o.setStato(Ordine.Stato.valueOf(rs.getString("stato")));
        o.setIndirizzoSped(rs.getString("indirizzo_sped"));
        o.setCittaSped(rs.getString("citta_sped"));
        o.setCapSped(rs.getString("cap_sped"));
        o.setMetodoPagamento(rs.getString("metodo_pagamento"));
        o.setTotale(rs.getDouble("totale"));
        return o;
    }

    @Override
    public int doSave(Ordine ordine) throws SQLException {
        String sqlOrdine = "INSERT INTO ordine (id_utente, stato, indirizzo_sped, " +
                           "citta_sped, cap_sped, metodo_pagamento, totale) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlDettaglio = "INSERT INTO dettaglio_ordine " +
                              "(id_ordine, id_prodotto, quantita, prezzo_acquisto) " +
                              "VALUES (?, ?, ?, ?)";

        try (Connection con = dataSource.getConnection()) {
            con.setAutoCommit(false); // transazione
            try {
                int idOrdine;
                try (PreparedStatement ps = con.prepareStatement(
                        sqlOrdine, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, ordine.getIdUtente());
                    ps.setString(2, Ordine.Stato.IN_ELABORAZIONE.name());
                    ps.setString(3, ordine.getIndirizzoSped());
                    ps.setString(4, ordine.getCittaSped());
                    ps.setString(5, ordine.getCapSped());
                    ps.setString(6, ordine.getMetodoPagamento());
                    ps.setDouble(7, ordine.getTotale());
                    ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        keys.next();
                        idOrdine = keys.getInt(1);
                        ordine.setId(idOrdine);
                    }
                }

                // Inserisce i dettagli dell'ordine
                try (PreparedStatement ps = con.prepareStatement(sqlDettaglio)) {
                    for (DettaglioOrdine d : ordine.getDettagli()) {
                        ps.setInt(1, idOrdine);
                        ps.setInt(2, d.getIdProdotto());
                        ps.setInt(3, d.getQuantita());
                        ps.setDouble(4, d.getPrezzoAcquisto());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }

                con.commit();
                return idOrdine;

            } catch (SQLException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    @Override
    public List<Ordine> doRetrieveByUtente(int idUtente) throws SQLException {
        List<Ordine> lista = new ArrayList<>();
        String sql = "SELECT * FROM ordine WHERE id_utente = ? ORDER BY data_ordine DESC";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapRow(rs));
            }
        }
        return lista;
    }

    @Override
    public List<Ordine> doRetrieveAll(Timestamp dal, Timestamp al,
                                      Integer idUtente) throws SQLException {
        List<Ordine> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT * FROM ordine WHERE 1=1");
        if (dal != null) sql.append(" AND data_ordine >= ?");
        if (al != null)  sql.append(" AND data_ordine <= ?");
        if (idUtente != null) sql.append(" AND id_utente = ?");
        sql.append(" ORDER BY data_ordine DESC");

        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            if (dal != null) ps.setTimestamp(idx++, dal);
            if (al != null)  ps.setTimestamp(idx++, al);
            if (idUtente != null) ps.setInt(idx, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapRow(rs));
            }
        }
        return lista;
    }

    @Override
    public Ordine doRetrieveById(int id) throws SQLException {
        String sqlOrdine = "SELECT * FROM ordine WHERE id = ?";
        String sqlDettagli = "SELECT d.*, p.nome, p.immagine FROM dettaglio_ordine d " +
                             "JOIN prodotto p ON d.id_prodotto = p.id WHERE d.id_ordine = ?";
        Ordine ordine = null;

        try (Connection con = dataSource.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement(sqlOrdine)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) ordine = mapRow(rs);
                }
            }
            if (ordine != null) {
                List<DettaglioOrdine> dettagli = new ArrayList<>();
                try (PreparedStatement ps = con.prepareStatement(sqlDettagli)) {
                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            DettaglioOrdine d = new DettaglioOrdine();
                            d.setIdOrdine(id);
                            d.setIdProdotto(rs.getInt("id_prodotto"));
                            d.setQuantita(rs.getInt("quantita"));
                            d.setPrezzoAcquisto(rs.getDouble("prezzo_acquisto"));
                            Prodotto p = new Prodotto();
                            p.setId(rs.getInt("id_prodotto"));
                            p.setNome(rs.getString("nome"));
                            p.setImmagine(rs.getString("immagine"));
                            d.setProdotto(p);
                            dettagli.add(d);
                        }
                    }
                }
                ordine.setDettagli(dettagli);
            }
        }
        return ordine;
    }

    @Override
    public void doUpdateStato(int idOrdine, Ordine.Stato stato) throws SQLException {
        String sql = "UPDATE ordine SET stato = ? WHERE id = ?";
        try (Connection con = dataSource.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, stato.name());
            ps.setInt(2, idOrdine);
            ps.executeUpdate();
        }
    }
}